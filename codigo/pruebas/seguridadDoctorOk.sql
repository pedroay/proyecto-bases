-- SCRIPT DE PRUEBA CORREGIDO: SeguridadDoctorOK.sql

-- Se asume que el Doctor 1, Paciente 1 e Historia 1 se crearon en las pruebas OK de PKG_PERSONAS.
-- Si no es así, debemos crearlos o verificar el ID generado.

DECLARE
    -- VARIABLES PARA CAPTURAR LOS IDs REALES CREADOS:
    v_doctor_id     NUMBER := 1013259701; -- Asumimos que es 1013259701, pero lo buscamos
    v_paciente_id   NUMBER := 1013259703; -- Asumimos que es 1013259703, pero lo buscamos
    v_historia_id   NUMBER := 1013259703;
    
    -- Variables para la prueba
    v_new_cita_id   PYD_Citas.Id_Cita%TYPE;
    v_new_visita_id PYD_Visitas.Id_Visita%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS PKG_DOCTOR_ACCESS OK ---');
    
    BEGIN
      SELECT Id_Doctor INTO v_doctor_id FROM pyd_Doctores WHERE Id_Doctor = 1013259701;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Advertencia: Doctor 1013259701 no encontrado. Insertando datos base (asumiendo que Doc 101010101 existe en Personas).');
        -- Insertar Área Cardiología
        INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Cardiología', 'Cardiología', 10);
        INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo_electronico) 
        VALUES (1013259701, 'CC', 'Juan', 'Pérez', 'García', NULL, 'juanDoctor.perez@example.com');
        INSERT INTO pyd_Doctores (Id_Doctor, Especialidad, Area_Especialidad, Numero_Doc)
        VALUES (1013259701, 'Cardiología', 'Cardiología', 1013259701); 
        v_doctor_id := 1013259701;

        -- Insertar Paciente 1 e Historia 1 (Si no existen)
        INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (1013259703, 'SURA', 'SURA EPS');
        INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo_electronico) 
        VALUES (1013259703, 'CC', 'Juan', 'Pérez', 'García', NULL, 'juan.perez@example.com');
        INSERT INTO pyd_Pacientes (Id_Paciente, Id_Eps, Eps, Numero_Doc) VALUES (1013259703, 12345, 'SURA', 1013259703);
        v_paciente_id := 1013259703;
        v_historia_id := 1013259703;
    END;


    -- 1. Agendar una Cita (Llama a PKG_OPERACIONES_CLINICAS.P_CREAR_CITA)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_new_cita_id FROM DUAL;
    PKG_DOCTOR_ACCESS.P_AGENDAR_CITA(
      p_id_cita => v_new_cita_id,
      p_id_paciente => v_paciente_id,  -- Usamos el ID verificado
      p_hora_cita => TIMESTAMP '2026-04-01 09:00:00',
        p_fecha_cita => DATE '2026-04-01',
        p_id_doctor => v_doctor_id,      -- Usamos el ID verificado
        p_estado_cita => 'Pendiente'
    );
    DBMS_OUTPUT.PUT_LINE('OK 1: Doctor agenda Cita ' || v_new_cita_id);

    -- 2. Completar Cita y registrar Diagnóstico
    PKG_DOCTOR_ACCESS.P_COMPLETAR_CITA(
        p_id_cita => v_new_cita_id,
        p_diagnostico => 'Control post-operatorio OK.'
    );
    DBMS_OUTPUT.PUT_LINE('OK 2: Doctor completa Cita ' || v_new_cita_id);

    -- 3. Registrar una Visita
    SELECT SEQ_VISITA_ID.NEXTVAL INTO v_new_visita_id FROM DUAL;
    PKG_DOCTOR_ACCESS.P_REGISTRAR_VISITA(
        p_id_visita => v_new_visita_id,
        p_fecha => SYSDATE,
        p_sintomas => 'Dolor de cabeza leve.',
        p_diagnostico => 'Migraña común.',
        p_tratamiento => 'Reposo y analgésicos.',
        p_id_historia => v_historia_id -- Id_Historia verificado
    );
    DBMS_OUTPUT.PUT_LINE('OK 3: Doctor registra Visita ' || v_new_visita_id);
    
    COMMIT;
END;
/