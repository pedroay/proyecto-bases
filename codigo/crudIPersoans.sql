-- Archivo: crudPersonasI.sql (ACTUALIZADO)
-- Asumiendo la existencia de las secuencias:
-- CREATE SEQUENCE SEQ_DOCTOR_ID START WITH 1 INCREMENT BY 1;
-- CREATE SEQUENCE SEQ_ENFERMERA_ID START WITH 1 INCREMENT BY 1;
-- CREATE SEQUENCE SEQ_PACIENTE_ID START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PACKAGE BODY PKG_PERSONAS AS
    
    -----------------------------------------------------
    -- Implementación de P_CREAR_PERSONA
    -----------------------------------------------------
    PROCEDURE P_CREAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_tipo_documento      IN PYD_Personas.Tipo_documento%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE,
        p_segundo_nombre      IN PYD_Personas.segundo_nombre%TYPE DEFAULT NULL,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE,
        p_segundo_apellido    IN PYD_Personas.segundo_apellido%TYPE DEFAULT NULL,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE
    )
    IS
    BEGIN
        INSERT INTO PYD_Personas (
            Numero_doc, Tipo_documento, primer_nombre, segundo_nombre, 
            primer_apellido, segundo_apellido, correo_electronico
        ) VALUES (
            p_numero_doc, p_tipo_documento, p_primer_nombre, p_segundo_nombre, 
            p_primer_apellido, p_segundo_apellido, p_correo_electronico
        );
        -- COMMIT; -- (Opcional, depende de tu estrategia de transacciones)
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error: Ya existe una persona con el mismo documento o correo.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al crear persona: ' || SQLERRM);
    END P_CREAR_PERSONA;

    -----------------------------------------------------
    -- Implementación de P_LEER_PERSONA
    -----------------------------------------------------
    PROCEDURE P_LEER_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_cursor_out          OUT cur_personas
    )
    IS
    BEGIN
        OPEN p_cursor_out FOR
            SELECT 
                Numero_doc, Tipo_documento, primer_nombre, segundo_nombre, 
                primer_apellido, segundo_apellido, correo_electronico
            FROM PYD_Personas
            WHERE Numero_doc = p_numero_doc;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error al leer persona: ' || SQLERRM);
    END P_LEER_PERSONA;

    -----------------------------------------------------
    -- Implementación de P_ACTUALIZAR_PERSONA
    -----------------------------------------------------
    PROCEDURE P_ACTUALIZAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE,
        p_primer_nombre       IN PYD_Personas.primer_nombre%TYPE DEFAULT NULL,
        p_segundo_nombre      IN PYD_Personas.segundo_nombre%TYPE DEFAULT NULL,
        p_primer_apellido     IN PYD_Personas.primer_apellido%TYPE DEFAULT NULL,
        p_segundo_apellido    IN PYD_Personas.segundo_apellido%TYPE DEFAULT NULL,
        p_correo_electronico  IN PYD_Personas.correo_electronico%TYPE DEFAULT NULL
    )
    IS
    BEGIN
        UPDATE PYD_Personas
        SET
            primer_nombre = NVL(p_primer_nombre, primer_nombre),
            segundo_nombre = p_segundo_nombre, -- Usamos el valor, ya que es NULLable
            primer_apellido = NVL(p_primer_apellido, primer_apellido),
            segundo_apellido = p_segundo_apellido, -- Usamos el valor, ya que es NULLable
            correo_electronico = NVL(p_correo_electronico, correo_electronico)
        WHERE Numero_doc = p_numero_doc;
        
        IF SQL%ROWCOUNT = 0 THEN
             RAISE_APPLICATION_ERROR(-20004, 'Error: Persona con documento ' || p_numero_doc || ' no encontrada para actualizar.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar persona: ' || SQLERRM);
    END P_ACTUALIZAR_PERSONA;

    -----------------------------------------------------
    -- Implementación de P_ELIMINAR_PERSONA
    -----------------------------------------------------
    PROCEDURE P_ELIMINAR_PERSONA (
        p_numero_doc          IN PYD_Personas.Numero_doc%TYPE
    )
    IS
    BEGIN
        DELETE FROM PYD_Personas
        WHERE Numero_doc = p_numero_doc;

        IF SQL%ROWCOUNT = 0 THEN
             RAISE_APPLICATION_ERROR(-20006, 'Error: Persona con documento ' || p_numero_doc || ' no encontrada para eliminar.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20007, 'Error al eliminar persona: ' || SQLERRM);
    END P_ELIMINAR_PERSONA;

    -----------------------------------------------------
    -- Implementación de P_CREAR_DOCTOR
    -----------------------------------------------------
    PROCEDURE P_CREAR_DOCTOR (
        p_numero_doc          IN PYD_Doctores.Numero_Doc%TYPE,
        p_especialidad        IN PYD_Doctores.Especialidad%TYPE,
        p_area_especialidad   IN PYD_Doctores.Area_Especialidad%TYPE DEFAULT NULL,
        p_t_turno             IN PYD_Doctores.T_Turno%TYPE DEFAULT NULL,
        p_id_doctor_out       OUT PYD_Doctores.Id_Doctor%TYPE
    )
    IS
        v_id_doctor PYD_Doctores.Id_Doctor%TYPE;
    BEGIN
        SELECT SEQ_DOCTOR_ID.NEXTVAL INTO v_id_doctor FROM DUAL;
        p_id_doctor_out := v_id_doctor; -- Asignar el valor de salida inmediatamente

        INSERT INTO PYD_Doctores (
            Id_Doctor, Especialidad, Area_Especialidad, T_Turno, Numero_Doc
        ) VALUES (
            v_id_doctor, p_especialidad, p_area_especialidad, p_t_turno, p_numero_doc
        );
        -- NOTA: El trigger trg_check_doctor_area se ejecuta aquí.
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error: El Numero_Doc no existe en pyd_Personas o el Area_Especialidad no existe.');
        WHEN OTHERS THEN
            -- Se captura el error del trigger -20001 aquí si no coincide el área
            RAISE_APPLICATION_ERROR(-20011, 'Error al crear doctor: ' || SQLERRM);
    END P_CREAR_DOCTOR;
    
    -----------------------------------------------------
    -- Implementación de P_CREAR_ENFERMERA
    -----------------------------------------------------
    PROCEDURE P_CREAR_ENFERMERA (
        p_numero_doc          IN PYD_Enfermeras.Numero_Doc%TYPE,
        p_area                IN PYD_Enfermeras.Area%TYPE DEFAULT NULL,
        p_especialidad        IN PYD_Enfermeras.Especialidad%TYPE DEFAULT NULL,
        p_turno               IN PYD_Enfermeras.Turno%TYPE DEFAULT NULL,
        p_id_enfermera_out    OUT PYD_Enfermeras.Id_Enfermera%TYPE
    )
    IS
        v_id_enfermera PYD_Enfermeras.Id_Enfermera%TYPE;
    BEGIN
        SELECT SEQ_ENFERMERA_ID.NEXTVAL INTO v_id_enfermera FROM DUAL;
        p_id_enfermera_out := v_id_enfermera;

        INSERT INTO PYD_Enfermeras (
            Id_Enfermera, Area, Especialidad, Turno, Numero_Doc
        ) VALUES (
            v_id_enfermera, p_area, p_especialidad, p_turno, p_numero_doc
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error al crear enfermera: ' || SQLERRM);
    END P_CREAR_ENFERMERA;

    -----------------------------------------------------
    -- Implementación de P_CREAR_PACIENTE
    -----------------------------------------------------
    PROCEDURE P_CREAR_PACIENTE (
        p_numero_doc          IN PYD_Pacientes.Numero_Doc%TYPE,
        p_id_eps              IN PYD_Pacientes.Id_Eps%TYPE,
        p_eps                 IN PYD_Pacientes.Eps%TYPE,
        p_id_paciente_out     OUT PYD_Pacientes.Id_Paciente%TYPE
    )
    IS
        v_id_paciente PYD_Pacientes.Id_Paciente%TYPE;
    BEGIN
        SELECT SEQ_PACIENTE_ID.NEXTVAL INTO v_id_paciente FROM DUAL;
        p_id_paciente_out := v_id_paciente;

        INSERT INTO PYD_Pacientes (
            Id_Paciente, Id_Eps, Eps, Numero_Doc
        ) VALUES (
            v_id_paciente, p_id_eps, p_eps, p_numero_doc
        );
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20013, 'Error al crear paciente: ' || SQLERRM);
    END P_CREAR_PACIENTE;

END PKG_PERSONAS;
/