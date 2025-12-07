-- CONFIGURACIÓN INICIAL (Necesario para los ejemplos)
-- Se requiere una tupla base en pyd_Areas y pyd_Turnos
BEGIN
    INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Cardiología', 'Cardiología', 20);
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
/
BEGIN
    INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Pediatría', 'Pediatría General', 15);
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
/
BEGIN
    INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (1, 'Diurno', DATE '2025-01-01', DATE '2025-01-01' + 0.5);
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
/
COMMIT;

DECLARE
    v_id_doctor NUMBER;
    v_id_enfermera NUMBER;
    v_id_paciente NUMBER;
    v_id_historia NUMBER;
BEGIN
    -- 1. CREAR PERSONA Y DOCTOR (Validación CHK_TIPO_DOC_VALIDO y Trg_check_doctor_area)
    PKG_PERSONAS.P_CREAR_PERSONA(
        p_numero_doc => 101010101, p_tipo_documento => 'CC', p_primer_nombre => 'Carlos', 
        p_segundo_nombre => 'Andrés', p_primer_apellido => 'Rojas', p_segundo_apellido => 'Gómez', 
        p_correo_electronico => 'carlos.rojas@clinic.com'
    );

    PKG_PERSONAS.P_CREAR_DOCTOR(
        p_numero_doc => 101010101, p_especialidad => 'Cardiología', 
        p_area_especialidad => 'Cardiología', p_t_turno => 1, 
        p_id_doctor_out => v_id_doctor
    );
    DBMS_OUTPUT.PUT_LINE('OK 1: Doctor Creado con ID: ' || v_id_doctor);

    -- 2. CREAR PERSONA Y ENFERMERA
    PKG_PERSONAS.P_CREAR_PERSONA(
        p_numero_doc => 202020202, p_tipo_documento => 'CC', p_primer_nombre => 'Diana', 
        p_segundo_nombre => NULL, p_primer_apellido => 'Pérez', p_segundo_apellido => 'López', 
        p_correo_electronico => 'diana.perez@clinic.com'
    );

    PKG_PERSONAS.P_CREAR_ENFERMERA(
        p_numero_doc => 202020202, p_area => 'Pediatría', p_turno => 1, 
        p_id_enfermera_out => v_id_enfermera
    );
    DBMS_OUTPUT.PUT_LINE('OK 2: Enfermera Creada con ID: ' || v_id_enfermera);
    
    -- 3. CREAR PERSONA Y PACIENTE (Asumiendo que Id_Historia y Id_Paciente son la misma PK/FK)
    SELECT SEQ_HISTORIA_ID.NEXTVAL INTO v_id_historia FROM DUAL;
    INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) 
    VALUES (v_id_historia, 'SURA', 'SURA EPS');

    PKG_PERSONAS.P_CREAR_PERSONA(
        p_numero_doc => 303030303, p_tipo_documento => 'CC', p_primer_nombre => 'Laura', 
        p_primer_apellido => 'Martínez', p_correo_electronico => 'laura.m@mail.com'
    );
    
    PKG_PERSONAS.P_CREAR_PACIENTE(
        p_numero_doc => 303030303, p_id_eps => 12345, p_eps => 'SURA',
        p_id_paciente_out => v_id_paciente -- v_id_paciente debe ser v_id_historia por la FK: FK_PACIENTE_HISTORIA
    );
    -- NOTA: Asumo que en tu diseño Id_Paciente de pyd_Pacientes es referenciado por Id_Historia. Si son diferentes, se debe usar otra secuencia.
    -- Aquí forzamos que el Id_Paciente sea el Id_Historia, como indica tu FK.
    UPDATE pyd_Pacientes SET Id_Paciente = v_id_historia WHERE Numero_Doc = 303030303;
    v_id_paciente := v_id_historia;

    DBMS_OUTPUT.PUT_LINE('OK 3: Paciente Creado con ID: ' || v_id_paciente || ' e Historia: ' || v_id_historia);
    COMMIT;
END;
/