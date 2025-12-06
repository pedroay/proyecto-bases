DECLARE
    v_id_enfermera NUMBER;
    v_dummy_id NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS CRUD NO OK PKG_PERSONAS ---');

    -- 1. ERROR: Violación de CHK_TIPO_DOC_VALIDO (Documento muy corto para CC)
    BEGIN
        PKG_PERSONAS.P_CREAR_PERSONA(
            p_numero_doc => 12345, p_tipo_documento => 'CC', p_primer_nombre => 'Falla', 
            p_primer_apellido => 'Check', p_correo_electronico => 'falla1@mail.com'
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('No OK 1: Capturado: ' || SQLERRM);
    END;

    -- 2. ERROR: Violación del Trigger trg_check_doctor_area
    -- Usamos la persona creada en el ejemplo OK 1 (101010101)
    BEGIN
        PKG_PERSONAS.P_CREAR_DOCTOR(
            p_numero_doc => 101010101, p_especialidad => 'Cardiología', 
            p_area_especialidad => 'Pediatría', p_t_turno => 1, 
            p_id_doctor_out => v_dummy_id
        );
    EXCEPTION
        WHEN OTHERS THEN
            -- Esperamos el error -20001 lanzado por el trigger
            DBMS_OUTPUT.PUT_LINE('No OK 2: Capturado: ' || SQLERRM);
    END;

    -- 3. ERROR: Violación de la FK (FK_ENFERMERA_PERSONA)
    BEGIN
        PKG_PERSONAS.P_CREAR_ENFERMERA(
            p_numero_doc => 999999999, -- Documento que NO existe en pyd_Personas
            p_area => 'Pediatría', p_turno => 1, 
            p_id_enfermera_out => v_id_enfermera
        );
    EXCEPTION
        WHEN OTHERS THEN
            -- Esperamos ORA-02291: integrity constraint violated - parent key not found
            DBMS_OUTPUT.PUT_LINE('No OK 3: Capturado: ' || SQLERRM);
    END;
    
    ROLLBACK; -- Deshacer cambios de las pruebas NO OK
END;
/