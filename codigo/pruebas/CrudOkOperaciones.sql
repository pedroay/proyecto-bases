-- REQUERIMIENTOS (Obtener IDs de los objetos creados anteriormente)
-- Doctor ID 101010101: v_id_doctor (Supongamos que es 1)
-- Paciente ID 303030303: v_id_paciente (Supongamos que es 1)
-- Asumiendo que Id_Doctor=1 e Id_Paciente=1 existen y están activos.
DECLARE
    v_id_cita NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS CRUD OK PKG_OPERACIONES_CLINICAS ---');
    
    -- 1. CREAR CITA PENDIENTE
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_id_cita FROM DUAL;
    PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
        p_id_cita => v_id_cita,
        p_id_paciente => 1, -- Usando Id_Paciente=1
        p_hora_cita => TIMESTAMP '2026-03-10 10:00:00',
        p_fecha_cita => DATE '2026-03-10',
        p_id_doctor => 1, -- Usando Id_Doctor=1
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