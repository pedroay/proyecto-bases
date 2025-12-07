-- Archivo: SeguridadAdminOK.sql

DECLARE
    v_new_persona_doc NUMBER := 444444444;
    v_new_doctor_doc NUMBER := 555555555;
    v_new_cita_admin NUMBER;
    v_dummy NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS PKG_ADMIN_ACCESS OK ---');

    -- SETUP: Garantizar datos previos
    BEGIN
        -- 1. Areas
        BEGIN
            INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Pediatría', 'Pediatría', 10);
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

        -- 2. Doctor (ID: 1013259702)
        BEGIN
            SELECT 1 INTO v_dummy FROM pyd_Doctores WHERE Id_Doctor = 1013259702;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
                INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
                VALUES (1013259703, 'CC', 'Doc', 'Base', 'doc@base.com');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
            
            BEGIN
                INSERT INTO pyd_Doctores (Id_Doctor, Especialidad, Area_Especialidad, Numero_Doc)
                VALUES (1013259702, 'Pediatría', 'Pediatría', 1013259703);
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        END;

        -- 3. Paciente (ID: 1013259705)
        BEGIN
            SELECT 1 INTO v_dummy FROM pyd_Pacientes WHERE Id_Paciente = 1013259705;
        EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
                VALUES (1013259704, 'CC', 'Pac', 'Base', 'pac@base.com');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

            BEGIN
                INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (1013259705, 'SURA', 'SURA EPS');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

            BEGIN
                INSERT INTO pyd_Pacientes (Id_Paciente, Id_Eps, Eps, Numero_Doc) VALUES (1013259705, 123, 'SURA', 1013259704);
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        END;
    END;
    
    -- 1. Alta de una Persona (Llama a PKG_PERSONAS.P_CREAR_PERSONA)
    -- Limpieza previa por si se corre varias veces
    DELETE FROM pyd_Personas WHERE Numero_doc IN (v_new_persona_doc, v_new_doctor_doc);
    
    PKG_ADMIN_ACCESS.P_ALTA_PERSONA(
        p_numero_doc => v_new_persona_doc,
        p_tipo_documento => 'CC',
        p_primer_nombre => 'Roberto',
        p_primer_apellido => 'García',
        p_correo_electronico => 'roberto.g@mail.com'
    );
    DBMS_OUTPUT.PUT_LINE('OK 1: Administrativo registra Persona: ' || v_new_persona_doc);

    -- 2. Alta de un Paciente (Llama a PKG_PERSONAS.P_CREAR_PACIENTE)
    PKG_ADMIN_ACCESS.P_ALTA_PACIENTE(
        p_numero_doc => v_new_persona_doc,
        p_id_eps => 54321,
        p_eps => 'NuevaEPS'
    );
    DBMS_OUTPUT.PUT_LINE('OK 2: Administrativo registra Paciente para Doc: ' || v_new_persona_doc);
    
    -- 3. Alta de un Doctor (Llama a PKG_PERSONAS.P_CREAR_DOCTOR)
    PKG_ADMIN_ACCESS.P_ALTA_PERSONA(
        p_numero_doc => v_new_doctor_doc,
        p_tipo_documento => 'CC',
        p_primer_nombre => 'Sofía',
        p_primer_apellido => 'Díaz',
        p_correo_electronico => 'sofia.d@clinic.com'
    );
    PKG_ADMIN_ACCESS.P_ALTA_DOCTOR(
        p_numero_doc => v_new_doctor_doc,
        p_especialidad => 'Pediatría General',
        p_area_especialidad => 'Pediatría'
    );
    DBMS_OUTPUT.PUT_LINE('OK 3: Administrativo registra Doctor para Doc: ' || v_new_doctor_doc);
    
    -- 4. Cancelar una Cita (Llama a PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_new_cita_admin FROM DUAL;
    -- Primero creamos una cita (usando el procedimiento delegado)
    PKG_ADMIN_ACCESS.P_AGENDAR_CITA(v_new_cita_admin, 1013259705, TIMESTAMP '2026-04-02 11:00:00', DATE '2026-04-02', 1013259702, 'Pendiente');
    
    PKG_ADMIN_ACCESS.P_CANCELAR_CITA(v_new_cita_admin);
    DBMS_OUTPUT.PUT_LINE('OK 4: Administrativo cancela Cita: ' || v_new_cita_admin);

    COMMIT;
END;
/