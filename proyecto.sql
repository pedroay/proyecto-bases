CREATE TABLE Personas (
    Numero_doc NUMBER NOT NULL,
    Tipo_documento VARCHAR2(10) NOT NULL,
    primer_nombre VARCHAR2(50) NOT NULL,
    segundo_nombre VARCHAR2(50),
    primer_apellido VARCHAR2(50) NOT NULL,
    segundo_apellido VARCHAR2(50),
    correo_electronico VARCHAR2(100) NOT NULL UNIQUE,
);


CREATE TABLE Cuartos (
    N_Cuarto NUMBER NOT NULL,
    Estado VARCHAR2(50) NOT NULL,
    Tipo_Cuarto VARCHAR2(50) NOT NULL,
    ocupante NUMBER
);


CREATE TABLE Areas (
    Area VARCHAR2(100) NOT NULL,
    especialidad VARCHAR2(100) NOT NULL,
    camas NUMBER NOT NULL,
    doctor_encargado NUMBER,
    enfermeria_jefe NUMBER
);


CREATE TABLE Doctores (
    Id_Doctor NUMBER NOT NULL,
    Especialidad VARCHAR2(100) NOT NULL,
    Area_Especialidad NUMBER,
    T_Turno NUMBER,
    Numero_Doc NUMBER NOT NULL
);


CREATE TABLE Enfermeras (
    Id_Enfermera NUMBER NOT NULL,
    Area NUMBER,
    Especialidad VARCHAR2(100),
    Turno NUMBER,
    Numero_Doc NUMBER NOT NULL
);


CREATE TABLE Pacientes (
    Id_Paciente NUMBER NOT NULL,
    Id_Eps NUMBER NOT NULL,
    Eps VARCHAR2(100) NOT NULL,
    Numero_Doc NUMBER NOT NULL
);

CREATE TABLE HistoriasClinicas (
    Id_Historia NUMBER NOT NULL,
    Eps VARCHAR2(100) NOT NULL,
    Nombre_Eps VARCHAR2(100) NOT NULL
);

CREATE TABLE Visitas (
    Id_Visita NUMBER NOT NULL,
    Fecha DATE NOT NULL,
    Sintomas VARCHAR2(255) NOT NULL,
    Examen VARCHAR2(255),
    Diagnostico VARCHAR2(255) NOT NULL,
    Tratamiento VARCHAR2(255) NOT NULL,
    Id_Historia NUMBER NOT NULL
);

CREATE TABLE Turnos (
    Tipo_Turno NUMBER NOT NULL,
    Nombre_Turno VARCHAR2(50) NOT NULL,
    Inicia DATE NOT NULL,
    Acaba DATE NOT NULL
);

CREATE TABLE Citas (
    Id_Cita NUMBER NOT NULL,
    Id_Paciente NUMBER NOT NULL,
    Hora_Cita DATE NOT NULL,
    Fecha_Cita DATE NOT NULL,
    Id_Doctor NUMBER NOT NULL,
    Diagnostico VARCHAR2(255),
    Estado_Cita VARCHAR2(50) NOT NULL
);

CREATE TABLE PQRS (
    Id_PQR NUMBER NOT NULL,
    Descripcion VARCHAR2(255) NOT NULL,
    Tema VARCHAR2(100),
    Cadena VARCHAR2(255)
);

ALTER TABLE Persona ADD CONSTRAINT PK_PERSONA PRIMARY KEY (Numero_doc);
ALTER TABLE Cuartos ADD CONSTRAINT PK_CUARTOS PRIMARY KEY (N_Cuarto);
ALTER TABLE Areas ADD CONSTRAINT PK_AREAS PRIMARY KEY (Area);
ALTER TABLE Doctores ADD CONSTRAINT PK_DOCTORES PRIMARY KEY (Id_Doctor);
ALTER TABLE Enfermeras ADD CONSTRAINT PK_ENFERMERAS PRIMARY KEY (Id_Enfermera);
ALTER TABLE Pacientes ADD CONSTRAINT PK_PACIENTES PRIMARY KEY (Id_Paciente);
ALTER TABLE HistoriasClinicas ADD CONSTRAINT PK_HISTORIACLINICA PRIMARY KEY (Id_Historia);
ALTER TABLE Visitas ADD CONSTRAINT PK_VISITAS PRIMARY KEY (Id_Visita);
ALTER TABLE Turnos ADD CONSTRAINT PK_TURNOS PRIMARY KEY (Tipo_Turno);
ALTER TABLE Citas ADD CONSTRAINT PK_CITAS PRIMARY KEY (Id_Cita);
ALTER TABLE PQR ADD CONSTRAINT PK_PQR PRIMARY KEY (Id_PQR);

ALTER TABLE Doctores ADD CONSTRAINT FK_DOCTOR_PERSONA
FOREIGN KEY (Id_Doctor) REFERENCES Persona (Numero_doc);

ALTER TABLE Enfermeras ADD CONSTRAINT FK_ENFERMERA_PERSONA
FOREIGN KEY (Id_Enfermera) REFERENCES Persona (Numero_doc);

ALTER TABLE Pacientes ADD CONSTRAINT FK_PACIENTE_PERSONA
FOREIGN KEY (Numero_Doc) REFERENCES Persona (Numero_doc);

ALTER TABLE Cuartos ADD CONSTRAINT FK_CUARTO_OCUPANTE
FOREIGN KEY (ocupante) REFERENCES Persona (Numero_doc);

ALTER TABLE Areas ADD CONSTRAINT FK_AREA_DOCTOR_ENCARGADO
FOREIGN KEY (doctor_encargado) REFERENCES Doctores (Id_Doctor);

ALTER TABLE Areas ADD CONSTRAINT FK_AREA_ENFERMERA_JEFE
FOREIGN KEY (enfermeria_jefe) REFERENCES Enfermeras (Id_Enfermera);

ALTER TABLE Doctores ADD CONSTRAINT FK_DOCTOR_AREA
FOREIGN KEY (Area_Especialidad) REFERENCES Areas (Area);

ALTER TABLE Doctores ADD CONSTRAINT FK_DOCTOR_TURNO
FOREIGN KEY (T_Turno) REFERENCES Turnos (Tipo_Turno);

ALTER TABLE Enfermeras ADD CONSTRAINT FK_ENFERMERA_AREA
FOREIGN KEY (Area) REFERENCES Areas (Area);

ALTER TABLE Enfermeras ADD CONSTRAINT FK_ENFERMERA_TURNO
FOREIGN KEY (Turno) REFERENCES Turnos (Tipo_Turno);

ALTER TABLE Pacientes ADD CONSTRAINT FK_PACIENTE_HISTORIA
FOREIGN KEY (Id_HojaCl) REFERENCES HistoriasClinicas (Id_Historia);

ALTER TABLE Visitas ADD CONSTRAINT FK_VISITA_HISTORIA
FOREIGN KEY (Id_Historia) REFERENCES HistoriasClinicas (Id_Historia);

ALTER TABLE Citas ADD CONSTRAINT FK_CITA_PACIENTE
FOREIGN KEY (Id_Paciente) REFERENCES Personas (Numero_doc);

ALTER TABLE Citas ADD CONSTRAINT FK_CITA_DOCTOR
FOREIGN KEY (Id_Doctor) REFERENCES Doctores (Id_Doctor);

-- Consultas
SELECT
    D.primer_nombre || ' ' || D.primer_apellido AS Nombre_Doctor,
    P.primer_nombre || ' ' || P.primer_apellido AS Nombre_Paciente,
    C.Fecha_Cita,
    C.Diagnostico
FROM Citas C
JOIN Doctores DOC ON C.Id_Doctor = DOC.Id_Doctor
JOIN Personas D ON DOC.Numero_Doc = D.Numero_doc -- Persona del Doctor
JOIN Personas P ON C.Id_Paciente = P.Numero_doc -- Persona del Paciente (asumiendo FK Citas(Id_Paciente) -> Personas(Numero_doc))
WHERE
    DOC.Id_Doctor = 101 -- Reemplazar con el ID del Doctor
    AND C.Fecha_Cita BETWEEN DATE '2025-01-01' AND DATE '2025-03-31' -- Reemplazar con el rango de fechas
ORDER BY
    C.Fecha_Cita DESC;

    SELECT
    CU.N_Cuarto,
    CU.Tipo_Cuarto,
    CU.Estado,
    COALESCE(PE.primer_nombre || ' ' || PE.primer_apellido, 'N/A') AS Nombre_Ocupante,
    COALESCE(PE.Tipo_documento || ': ' || PE.Numero_doc, 'N/A') AS Identificacion_Ocupante
FROM Cuartos CU
LEFT JOIN Personas PE ON CU.ocupante = PE.Numero_doc
WHERE
    CU.Estado IN ('Disponible', 'Ocupado') -- Filtrar por cuartos relevantes para admisión
ORDER BY
    CU.Estado DESC, CU.N_Cuarto ASC;

    SELECT
    P.primer_nombre || ' ' || P.primer_apellido AS Nombre_Paciente,
    HC.Nombre_Eps AS EPS_Registrada,
    V.Fecha AS Fecha_Visita,
    V.Sintomas,
    V.Diagnostico,
    V.Tratamiento
FROM Pacientes PA
JOIN Personas P ON PA.Numero_Doc = P.Numero_doc
JOIN HistoriasClinicas HC ON PA.Id_Historia = HC.Id_Historia -- Asumiendo corrección en Pacientes(Id_Historia)
JOIN Visitas V ON HC.Id_Historia = V.Id_Historia
WHERE
    P.Numero_doc = 12345678 -- Reemplazar con el Número de Documento del Paciente
ORDER BY
    V.Fecha DESC;


-- End consultas-- *******************************************

-- Restricción en Personas: El Tipo_documento debe ser consistente con la longitud o el formato.
ALTER TABLE Personas ADD CONSTRAINT CHK_TIPO_DOC_VALIDO CHECK (
    (Tipo_documento = 'CC' AND LENGTH(Numero_doc) BETWEEN 8 AND 12) OR
    (Tipo_documento = 'TI' AND LENGTH(Numero_doc) BETWEEN 6 AND 10) OR
    (Tipo_documento = 'PAS' AND LENGTH(Numero_doc) BETWEEN 6 AND 15) OR
    (Tipo_documento NOT IN ('CC', 'TI', 'PAS')) -- Permite otros tipos si no se definen reglas específicas
);

-- Restricción en Cuartos: Un cuarto solo puede estar 'Ocupado' si tiene un 'ocupante' asignado.
ALTER TABLE Cuartos ADD CONSTRAINT CHK_ESTADO_OCUPANTE CHECK (
    (Estado = 'Disponible' AND ocupante IS NULL) OR
    (Estado = 'Ocupado' AND ocupante IS NOT NULL) OR
    (Estado = 'Mantenimiento') -- Un cuarto en mantenimiento no necesita ocupante
);

-- Restricción en Citas: La Fecha_Cita debe ser posterior o igual a la fecha actual (asumiendo que la cita es futura).
-- NOTA: Como 'DATE' en Oracle almacena fecha y hora, uso DATE como ejemplo simple.
ALTER TABLE Citas ADD CONSTRAINT CHK_FECHA_CITA_FUTURA CHECK (
    Fecha_Cita >= TRUNC(SYSDATE)
);

-- Restricción en Visitas: El Diagnostico solo puede existir si los Sintomas son proporcionados.
ALTER TABLE Visitas ADD CONSTRAINT CHK_SINTOMAS_DIAGNOSTICO CHECK (
    (Sintomas IS NOT NULL AND Diagnostico IS NOT NULL) OR (Sintomas IS NULL AND Diagnostico IS NULL)
);

-- Restricción en Turnos: La fecha de inicio debe ser anterior a la fecha de fin.
ALTER TABLE Turnos ADD CONSTRAINT CHK_INICIA_ACABA CHECK (
    Inicia < Acaba
);

-- *******************************************
-- ** Eliminación de FKs existentes para redefinición **
-- *******************************************

-- Asumiendo que se corrigió la FK de Doctores y Enfermeras a Personas
ALTER TABLE Doctores DROP CONSTRAINT FK_DOCTOR_PERSONA;
ALTER TABLE Enfermeras DROP CONSTRAINT FK_ENFERMERA_PERSONA;

-- *******************************************
-- ** Definición de Acciones de Referencia (ON DELETE) **
-- *******************************************

-- 1. Si elimino una Persona:

ALTER TABLE Doctores ADD CONSTRAINT FK_DOCTOR_PERSONA
FOREIGN KEY (Numero_Doc) REFERENCES Personas (Numero_doc)
ON DELETE CASCADE; -- Si se borra la persona, se borra el doctor asociado

ALTER TABLE Enfermeras ADD CONSTRAINT FK_ENFERMERA_PERSONA
FOREIGN KEY (Numero_Doc) REFERENCES Personas (Numero_doc)
ON DELETE CASCADE; -- Si se borra la persona, se borra la enfermera asociada

ALTER TABLE Cuartos ADD CONSTRAINT FK_CUARTO_OCUPANTE
FOREIGN KEY (ocupante) REFERENCES Personas (Numero_doc)
ON DELETE SET NULL; -- Si el ocupante es eliminado, el cuarto queda NULL/Disponible.

-- 2. Si elimino un Doctor:
--    - Áreas: El doctor encargado de un área pasa a ser NULL (SET NULL).
ALTER TABLE Areas DROP CONSTRAINT FK_AREA_DOCTOR_ENCARGADO;
ALTER TABLE Areas ADD CONSTRAINT FK_AREA_DOCTOR_ENCARGADO
FOREIGN KEY (doctor_encargado) REFERENCES Doctores (Id_Doctor)
ON DELETE SET NULL;

-- 3. Si elimino una Historia Clínica:
--    - Visitas: Las visitas asociadas a la historia se deben borrar (CASCADE).
ALTER TABLE Visitas DROP CONSTRAINT FK_VISITA_HISTORIA;
ALTER TABLE Visitas ADD CONSTRAINT FK_VISITA_HISTORIA
FOREIGN KEY (Id_Historia) REFERENCES HistoriasClinicas (Id_Historia)
ON DELETE CASCADE;

CREATE OR REPLACE TRIGGER trg_actualizar_estado_cuarto
AFTER INSERT OR UPDATE OF ocupante ON Cuartos
FOR EACH ROW
BEGIN
    -- Si se inserta o actualiza un ocupante, el estado debe ser 'Ocupado'
    IF :NEW.ocupante IS NOT NULL AND :NEW.Estado != 'Ocupado' THEN
        UPDATE Cuartos
        SET Estado = 'Ocupado'
        WHERE N_Cuarto = :NEW.N_Cuarto;
    -- Si el ocupante se establece en NULL, el estado debe ser 'Disponible'
    ELSIF :NEW.ocupante IS NULL AND :NEW.Estado != 'Disponible' AND :NEW.Estado != 'Mantenimiento' THEN
        UPDATE Cuartos
        SET Estado = 'Disponible'
        WHERE N_Cuarto = :NEW.N_Cuarto;
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_actualizar_estado_cita
BEFORE UPDATE OF Diagnostico ON Citas
FOR EACH ROW
BEGIN
    -- Si el Diagnostico cambia de NULL a un valor, el Estado_Cita debe ser 'Completada'
    IF :OLD.Diagnostico IS NULL AND :NEW.Diagnostico IS NOT NULL THEN
        :NEW.Estado_Cita := 'Completada';
    -- Si se elimina el Diagnostico, el Estado_Cita podría volver a 'Pendiente'
    ELSIF :OLD.Diagnostico IS NOT NULL AND :NEW.Diagnostico IS NULL THEN
        :NEW.Estado_Cita := 'Pendiente';
    END IF;
END;


CREATE OR REPLACE TRIGGER trg_check_doctor_area
BEFORE INSERT OR UPDATE OF Area_Especialidad, Especialidad ON Doctores
FOR EACH ROW
DECLARE
    v_especialidad_area VARCHAR2(100);
BEGIN
    IF :NEW.Area_Especialidad IS NOT NULL THEN
        -- Obtener la especialidad de la Área a la que se está asignando
        SELECT especialidad INTO v_especialidad_area
        FROM Areas
        WHERE Area = :NEW.Area_Especialidad;

        IF :NEW.Especialidad != v_especialidad_area THEN
            RAISE_APPLICATION_ERROR(-20001, 'La especialidad del doctor (' || :NEW.Especialidad || ') no coincide con el área (' || v_especialidad_area || ') asignada.');
        END IF;
    END IF;
END;


-- * Tuplas ok
INSERT INTO Cuartos (N_Cuarto, Estado, Tipo_Cuarto, ocupante) VALUES (101, 'Ocupado', 'Individual', 90123456);

INSERT INTO Citas (Id_Cita, Id_Paciente, Hora_Cita, Fecha_Cita, Id_Doctor, Estado_Cita) VALUES (5001, 12345678, SYSDATE + 1/24, SYSDATE + 1, 101, 'Pendiente');

INSERT INTO Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (4, 'Noche_Largo', DATE '2025-11-01 22:00:00', DATE '2025-11-02 08:00:00');

-- * Tuplas no ok

INSERT INTO Cuartos (N_Cuarto, Estado, Tipo_Cuarto, ocupante) VALUES (102, 'Ocupado', 'Doble', NULL);

INSERT INTO Citas (Id_Cita, Id_Paciente, Hora_Cita, Fecha_Cita, Id_Doctor, Estado_Cita) VALUES (5002, 87654321, SYSDATE - 1/24, DATE '2025-10-31', 102, 'Pendiente');

INSERT INTO Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (5, 'Turno_Invertido', DATE '2025-11-02 10:00:00', DATE '2025-11-02 08:00:00');

-- * Accesiones OK
INSERT INTO Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) VALUES (900, 'CC', 'Doctor', 'Borrable', 'docborrable@clinic.com');

INSERT INTO Doctores (Id_Doctor, Especialidad, Numero_Doc) VALUES (9000, 'Pediatria', 900);

DELETE FROM Personas WHERE Numero_doc = 900;

INSERT INTO Personas (Numero_doc, Tipo_documento, primer_nombre, primer_apellido, correo_electronico) VALUES (901, 'CC', 'Paciente', 'Sale', 'pacsale@clinic.com');

INSERT INTO Cuartos (N_Cuarto, Estado, Tipo_Cuarto, ocupante) VALUES (201, 'Ocupado', 'Suite', 901);

DELETE FROM Personas WHERE Numero_doc = 901;

INSERT INTO HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (999, 'SOS', 'Salud SOS');

INSERT INTO Visitas (Id_Visita, Fecha, Sintomas, Diagnostico, Tratamiento, Id_Historia) VALUES (9999, SYSDATE, 'Fiebre', 'Gripe', 'Reposo', 999);

DELETE FROM HistoriasClinicas WHERE Id_Historia = 999;

-- * Disparadores OK

UPDATE Cuartos SET ocupante = NULL, Estado = 'Disponible' WHERE N_Cuarto = 103;

UPDATE Cuartos SET ocupante = 90123456 WHERE N_Cuarto = 103;

-- * ----------
INSERT INTO Citas (Id_Cita, Id_Paciente, Hora_Cita, Fecha_Cita, Id_Doctor, Estado_Cita) VALUES (6001, 12345678, SYSDATE + 2, SYSDATE + 2, 101, 'Pendiente');

UPDATE Citas SET Diagnostico = 'Infección leve, receta antibiótico' WHERE Id_Cita = 6001;

-- * -----------

INSERT INTO Areas (Area, especialidad, camas) VALUES ('Cardiología General', 'Cardiología', 25);

INSERT INTO Doctores (Id_Doctor, Especialidad, Numero_Doc) VALUES (9001, 'Cardiología', 902);

UPDATE Doctores SET Area_Especialidad = 'Cardiología General' WHERE Id_Doctor = 9001;

-- * Disparadores NO OK

UPDATE Doctores SET Area_Especialidad = 'Cardiología General' WHERE Id_Doctor = 9000;
-- Asumiendo Doctor 9000 es 'Pediatría'.



-- *******************************************
-- ** Eliminación de Disparadores **
-- *******************************************

DROP TRIGGER trg_actualizar_estado_cuarto;
DROP TRIGGER trg_actualizar_estado_cita;
DROP TRIGGER trg_check_doctor_area;

DROP TABLE Citas CASCADE CONSTRAINTS;
DROP TABLE Visitas CASCADE CONSTRAINTS;
DROP TABLE Pacientes CASCADE CONSTRAINTS;
DROP TABLE Doctores CASCADE CONSTRAINTS;
DROP TABLE Enfermeras CASCADE CONSTRAINTS;
DROP TABLE Cuartos CASCADE CONSTRAINTS;
DROP TABLE Areas CASCADE CONSTRAINTS;
DROP TABLE Turnos CASCADE CONSTRAINTS;
DROP TABLE HistoriasClinicas CASCADE CONSTRAINTS;
DROP TABLE Personas CASCADE CONSTRAINTS;
DROP TABLE PQRS CASCADE CONSTRAINTS;