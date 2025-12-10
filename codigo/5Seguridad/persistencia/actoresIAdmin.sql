CREATE OR REPLACE PACKAGE BODY PKG_ADMIN_ACCESS AS

    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_ALTA_PERSONA
    -----------------------------------------------------
    PROCEDURE P_ALTA_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_tipo_documento      IN PYD_Personas.Tipo_documento%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE
    )
    IS
    BEGIN
        -- Llama al procedimiento de PKG_PERSONAS
        PKG_PERSONAS.P_CREAR_PERSONA(
            p_numero_doc => p_numero_doc,
            p_tipo_documento => p_tipo_documento,
            p_primer_nombre => p_primer_nombre,
            p_segundo_nombre => NULL,
            p_primer_apellido => p_primer_apellido,
            p_segundo_apellido => NULL,
            p_correo_electronico => p_correo_electronico
        );
    END P_ALTA_PERSONA;

    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_ALTA_PACIENTE
    -----------------------------------------------------
    PROCEDURE P_ALTA_PACIENTE (
        p_numero_doc          IN PYD_Pacientes.Numero_Doc%TYPE,
        p_id_eps              IN PYD_Pacientes.Id_Eps%TYPE,
        p_eps                 IN PYD_Pacientes.Eps%TYPE
    )
    IS
        v_id_paciente PYD_Pacientes.Id_Paciente%TYPE;
    BEGIN
        -- Llama al procedimiento de PKG_PERSONAS
        PKG_PERSONAS.P_CREAR_PACIENTE(
            p_numero_doc => p_numero_doc,
            p_id_eps => p_id_eps,
            p_eps => p_eps,
            p_id_paciente_out => v_id_paciente
        );
    END P_ALTA_PACIENTE;

    -----------------------------------------------------
    -- IMPLEMENTACIÓN DE P_ALTA_DOCTOR
    -----------------------------------------------------
    PROCEDURE P_ALTA_DOCTOR (
        p_numero_doc          IN PYD_Doctores.Numero_Doc%TYPE,
        p_especialidad        IN PYD_Doctores.Especialidad%TYPE,
        p_area_especialidad   IN PYD_Doctores.Area_Especialidad%TYPE DEFAULT NULL,
        p_t_turno             IN PYD_Doctores.T_Turno%TYPE DEFAULT NULL
    )
    IS
        v_id_doctor PYD_Doctores.Id_Doctor%TYPE;
    BEGIN
        -- Llama al procedimiento de PKG_PERSONAS
        PKG_PERSONAS.P_CREAR_DOCTOR(
            p_numero_doc => p_numero_doc,
            p_especialidad => p_especialidad,
            p_area_especialidad => p_area_especialidad,
            p_t_turno => p_t_turno,
            p_id_doctor_out => v_id_doctor
        );
    END P_ALTA_DOCTOR;
    
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
    -- IMPLEMENTACIÓN DE P_CANCELAR_CITA
    -----------------------------------------------------
    PROCEDURE P_CANCELAR_CITA (
        p_id_cita       IN PYD_Citas.Id_Cita%TYPE
    )
    IS
    BEGIN
        -- El administrativo solo actualiza el estado, sin tocar el diagnóstico
        PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA(
            p_id_cita => p_id_cita,
            p_diagnostico => NULL,
            p_estado_cita => 'Cancelada'
        );
    END P_CANCELAR_CITA;

END PKG_ADMIN_ACCESS;
/