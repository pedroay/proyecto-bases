DECLARE
    v_id_cita NUMBER;
    v_id_paciente_dummy NUMBER := 99999;
    v_id_doctor_dummy NUMBER := 88888;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS CRUD NO OK PKG_OPERACIONES_CLINICAS ---');
    
    -- 1. ERROR: Violación de la FK (FK_CITA_DOCTOR)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    BEGIN
        PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
            p_id_cita => v_id_cita,
            p_id_paciente => 1, -- OK
            p_hora_cita => TIMESTAMP '2026-03-11 10:00:00',
            p_fecha_cita => DATE '2026-03-11',
            p_id_doctor => v_id_doctor_dummy, -- NO EXISTE
            p_estado_cita => 'Pendiente'
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('No OK 1: Capturado (FK Doctor): ' || SQLERRM);
    END;

    -- 2. ERROR: Violación de la FK (FK_CITA_PACIENTE)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    BEGIN
        PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
            p_id_cita => v_id_cita,
            p_id_paciente => v_id_paciente_dummy, -- NO EXISTE
            p_hora_cita => TIMESTAMP '2026-03-12 10:00:00',
            p_fecha_cita => DATE '2026-03-12',
            p_id_doctor => 1, -- OK
            p_estado_cita => 'Pendiente'
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('No OK 2: Capturado (FK Paciente): ' || SQLERRM);
    END;

    -- 3. VALIDACIÓN DE INTEGRIDAD REFERENCIAL (FK_CITA_DOCTOR ON DELETE CASCADE)
    -- Insertamos una cita y luego borramos al doctor. La cita debe desaparecer.
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
        p_id_cita => v_id_cita,
        p_id_paciente => 1, 
        p_hora_cita => TIMESTAMP '2026-03-13 10:00:00',
        p_fecha_cita => DATE '2026-03-13',
        p_id_doctor => 1, -- Doctor 1 existe
        p_estado_cita => 'Pendiente'
    );
    
    -- Ejecutamos la eliminación del doctor (fuera del package, solo para prueba de FK)
    DELETE FROM pyd_Doctores WHERE Id_Doctor = 1;
    
    SELECT COUNT(*) INTO v_id_doctor_dummy FROM pyd_Citas WHERE Id_Cita = v_id_cita;
    
    IF v_id_doctor_dummy = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No OK 3 (FK CASCADE): Eliminación exitosa. La Cita (' || v_id_cita || ') fue eliminada por CASCADE.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No OK 3 (FK CASCADE): FALLÓ. La Cita no fue eliminada.');
    END IF;

    ROLLBACK; -- Deshacer la eliminación del doctor
END;
/