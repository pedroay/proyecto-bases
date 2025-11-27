--PERSONAS
INSERT INTO pyd_Personas VALUES (12345678, 'CC', 'Juan', 'Perez', 'Gomez', NULL, 'juanperez@mail.com');
INSERT INTO pyd_Personas VALUES (87654321, 'CC', 'Maria', 'Lopez', 'Diaz', 'Rojas', 'marialopez@mail.com');
INSERT INTO pyd_Personas VALUES (90123456, 'CC', 'Carlos', 'Andrés', 'Ramirez', 'Torres', 'carlosramirez@mail.com');
INSERT INTO pyd_Personas VALUES (90234567, 'CC', 'Ana', 'Lucía', 'Gonzalez', 'Martinez', 'anagonzalez@mail.com');
INSERT INTO pyd_Personas VALUES (90345678, 'CC', 'Laura', 'Beatriz', 'Vargas', 'Cuellar', 'lauravargas@mail.com');
INSERT INTO pyd_Personas VALUES (90456789, 'CC', 'Pedro', 'Andrés', 'Ayala', 'Bermudez', 'pedroayala@mail.com');

--AREAS
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Cardiología', 'Cardiología', 30, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Pediatría', 'Pediatría', 45, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Urgencias', 'Medicina General', 50, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Neurología', 'Neurología', 20, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Ortopedia', 'Ortopedia', 35, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Ginecología', 'Ginecología', 25, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Oncología', 'Oncología', 15, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Rehabilitación', 'Fisioterapia', 40, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('UCI', 'Medicina Crítica', 10, NULL, NULL);
INSERT INTO pyd_Areas (Area, especialidad, camas, doctor_encargado, enfermeria_jefe) VALUES ('Cirugía', 'Cirugía General', 20, NULL, NULL);

--TURNOS

INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (1, 'Turno Matutino', TIMESTAMP '2025-01-01 07:00:00', TIMESTAMP '2025-01-01 15:00:00');
INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (2, 'Turno Vespertino', TIMESTAMP '2025-01-01 15:00:00', TIMESTAMP '2025-01-01 22:00:00');
INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (3, 'Turno Nocturno', TIMESTAMP '2025-01-01 22:00:00', TIMESTAMP '2025-01-02 07:00:00');
INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (4, 'Turno 12h Día', TIMESTAMP '2025-01-01 07:00:00', TIMESTAMP '2025-01-01 19:00:00');
INSERT INTO pyd_Turnos (Tipo_Turno, Nombre_Turno, Inicia, Acaba) VALUES (5, 'Turno 12h Noche', TIMESTAMP '2025-01-01 19:00:00', TIMESTAMP '2025-01-02 07:00:00');

--DOCTORES
INSERT INTO pyd_Doctores VALUES (101, 'Cardiología', 'Cardiología', 1, 12345678);
INSERT INTO pyd_Doctores VALUES (102, 'Pediatría', 'Pediatría', 2, 87654321);
INSERT INTO pyd_Doctores (Id_Doctor, Especialidad, Area_Especialidad, T_Turno, Numero_Doc)VALUES (103, 'Medicina General', 'Urgencias', 3, 90123456);

--ENFERMERAS
INSERT INTO pyd_Enfermeras VALUES (201, 'Cardiología', 'Cardiología', 1, 90234567);
INSERT INTO pyd_Enfermeras VALUES (202, 'Urgencias', 'Urgenciología', 2, 90345678);
INSERT INTO pyd_Enfermeras VALUES (203, 'Pediatría', 'Pediatría', 3, 90456789);

--PACIENTES
INSERT INTO pyd_Pacientes VALUES (3001, 1, 'Sanitas', 12345678);
INSERT INTO pyd_Pacientes VALUES (3002, 2, 'Sura', 87654321);
INSERT INTO pyd_Pacientes VALUES (3003, 3, 'Compensar', 90345678);

--HISTORIAS CLINICAS

INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (3001, 'Sanitas', 'EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (3002, 'Sura', 'EPS Sura');
INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (3003, 'Compensar', 'EPS Compensar');

--PYD_VISITAS

INSERT INTO pyd_Visitas VALUES (5001,SYSDATE - 10,'Dolor torácico',NULL,'Arritmia leve','Reposo + medicación',3001);
INSERT INTO pyd_Visitas VALUES (5002,SYSDATE - 5,'Fiebre',NULL,'Infección viral','Acetaminofén',3002);
INSERT INTO pyd_Visitas VALUES (5003,SYSDATE - 2,'Erupción cutánea',NULL,'Dermatitis','Cremas tópicas',3003);

--Cuartos
INSERT INTO pyd_Cuartos VALUES (101, 'Ocupado', 'Individual', 12345678);
INSERT INTO pyd_Cuartos VALUES (102, 'Disponible', 'Doble', NULL);
INSERT INTO pyd_Cuartos VALUES (103, 'Mantenimiento', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (104, 'Ocupado', 'Suite', 90345678);

--citas
INSERT INTO pyd_Citas VALUES (7001, 12345678, SYSDATE + 0.5, SYSDATE + 1, 101, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7002, 87654321, SYSDATE + 1/24, SYSDATE + 2, 102, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7003, 90345678, SYSDATE + 3/24, SYSDATE + 3, 103, NULL, 'Pendiente');

--pqrs
INSERT INTO pyd_PQRS VALUES (8001, 'Demora en atención', 'Servicio', 'Paciente reporta larga espera');
INSERT INTO pyd_PQRS VALUES (8002, 'Mala atención del personal', 'Queja', 'Actitud inapropiada');
INSERT INTO pyd_PQRS VALUES (8003, 'Felicitación al personal', 'Felicitación', 'Excelente trato');
