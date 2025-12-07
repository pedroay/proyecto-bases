DECLARE
    v_id_cita NUMBER;
    v_id_paciente_dummy NUMBER := 99999;
    v_id_doctor_dummy NUMBER := 88888;
    v_dummy NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS CRUD NO OK PKG_OPERACIONES_CLINICAS ---');
    
    -- SETUP
    BEGIN
        -- Doctor (ID: 1013259702)
        BEGIN
            SELECT 1 INTO v_dummy FROM pyd_Doctores WHERE Id_Doctor = 1013259702;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
                INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
                VALUES (1013259703, 'CC', 'Doc', 'Base', 'doc@base.com');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
            
            BEGIN
                INSERT INTO pyd_Doctores (Id_Doctor, Especialidad, Area_Especialidad, Numero_Doc)
                VALUES (1013259702, 'Cardiología', 'Cardiología', 1013259703);
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        END;

        -- Paciente (ID: 1013259705)
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

    -- 1. ERROR: Violación de la FK (FK_CITA_DOCTOR)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    BEGIN
        PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
            p_id_cita => v_id_cita,
            p_id_paciente => 1013259705, -- OK
            p_hora_cita => TIMESTAMP '2026-03-11 10:00:00',
            p_fecha_cita => DATE '2026-03-11',
            p_id_doctor => v_id_doctor_dummy, -- NO EXISTE
            p_estado_cita => 'Pendiente'
        );
        DBMS_OUTPUT.PUT_LINE('FALLO 1: La operacion deberia haber fallado (FK_CITA_DOCTOR).');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EXITO 1: Capturado (FK Doctor): ' || SQLERRM);
    END;

    -- 2. ERROR: Violación de la FK (FK_CITA_PACIENTE)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    BEGIN
        PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
            p_id_cita => v_id_cita,
            p_id_paciente => v_id_paciente_dummy, -- NO EXISTE
            p_hora_cita => TIMESTAMP '2026-03-12 10:00:00',
            p_fecha_cita => DATE '2026-03-12',
            p_id_doctor => 1013259702, -- OK
            p_estado_cita => 'Pendiente'
        );
        DBMS_OUTPUT.PUT_LINE('FALLO 2: La operacion deberia haber fallado (FK_CITA_PACIENTE).');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EXITO 2: Capturado (FK Paciente): ' || SQLERRM);
    END;

    -- 3. VALIDACIÓN DE INTEGRIDAD REFERENCIAL (FK_CITA_DOCTOR ON DELETE CASCADE)
    -- Insertamos una cita y luego borramos al doctor. La cita debe desaparecer.
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
        p_id_cita => v_id_cita,
        p_id_paciente => 1013259705, 
        p_hora_cita => TIMESTAMP '2026-03-13 10:00:00',
        p_fecha_cita => DATE '2026-03-13',
        p_id_doctor => 1013259702, -- Doctor existe
        p_estado_cita => 'Pendiente'
    );
    
    -- Ejecutamos la eliminación del doctor (fuera del package, solo para prueba de FK)
    DELETE FROM pyd_Doctores WHERE Id_Doctor = 1013259702;
    
    SELECT COUNT(*) INTO v_id_doctor_dummy FROM pyd_Citas WHERE Id_Cita = v_id_cita;
    
    IF v_id_doctor_dummy = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EXITO 3 (FK CASCADE): Eliminación exitosa. La Cita (' || v_id_cita || ') fue eliminada por CASCADE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FALLO 3 (FK CASCADE): La Cita no fue eliminada.');
    END IF;

    ROLLBACK; -- Deshacer la eliminación del doctor
END;
/