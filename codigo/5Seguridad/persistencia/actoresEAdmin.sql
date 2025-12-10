
CREATE OR REPLACE PACKAGE PKG_ADMIN_ACCESS AS

    -----------------------------------------------------
    -- GESTIÓN DE PERSONAL (Usa PKG_PERSONAS)
    -----------------------------------------------------
    
    -- Crear una persona nueva
    PROCEDURE P_ALTA_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_tipo_documento      IN PYD_Personas.Tipo_documento%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE
    );

    -- Registrar a una persona como Paciente
    PROCEDURE P_ALTA_PACIENTE (
        p_numero_doc          IN PYD_Pacientes.Numero_Doc%TYPE,
        p_id_eps              IN PYD_Pacientes.Id_Eps%TYPE,
        p_eps                 IN PYD_Pacientes.Eps%TYPE
    );
    
    -- Registrar a una persona como Doctor (requiere el ID de salida)
    PROCEDURE P_ALTA_DOCTOR (
        p_numero_doc          IN PYD_Doctores.Numero_Doc%TYPE,
        p_especialidad        IN PYD_Doctores.Especialidad%TYPE,
        p_area_especialidad   IN PYD_Doctores.Area_Especialidad%TYPE DEFAULT NULL,
        p_t_turno             IN PYD_Doctores.T_Turno%TYPE DEFAULT NULL
    );

    -----------------------------------------------------
    -- GESTIÓN DE CITAS (Usa PKG_OPERACIONES_CLINICAS)
    -----------------------------------------------------
    
    -- Agendar una cita (mismo que el Doctor, pero con propósito administrativo)
    PROCEDURE P_AGENDAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE,
        p_id_paciente   IN PYD_Citas.Id_Paciente%TYPE,
        p_hora_cita     IN PYD_Citas.Hora_Cita%TYPE,
        p_fecha_cita    IN PYD_Citas.Fecha_Cita%TYPE,
        p_id_doctor     IN PYD_Citas.Id_Doctor%TYPE,
        p_estado_cita   IN PYD_Citas.Estado_Cita%TYPE
    );
    
    -- Cancelar una cita (Actualizar estado)
    PROCEDURE P_CANCELAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE
    );

END PKG_ADMIN_ACCESS;
/


