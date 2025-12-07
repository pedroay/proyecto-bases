-- PRUEBA DE ACEPTACIÓN 2: La Gestión Administrativa de "Ana"
-- Historia:
-- Ana es la administradora. Necesita incorporar un especialista y gestionar la agenda.
-- 1. Contratación: Ana registra al Dr. House.
-- 2. Gestión de Citas: Marty pide cita urgente.
-- 3. Cancelación: Marty cancela.

DECLARE
    -- IDs para la historia (Rango 900xxxxxx)
    v_ana_doc       NUMBER := 900000010; -- Admin (simulado)
    v_house_doc     NUMBER := 900000011;
    v_marty_doc     NUMBER := 900000012;
    v_cita_id       NUMBER;
    v_dummy         NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO HISTORIA: ANA Y LA GESTIÓN DE LA CLÍNICA ===');

    -- CAPÍTULO 0: EL ESCENARIO
    -- Asegurar Area Diagnóstico
    BEGIN
        INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Diagnóstico', 'General', 2);
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

    -- CAPÍTULO 1: CONTRATANDO TALENTO
    DBMS_OUTPUT.PUT_LINE('Narrador: Ana recibe el CV de un tal Gregory House. Decide contratarlo.');
    
    -- Verificar si House ya existe
    BEGIN
        SELECT 1 INTO v_dummy FROM pyd_Doctores WHERE Id_Doctor = v_house_doc;
        DBMS_OUTPUT.PUT_LINE('Ana: "El Dr. House ya trabaja aquí. (Datos previos encontrados)"');
    EXCEPTION WHEN NO_DATA_FOUND THEN
        -- Crear Persona House
        BEGIN
            INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
            VALUES (v_house_doc, 'CE', 'Gregory', 'House', 'house@clinic.com');
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

        -- Crear Doctor House (Usando PKG_ADMIN_ACCESS o PKG_PERSONAS)
        PKG_PERSONAS.P_CREAR_DOCTOR(
            p_numero_doc => v_house_doc,
            p_especialidad => 'General',
            p_area_especialidad => 'Diagnóstico',
            p_t_turno => 1,
            p_id_doctor_out => v_dummy
        );
        -- Forzar ID para consistencia de prueba
        UPDATE pyd_Doctores SET Id_Doctor = v_house_doc WHERE Numero_Doc = v_house_doc;
        DBMS_OUTPUT.PUT_LINE('Ana: "Bienvenido Dr. House. Su ID es ' || v_house_doc || '."');
    END;

    -- CAPÍTULO 2: UNA CITA URGENTE
    DBMS_OUTPUT.PUT_LINE('Narrador: Marty McFly llama desde una cabina telefónica. Necesita ver a House.');
    
    -- Crear Paciente Marty (Setup rápido)
    BEGIN
        SELECT 1 INTO v_dummy FROM pyd_Pacientes WHERE Numero_Doc = v_marty_doc;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
            INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
            VALUES (v_marty_doc, 'CC', 'Marty', 'McFly', 'marty@future.com');
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
        
        BEGIN
            INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (v_marty_doc, 'SURA', 'SURA EPS');
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

        INSERT INTO pyd_Pacientes (Id_Paciente, Id_Eps, Eps, Numero_Doc) VALUES (v_marty_doc, 555, 'SURA', v_marty_doc);
    END;

    SELECT SEQ_CITA_ID.NEXTVAL INTO v_cita_id FROM DUAL;
    -- Ana agenda la cita (Simulando rol admin)
    PKG_ADMIN_ACCESS.P_AGENDAR_CITA(
        p_id_cita => v_cita_id,
        p_id_paciente => v_marty_doc,
        p_hora_cita => TIMESTAMP '2026-10-21 16:29:00', -- Back to the Future date ;)
        p_fecha_cita => DATE '2026-10-21',
        p_id_doctor => v_house_doc,
        p_estado_cita => 'Pendiente'
    );
    DBMS_OUTPUT.PUT_LINE('Ana: "Listo Marty, cita #' || v_cita_id || ' con el Dr. House agendada."');

    -- CAPÍTULO 3: EL REGRESO AL FUTURO
    DBMS_OUTPUT.PUT_LINE('Narrador: Marty se da cuenta que se le hace tarde para volver a 1985.');
    
    PKG_ADMIN_ACCESS.P_CANCELAR_CITA(v_cita_id);
    
    DBMS_OUTPUT.PUT_LINE('Ana: "Entendido Marty. Cita cancelada. ¡Buen viaje!"');
    
    DBMS_OUTPUT.PUT_LINE('=== FIN DE LA HISTORIA ===');
    COMMIT;
END;
/
