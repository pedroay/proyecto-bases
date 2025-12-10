CREATE TABLE pyd_Personas (
    Numero_doc NUMBER NOT NULL,
    Tipo_documento VARCHAR2(10) NOT NULL,
    primer_nombre VARCHAR2(50) NOT NULL,
    segundo_nombre VARCHAR2(50),
    primer_apellido VARCHAR2(50) NOT NULL,
    segundo_apellido VARCHAR2(50),
    correo_electronico VARCHAR2(100) NOT NULL UNIQUE
);

CREATE TABLE pyd_Cuartos (
    N_Cuarto NUMBER NOT NULL,
    Estado VARCHAR2(50) NOT NULL,
    Tipo_Cuarto VARCHAR2(50) NOT NULL,
    ocupante NUMBER,
    Area VARCHAR2(100) not NULL
);

CREATE TABLE pyd_Areas (
    Area VARCHAR2(100) NOT NULL,
    especialidad VARCHAR2(100) NOT NULL,
    camas NUMBER NOT NULL,
    doctor_encargado NUMBER,
    enfermeria_jefe NUMBER
);

CREATE TABLE pyd_Doctores (
    Id_Doctor NUMBER NOT NULL,
    Especialidad VARCHAR2(100) NOT NULL,
    Area_Especialidad VARCHAR2(100),
    T_Turno NUMBER,
    Numero_Doc NUMBER NOT NULL
);

CREATE TABLE pyd_Enfermeras (
    Id_Enfermera NUMBER NOT NULL,
    Area VARCHAR2(100),
    Especialidad VARCHAR2(100),
    Turno NUMBER,
    Numero_Doc NUMBER NOT NULL
);

CREATE TABLE pyd_Pacientes (
    Id_Paciente NUMBER NOT NULL,
    Id_Eps NUMBER NOT NULL,
    Eps VARCHAR2(100) NOT NULL,
    Numero_Doc NUMBER NOT NULL
);

CREATE TABLE pyd_HistoriasClinicas (
    Id_Historia NUMBER NOT NULL,
    Eps VARCHAR2(100) ,
    Nombre_Eps VARCHAR2(100),
    id_paciente NUMBER NOT NULL
);

CREATE TABLE pyd_Visitas (
    Id_Visita NUMBER NOT NULL,
    Fecha DATE NOT NULL,
    Sintomas VARCHAR2(255) NOT NULL,
    Examen VARCHAR2(255),
    Diagnostico VARCHAR2(255) NOT NULL,
    Tratamiento VARCHAR2(255) NOT NULL,
    Id_Historia NUMBER NOT NULL
);

CREATE TABLE pyd_Turnos (
    Tipo_Turno NUMBER NOT NULL,
    Nombre_Turno VARCHAR2(50) NOT NULL,
    Inicia DATE NOT NULL,
    Acaba DATE NOT NULL
);

CREATE TABLE pyd_Citas (
    Id_Cita NUMBER NOT NULL,
    Id_Paciente NUMBER NOT NULL,
    Hora_Cita DATE NOT NULL,
    Fecha_Cita DATE NOT NULL,
    Id_Doctor NUMBER NOT NULL,
    Diagnostico VARCHAR2(255),
    Estado_Cita VARCHAR2(50) NOT NULL
);

CREATE TABLE pyd_PQRS (
    Id_PQR NUMBER NOT NULL,
    Descripcion VARCHAR2(255) NOT NULL,
    Tema VARCHAR2(100),
    Cadena VARCHAR2(255)
);