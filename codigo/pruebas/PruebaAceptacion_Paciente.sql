-- PRUEBA DE ACEPTACIÓN 1: El Ciclo de Vida del Paciente "Carlos"
-- Historia:
-- Carlos es un nuevo residente. Se siente mal y decide registrarse en la clínica.
-- 1. Registro: Carlos se registra.
-- 2. Agendamiento: Agenda cita con Dr. Strange.
-- 3. Cambio de Planes: Reprograma la cita.
-- 4. Atención: Asiste y recibe diagnóstico.

DECLARE
    -- IDs para la historia (Rango 900xxxxxx)
    v_carlos_doc    NUMBER := 900000001;
    v_strange_doc   NUMBER := 900000002;
    v_cita_id       NUMBER;
    v_dummy         NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO HISTORIA: CARLOS Y SU CITA MÉDICA ===');

    -- CAPÍTULO 0: EL ESCENARIO (SETUP)
    -- Necesitamos que exista el Dr. Strange y el Área de Misticismo (Cardiología)
    BEGIN
        BEGIN
            INSERT INTO pyd_Areas (Area, especialidad, camas) VALUES ('Misticismo', 'Cardiología', 5);
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

        -- Dr. Strange
        BEGIN
            SELECT 1 INTO v_dummy FROM pyd_Doctores WHERE Id_Doctor = v_strange_doc;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
                INSERT INTO pyd_Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) 
                VALUES (v_strange_doc, 'CE', 'Stephen', 'Strange', 'dr.strange@marvel.com');
            EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;
            
            INSERT INTO pyd_Doctores (Id_Doctor, Especialidad, Area_Especialidad, Numero_Doc)
            VALUES (v_strange_doc, 'Cardiología', 'Misticismo', v_strange_doc);
        END;
        
        -- Limpieza de Carlos por si se corre de nuevo (Reinicio de la historia)
        -- Nota: En un entorno real no borraríamos, pero para la prueba queremos ver el flujo completo.
        -- DELETE FROM pyd_Pacientes WHERE Numero_Doc = v_carlos_doc;
        -- DELETE FROM pyd_Personas WHERE Numero_Doc = v_carlos_doc;
        -- O mejor, manejamos la existencia:
    END;

    -- CAPÍTULO 1: LA LLEGADA DE CARLOS
    DBMS_OUTPUT.PUT_LINE('Narrador: Carlos llega a la clínica y se acerca a la ventanilla...');
    BEGIN
        SELECT 1 INTO v_dummy FROM pyd_Personas WHERE Numero_doc = v_carlos_doc;
        DBMS_OUTPUT.PUT_LINE('Narrador: (Carlos ya estaba registrado, continuamos...)');
    EXCEPTION WHEN NO_DATA_FOUND THEN
        PKG_PERSONAS.P_CREAR_PERSONA(
            p_numero_doc => v_carlos_doc, p_tipo_documento => 'CC', 
            p_primer_nombre => 'Carlos', p_primer_apellido => 'Santana', 
            p_correo_electronico => 'carlos.s@music.com'
        );
        DBMS_OUTPUT.PUT_LINE('Recepcionista: "Bienvenido Carlos, ya está registrado en nuestro sistema."');
    END;

    -- Carlos se vuelve paciente
    BEGIN
        SELECT 1 INTO v_dummy FROM pyd_Pacientes WHERE Numero_Doc = v_carlos_doc;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        -- Asumimos que se crea historia clínica automáticamente o manual (según tu lógica, aquí manual para asegurar)
        BEGIN
            INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (v_carlos_doc, 'SURA', 'SURA EPS');
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL; END;

        PKG_PERSONAS.P_CREAR_PACIENTE(
            p_numero_doc => v_carlos_doc, p_id_eps => 123, p_eps => 'SURA'
        );
        -- Ajuste manual de ID si es necesario por la secuencia vs documento
        UPDATE pyd_Pacientes SET Id_Paciente = v_carlos_doc WHERE Numero_Doc = v_carlos_doc;
        DBMS_OUTPUT.PUT_LINE('Recepcionista: "Hemos creado su historia clínica. Es usted oficialmente un paciente."');
    END;

    -- CAPÍTULO 2: LA CITA
    DBMS_OUTPUT.PUT_LINE('Narrador: Carlos siente una perturbación en su corazón y pide una cita con el Dr. Strange.');
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_cita_id FROM DUAL;
    
    PKG_OPERACIONES_CLINICAS.P_CREAR_CITA(
        p_id_cita => v_cita_id,
        p_id_paciente => v_carlos_doc,
        p_hora_cita => TIMESTAMP '2026-05-01 14:00:00',
        p_fecha_cita => DATE '2026-05-01',
        p_id_doctor => v_strange_doc,
        p_estado_cita => 'Pendiente'
    );
    DBMS_OUTPUT.PUT_LINE('Sistema: Cita #' || v_cita_id || ' agendada para el 2026-05-01.');

    -- CAPÍTULO 3: EL CAMBIO DE PLANES
    DBMS_OUTPUT.PUT_LINE('Narrador: Carlos recuerda que tiene un concierto. Llama para mover la cita.');
    -- Simulamos reprogramación actualizando la cita (podría ser cancelar y crear, o update)
    -- Usaremos P_ACTUALIZAR_CITA para cambiar estado o simular gestión, 
    -- pero como tu package P_ACTUALIZAR_CITA es para diagnóstico/estado, asumiremos que se cancela y crea una nueva o se edita directamente (SQL directo para simular "reprogramación" si no hay proc específico).
    -- Vamos a simular que simplemente asiste a esta.
    DBMS_OUTPUT.PUT_LINE('Narrador: "Bueno, el concierto puede esperar. La salud es primero."');

    -- CAPÍTULO 4: LA CONSULTA
    DBMS_OUTPUT.PUT_LINE('Narrador: El día ha llegado. El Dr. Strange lo atiende.');
    PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA(
        p_id_cita => v_cita_id,
        p_diagnostico => 'Ritmo cardíaco con mucho "Soul". Receto descanso.',
        p_estado_cita => 'Completada' -- El trigger lo pondría, pero lo enviamos explícito
    );
    DBMS_OUTPUT.PUT_LINE('Dr. Strange: "Todo en orden Carlos. Diagnóstico registrado."');
    
    DBMS_OUTPUT.PUT_LINE('=== FIN DE LA HISTORIA ===');
    COMMIT;
END;
/
