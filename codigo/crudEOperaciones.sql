-- Archivo: crudOperacionesE.sql

CREATE OR REPLACE PACKAGE PKG_OPERACIONES_CLINICAS AS
    
    -- Tipo Record para representar una Cita
    TYPE rec_cita IS RECORD (
        Id_Cita         PYD_Citas.Id_Cita%TYPE,
        Id_Paciente     PYD_Citas.Id_Paciente%TYPE,
        Hora_Cita       PYD_Citas.Hora_Cita%TYPE,
        Fecha_Cita      PYD_Citas.Fecha_Cita%TYPE,
        Id_Doctor       PYD_Citas.Id_Doctor%TYPE,
        Diagnostico     PYD_Citas.Diagnostico%TYPE,
        Estado_Cita     PYD_Citas.Estado_Cita%TYPE
    );

    -- Tipo Cursor para recuperar Citas
    TYPE cur_citas IS REF CURSOR RETURN rec_cita;

    -----------------------------------------------------
    -- Procedimientos CRUD para PYD_CITAS
    -----------------------------------------------------
    
    -- Crear una nueva cita
    PROCEDURE P_CREAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_id_paciente   IN PYD_Citas.Id_Paciente%TYPE,
        p_hora_cita     IN PYD_Citas.Hora_Cita%TYPE,
        p_fecha_cita    IN PYD_Citas.Fecha_Cita%TYPE,
        p_id_doctor     IN PYD_Citas.Id_Doctor%TYPE,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE
    );

    -- Leer una cita por ID
    PROCEDURE P_LEER_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_cursor_out    OUT cur_citas
    );
    
    -- Actualizar el estado y/o diagnóstico de una cita
    PROCEDURE P_ACTUALIZAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_diagnostico   IN PYD_Citas.Diagnostico%TYPE DEFAULT NULL,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE DEFAULT NULL
    );

    -- ... Otros procedimientos para Historias Clínicas y Visitas ...

END PKG_OPERACIONES_CLINICAS;
/