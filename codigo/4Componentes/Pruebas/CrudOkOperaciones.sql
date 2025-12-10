-- REQUERIMIENTOS (Obtener IDs de los objetos creados anteriormente)
-- Doctor ID 101010101: v_id_doctor (Supongamos que es 1)
-- Paciente ID 303030303: v_id_paciente (Supongamos que es 1)
-- Asumiendo que Id_Doctor=1 e Id_Paciente=1 existen y están activos.
DECLARE
    v_id_cita NUMBER;
    v_dummy NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS CRUD OK PKG_OPERACIONES_CLINICAS ---');
    
    -- SETUP
    BEGIN
        -- Areas
        BEGIN
            INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Cardiología', 'Cardiología', 20);
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        
        -- Doctor (ID: 1013259702, Persona: 1013259703)
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

        -- Paciente (ID: 1013259705, Persona: 1013259704)
        -- Usaremos ID Paciente 1013259705 para evitar conflicto con ID 1 si ya existe
        BEGIN
            SELECT 1 INTO v_dummy FROM pyd_Pacientes WHERE Id_Paciente = 1013259705;
        EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
                VALUES (1013259704, 'CC', 'Pac', 'Base', 'pac@base.com');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

            -- Historia Clinica (FK de Paciente muchas veces)
            BEGIN
                INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (1013259705, 'SURA', 'SURA EPS');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

            BEGIN
                INSERT INTO pyd_Pacientes (Id_Paciente, Id_Eps, Eps, Numero_Doc) VALUES (1013259705, 123, 'SURA', 1013259704);
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        END;
    END;

    -- 1. CREAR CITA PENDIENTE
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
        p_id_cita => v_id_cita,
        p_id_paciente => 1013259705, -- Usando ID verificado
        p_hora_cita => TIMESTAMP '2026-03-10 10:00:00',
        p_fecha_cita => DATE '2026-03-10',
        p_id_doctor => 1013259702, -- Usando ID verificado
        p_estado_cita => 'Pendiente'
    );
    DBMS_OUTPUT.PUT_LINE('OK 1: Cita ' || v_id_cita || ' Creada. Estado: Pendiente.');

    -- 2. COMPLETAR CITA (Activa trg_actualizar_estado_cita)
    PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA(
        p_id_cita => v_id_cita,
        p_diagnostico => 'Resfriado común, Recetar Acetaminofén.',
        p_estado_cita => 'Pendiente' -- Se pasa Pendiente, pero el trigger lo corregirá a Completada.
    );
    -- Verificación (Manual) del estado: Debería ser 'Completada'
    DBMS_OUTPUT.PUT_LINE('OK 2: Cita ' || v_id_cita || ' Actualizada con Diagnóstico. (Trigger ejecutado)');

    -- 3. BORRAR DIAGNÓSTICO (Activa trg_actualizar_estado_cita, revierte estado)
    PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA(
        p_id_cita => v_id_cita,
        p_diagnostico => NULL, -- Borrar el diagnóstico
        p_estado_cita => NULL -- Dejar que el trigger actúe
    );
    -- Verificación (Manual) del estado: Debería ser 'Pendiente' nuevamente
    DBMS_OUTPUT.PUT_LINE('OK 3: Cita ' || v_id_cita || ' Diagnóstico borrado. (Trigger revierte a Pendiente)');

    COMMIT;
END;
/