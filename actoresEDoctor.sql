
CREATE OR REPLACE PACKAGE PKG_DOCTOR_ACCESS AS
    
    -----------------------------------------------------
    -- GESTIÓN DE CITAS (Usa PKG_OPERACIONES_CLINICAS)
    -----------------------------------------------------
    
    -- Agenda una nueva cita (El doctor la puede crear)
    PROCEDURE P_AGENDAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_id_paciente   IN PYD_Citas.Id_Paciente%TYPE,
        p_hora_cita     IN PYD_Citas.Hora_Cita%TYPE,
        p_fecha_cita    IN PYD_Citas.Fecha_Cita%TYPE,
        p_id_doctor     IN PYD_Citas.Id_Doctor%TYPE,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE
    );

    -- Marcar una cita como completada y registrar el diagnóstico
    PROCEDURE P_COMPLETAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_diagnostico   IN PYD_Citas.Diagnostico%TYPE
    );

    -----------------------------------------------------
    -- GESTIÓN DE VISITAS/HISTORIA CLÍNICA (Usa PKG_OPERACIONES_CLINICAS)
    -----------------------------------------------------
    
    -- Registrar una nueva visita para una historia clínica
    PROCEDURE P_REGISTRAR_VISITA (
        p_id_visita     IN PYD_Visitas.Id_Visita%TYPE,
        p_fecha         IN PYD_Visitas.Fecha%TYPE,
        p_sintomas      IN PYD_Visitas.Sintomas%TYPE,
        p_examen        IN PYD_Visitas.Examen%TYPE DEFAULT NULL,
        p_diagnostico   IN PYD_Visitas.Diagnostico%TYPE,
        p_tratamiento   IN PYD_Visitas.Tratamiento%TYPE,
        p_id_historia   IN PYD_Visitas.Id_Historia%TYPE
    );
    
    -- Leer el historial completo de un paciente (CURSOR)
    -- Se requiere el tipo de cursor de PKG_PERSONAS o definir uno aquí.
    -- Asumimos la definición del tipo cur_historias.
    -- PROCEDURE P_LEER_HISTORIAL_PACIENTE (...); 

END PKG_DOCTOR_ACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_DOCTOR_ACCESS AS
    
    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_AGENDAR_CITA
    -----------------------------------------------------
    PROCEDURE P_AGENDAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_id_paciente   IN PYD_Citas.Id_Paciente%TYPE,
        p_hora_cita     IN PYD_Citas.Hora_Cita%TYPE,
        p_fecha_cita    IN PYD_Citas.Fecha_Cita%TYPE,
        p_id_doctor     IN PYD_Citas.Id_Doctor%TYPE,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE
    )
    IS
    BEGIN
        -- Delega la funcionalidad al package de operaciones
        PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
            p_id_cita => p_id_cita,
            p_id_paciente => p_id_paciente,
            p_hora_cita => p_hora_cita,
            p_fecha_cita => p_fecha_cita,
            p_id_doctor => p_id_doctor,
            p_estado_cita => p_estado_cita
        );
    END P_AGENDAR_CITA;

    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_COMPLETAR_CITA
    -----------------------------------------------------
    PROCEDURE P_COMPLETAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_diagnostico   IN PYD_Citas.Diagnostico%TYPE
    )
    IS
    BEGIN
        -- Delega la funcionalidad al package de operaciones. 
        -- El trigger trg_actualizar_estado_cita establecerá el estado 'Completada'.
        PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA(
            p_id_cita => p_id_cita,
            p_diagnostico => p_diagnostico
            -- p_estado_cita se deja NULL para que el trigger lo maneje
        );
    END P_COMPLETAR_CITA;

    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_REGISTRAR_VISITA (Asumiendo un P_CREAR_VISITA en PKG_OPERACIONES_CLINICAS)
    -----------------------------------------------------
    PROCEDURE P_REGISTRAR_VISITA (
        p_id_visita     IN PYD_Visitas.Id_Visita%TYPE,
        p_fecha         IN PYD_Visitas.Fecha%TYPE,
        p_sintomas      IN PYD_Visitas.Sintomas%TYPE,
        p_examen        IN PYD_Visitas.Examen%TYPE DEFAULT NULL,
        p_diagnostico   IN PYD_Visitas.Diagnostico%TYPE,
        p_tratamiento   IN PYD_Visitas.Tratamiento%TYPE,
        p_id_historia   IN PYD_Visitas.Id_Historia%TYPE
    )
    IS
    BEGIN
        -- Nota: Esto asume que has implementado P_CREAR_VISITA en PKG_OPERACIONES_CLINICAS.
        -- Como no lo hiciste, lo simulamos para completar la capa de seguridad.
        INSERT INTO PYD_Visitas (
            Id_Visita, Fecha, Sintomas, Examen, Diagnostico, Tratamiento, Id_Historia
        ) VALUES (
            p_id_visita, p_fecha, p_sintomas, p_examen, p_diagnostico, p_tratamiento, p_id_historia
        );
    END P_REGISTRAR_VISITA;

END PKG_DOCTOR_ACCESS;
/