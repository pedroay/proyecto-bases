CREATE OR REPLACE TRIGGER trg_actualizar_estado_cuarto
BEFORE INSERT OR UPDATE OF ocupante, Estado ON pyd_Cuartos
FOR EACH ROW
BEGIN
    -- Si se inserta o actualiza un ocupante, forzamos el estado a 'Ocupado'
    IF :NEW.ocupante IS NOT NULL AND :NEW.Estado != 'Ocupado' THEN
        :NEW.Estado := 'Ocupado';
    
    -- Si el ocupante se establece en NULL, forzamos el estado a 'Disponible', 
    -- siempre y cuando el estado actual no sea 'Mantenimiento'.
    ELSIF :NEW.ocupante IS NULL AND :NEW.Estado != 'Disponible' AND :NEW.Estado != 'Mantenimiento' THEN
        :NEW.Estado := 'Disponible';
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_actualizar_estado_cita
BEFORE UPDATE OF Diagnostico ON pyd_Citas
FOR EACH ROW
BEGIN
    -- Si el Diagnostico cambia de NULL a un valor, el Estado_Cita debe ser 'Completada'
    IF :OLD.Diagnostico IS NULL AND :NEW.Diagnostico IS NOT NULL THEN
        :NEW.Estado_Cita := 'Completada';
    
    -- Si se elimina el Diagnostico, el Estado_Cita vuelve a 'Pendiente'
    ELSIF :OLD.Diagnostico IS NOT NULL AND :NEW.Diagnostico IS NULL THEN
        :NEW.Estado_Cita := 'Pendiente';
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_check_doctor_area
BEFORE INSERT OR UPDATE OF Area_Especialidad, Especialidad ON pyd_Doctores
FOR EACH ROW
DECLARE
    v_especialidad_area PYD_Areas.especialidad%TYPE; -- Usar %TYPE para el tipo de dato
BEGIN
    IF :NEW.Area_Especialidad IS NOT NULL THEN
        -- Intentar obtener la especialidad del área
        BEGIN
            SELECT especialidad INTO v_especialidad_area
            FROM pyd_Areas 
            WHERE Area = :NEW.Area_Especialidad;

            -- Si la tupla se encuentra, realizar la comparación
            IF :NEW.Especialidad != v_especialidad_area THEN
                RAISE_APPLICATION_ERROR(-20001, 'La especialidad del doctor (' || :NEW.Especialidad || ') no coincide con el área (' || v_especialidad_area || ') asignada.');
            END IF;

        EXCEPTION
            -- Manejar la excepción si el Área no existe en PYD_AREAS
            WHEN NO_DATA_FOUND THEN
                -- Si hay una FK activa (FK_DOCTOR_AREA), esta línea es redundante, 
                -- pero útil si la FK se desactiva. Si la FK está activa, el INSERT fallará después del trigger.
                -- Si quieres que el trigger falle explícitamente:
                RAISE_APPLICATION_ERROR(-20002, 'El Área_Especialidad (' || :NEW.Area_Especialidad || ') asignada al doctor no existe en la tabla pyd_Areas.');
            WHEN OTHERS THEN
                -- Manejar cualquier otro error
                RAISE_APPLICATION_ERROR(-20003, 'Error inesperado en trigger de doctor: ' || SQLERRM);
        END;
    END IF;
END;
/