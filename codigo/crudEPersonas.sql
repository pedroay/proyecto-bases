-- Archivo: crudPersonasE.sql (ACTUALIZADO)

CREATE OR REPLACE PACKAGE PKG_PERSONAS AS
    
    -- Definiciones de tipos (Se mantienen igual)
    TYPE rec_persona IS RECORD (
        Numero_doc          PYD_Personas.Numero_doc%TYPE,
        Tipo_documento      PYD_Personas.Tipo_documento%TYPE,
        primer_nombre       PYD_Personas.primer_nombre%TYPE,
        segundo_nombre      PYD_Personas.segundo_nombre%TYPE,
        primer_apellido     PYD_Personas.primer_apellido%TYPE,
        segundo_apellido    PYD_Personas.segundo_apellido%TYPE,
        correo_electronico  PYD_Personas.correo_electronico%TYPE
    );
    
    TYPE cur_personas IS REF CURSOR RETURN rec_persona;

    -----------------------------------------------------
    -- Procedimientos CRUD para PYD_PERSONAS (Se mantienen igual)
    -----------------------------------------------------
    PROCEDURE P_CREAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_tipo_documento      IN PYD_Personas.Tipo_documento%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE,
        p_segundo_nombre      IN PYD_Personas.segundo_nombre%TYPE DEFAULT NULL,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE,
        p_segundo_apellido    IN PYD_Personas.segundo_apellido%TYPE DEFAULT NULL,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE
    );
    
    PROCEDURE P_LEER_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_cursor_out          OUT cur_personas
    );
    
    PROCEDURE P_ACTUALIZAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE DEFAULT NULL,
        p_segundo_nombre      IN PYD_Personas.segundo_nombre%TYPE DEFAULT NULL,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE DEFAULT NULL,
        p_segundo_apellido    IN PYD_Personas.segundo_apellido%TYPE DEFAULT NULL,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE DEFAULT NULL
    );
    
    PROCEDURE P_ELIMINAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE
    );

    -----------------------------------------------------
    -- Procedimientos CRUD para PYD_DOCTORES
    -----------------------------------------------------
    -- Crear un nuevo doctor a partir de una persona existente.
    -- El 'trg_check_doctor_area' se ejecutará en esta inserción.
    PROCEDURE P_CREAR_DOCTOR (
        p_numero_doc          IN PYD_Doctores.Numero_Doc%TYPE,
        p_especialidad        IN PYD_Doctores.Especialidad%TYPE,
        p_area_especialidad   IN PYD_Doctores.Area_Especialidad%TYPE DEFAULT NULL,
        p_t_turno             IN PYD_Doctores.T_Turno%TYPE DEFAULT NULL,
        p_id_doctor_out       OUT PYD_Doctores.Id_Doctor%TYPE -- Devuelve el ID generado
    );

    -----------------------------------------------------
    -- Procedimientos CRUD para PYD_ENFERMERAS
    -----------------------------------------------------
    -- Crear una nueva enfermera a partir de una persona existente.
    PROCEDURE P_CREAR_ENFERMERA (
        p_numero_doc          IN PYD_Enfermeras.Numero_Doc%TYPE,
        p_area                IN PYD_Enfermeras.Area%TYPE DEFAULT NULL,
        p_especialidad        IN PYD_Enfermeras.Especialidad%TYPE DEFAULT NULL,
        p_turno               IN PYD_Enfermeras.Turno%TYPE DEFAULT NULL,
        p_id_enfermera_out    OUT PYD_Enfermeras.Id_Enfermera%TYPE -- Devuelve el ID generado
    );
    
    -----------------------------------------------------
    -- Procedimientos CRUD para PYD_PACIENTES
    -----------------------------------------------------
    -- Crear un nuevo paciente a partir de una persona existente.
    PROCEDURE P_CREAR_PACIENTE (
        p_numero_doc          IN PYD_Pacientes.Numero_Doc%TYPE,
        p_id_eps              IN PYD_Pacientes.Id_Eps%TYPE,
        p_eps                 IN PYD_Pacientes.Eps%TYPE,
        p_id_paciente_out     OUT PYD_Pacientes.Id_Paciente%TYPE -- Devuelve el ID generado
    );

END PKG_PERSONAS;
/