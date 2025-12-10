

CREATE OR REPLACE PACKAGE BODY PKG_OPERACIONES_CLINICAS AS

    -----------------------------------------------------
    -- Implementación de P_CREAR_CITA
    -----------------------------------------------------
    PROCEDURE P_CREAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_id_paciente   IN PYD_Citas.Id_Paciente%TYPE,
        p_hora_cita     IN PYD_Citas.Hora_Cita%TYPE,
        p_fecha_cita    IN PYD_Citas.Fecha_Cita%TYPE,
        p_id_doctor     IN PYD_Citas.Id_Doctor%TYPE,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE
    )
    IS
    BEGIN
        INSERT INTO PYD_Citas (
            Id_Cita, Id_Paciente, Hora_Cita, Fecha_Cita, Id_Doctor, Diagnostico, Estado_Cita
        ) VALUES (
            p_id_cita, p_id_paciente, p_hora_cita, p_fecha_cita, p_id_doctor, NULL, p_estado_cita
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20101, 'Error al crear cita: ' || SQLERRM);
    END P_CREAR_CITA;

    -----------------------------------------------------
    -- Implementación de P_LEER_CITA
    -----------------------------------------------------
    PROCEDURE P_LEER_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_cursor_out    OUT cur_citas
    )
    IS
    BEGIN
        OPEN p_cursor_out FOR
            SELECT 
                Id_Cita, Id_Paciente, Hora_Cita, Fecha_Cita, Id_Doctor, Diagnostico, Estado_Cita
            FROM PYD_Citas
            WHERE Id_Cita = p_id_cita;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20102, 'Error al leer cita: ' || SQLERRM);
    END P_LEER_CITA;

    -----------------------------------------------------
    -- Implementación de P_ACTUALIZAR_CITA
    -----------------------------------------------------
    PROCEDURE P_ACTUALIZAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_diagnostico   IN PYD_Citas.Diagnostico%TYPE DEFAULT NULL,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE DEFAULT NULL
    )
    IS
    BEGIN
        UPDATE PYD_Citas
        SET
            Diagnostico = NVL(p_diagnostico, Diagnostico),
            Estado_Cita = NVL(p_estado_cita, Estado_Cita)
        WHERE Id_Cita = p_id_cita;

        IF SQL%ROWCOUNT = 0 THEN
             RAISE_APPLICATION_ERROR(-20103, 'Error: Cita con ID ' || p_id_cita || ' no encontrada para actualizar.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20104, 'Error al actualizar cita: ' || SQLERRM);
    END P_ACTUALIZAR_CITA;

    -- ... Implementación de los demás procedimientos ...

END PKG_OPERACIONES_CLINICAS;
/