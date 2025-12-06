-- Archivo: SeguridadAdminOK.sql

DECLARE
    v_new_persona_doc NUMBER := 444444444;
    v_new_doctor_doc NUMBER := 555555555;
    v_new_cita_admin NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- PRUEBAS PKG_ADMIN_ACCESS OK ---');
    
    -- 1. Alta de una Persona (Llama a PKG_PERSONAS.P_CREAR_PERSONA)
    PKG_ADMIN_ACCESS.P_ALTA_PERSONA(
        p_numero_doc => v_new_persona_doc,
        p_tipo_documento => 'CC',
        p_primer_nombre => 'Roberto',
        p_primer_apellido => 'García',
        p_correo_electronico => 'roberto.g@mail.com'
    );
    DBMS_OUTPUT.PUT_LINE('OK 1: Administrativo registra Persona: ' || v_new_persona_doc);

    -- 2. Alta de un Paciente (Llama a PKG_PERSONAS.P_CREAR_PACIENTE)
    PKG_ADMIN_ACCESS.P_ALTA_PACIENTE(
        p_numero_doc => v_new_persona_doc,
        p_id_eps => 54321,
        p_eps => 'NuevaEPS'
    );
    DBMS_OUTPUT.PUT_LINE('OK 2: Administrativo registra Paciente para Doc: ' || v_new_persona_doc);
    
    -- 3. Alta de un Doctor (Llama a PKG_PERSONAS.P_CREAR_DOCTOR)
    PKG_ADMIN_ACCESS.P_ALTA_PERSONA(
        p_numero_doc => v_new_doctor_doc,
        p_tipo_documento => 'CC',
        p_primer_nombre => 'Sofía',
        p_primer_apellido => 'Díaz',
        p_correo_electronico => 'sofia.d@clinic.com'
    );
    PKG_ADMIN_ACCESS.P_ALTA_DOCTOR(
        p_numero_doc => v_new_doctor_doc,
        p_especialidad => 'Pediatría General',
        p_area_especialidad => 'Pediatría'
    );
    DBMS_OUTPUT.PUT_LINE('OK 3: Administrativo registra Doctor para Doc: ' || v_new_doctor_doc);
    
    -- 4. Cancelar una Cita (Llama a PKG_OPERACIONES_CLINICAS.P_ACTUALIZAR_CITA)
    SELECT SEQ_CITA_ID.NEXTVAL INTO v_new_cita_admin FROM DUAL;
    -- Primero creamos una cita (usando el procedimiento delegado)
    PKG_ADMIN_ACCESS.P_AGENDAR_CITA(v_new_cita_admin, 1, TIMESTAMP '2026-04-02 11:00:00', DATE '2026-04-02', 1, 'Pendiente');
    
    PKG_ADMIN_ACCESS.P_CANCELAR_CITA(v_new_cita_admin);
    DBMS_OUTPUT.PUT_LINE('OK 4: Administrativo cancela Cita: ' || v_new_cita_admin);

    COMMIT;
END;
/