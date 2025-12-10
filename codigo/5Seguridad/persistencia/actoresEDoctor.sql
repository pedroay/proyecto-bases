
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

