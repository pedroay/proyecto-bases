--PERSONAS
INSERT INTO pyd_Personas VALUES (12345678, 'CC', 'Juan', 'Perez', 'Gomez', NULL, 'juanperez@mail.com');
INSERT INTO pyd_Personas VALUES (87654321, 'CC', 'Maria', 'Lopez', 'Diaz', 'Rojas', 'marialopez@mail.com');
INSERT INTO pyd_Personas VALUES (90123456, 'CC', 'Carlos', 'Andrés', 'Ramirez', 'Torres', 'carlosramirez@mail.com');
INSERT INTO pyd_Personas VALUES (90234567, 'CC', 'Ana', 'Lucía', 'Gonzalez', 'Martinez', 'anagonzalez@mail.com');
INSERT INTO pyd_Personas VALUES (90345678, 'CC', 'Laura', 'Beatriz', 'Vargas', 'Cuellar', 'lauravargas@mail.com');
INSERT INTO pyd_Personas VALUES (90456789, 'CC', 'Pedro', 'Andrés', 'Ayala', 'Bermudez', 'pedroayala@mail.com');
INSERT INTO pyd_Personas VALUES (22345678, 'T.I', 'Carlos', 'Andrés', 'Pineda', 'Rojas', 'carlospineda0@mail.com');
INSERT INTO pyd_Personas VALUES (12345679, 'C.C', 'María', 'Lucía', 'Torres', 'García', 'maríatorres1@mail.com');
INSERT INTO pyd_Personas VALUES (12345680, 'C.C', 'Andrés', 'Felipe', 'Gómez', 'Salazar', 'andrésgómez2@mail.com');
INSERT INTO pyd_Personas VALUES (12345681, 'C.C', 'Laura', 'Camila', 'Ramírez', 'Mendoza', 'lauraramírez3@mail.com');
INSERT INTO pyd_Personas VALUES (12345682, 'C.C', 'Julián', 'Esteban', 'Martínez', 'Orozco', 'juliánmartínez4@mail.com');
INSERT INTO pyd_Personas VALUES (12345683, 'C.C', 'Valentina', 'Sofía', 'Hernández', 'Villa', 'valentinahernández5@mail.com');
INSERT INTO pyd_Personas VALUES (12345684, 'C.C', 'Felipe', 'Andrés', 'Castaño', 'Vega', 'felipecastaño6@mail.com');
INSERT INTO pyd_Personas VALUES (12345685, 'C.C', 'Natalia', 'Andrea', 'Rojas', 'Pardo', 'nataliarojas7@mail.com');
INSERT INTO pyd_Personas VALUES (12345686, 'C.C', 'Santiago', 'Daniel', 'Quintero', 'López', 'santiagoquintero8@mail.com');

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
INSERT INTO pyd_Doctores VALUES (104, 'Cardiología', 'Cardiología', 2, 12345679);
INSERT INTO pyd_Doctores VALUES (105, 'Pediatría', 'Pediatría', 3, 12345680);
INSERT INTO pyd_Doctores VALUES (106, 'Cirugía General', 'Cirugía', 1, 12345681);

--ENFERMERAS
INSERT INTO pyd_Enfermeras VALUES (201, 'Cardiología', 'Cardiología', 1, 90234567);
INSERT INTO pyd_Enfermeras VALUES (202, 'Urgencias', 'Urgenciología', 2, 90345678);
INSERT INTO pyd_Enfermeras VALUES (203, 'Pediatría', 'Pediatría', 3, 90456789);
INSERT INTO pyd_Enfermeras VALUES (204, 'UCI', 'Medicina Crítica', 4, 12345682);
INSERT INTO pyd_Enfermeras VALUES (205, 'Urgencias', 'Fisioterapia', 2, 12345683);
INSERT INTO pyd_Enfermeras VALUES (206, 'Rehabilitación', 'Oncología', 1, 12345684);

--PACIENTES
INSERT INTO pyd_Pacientes VALUES (2998, 1, 'Sanitas', 12345678);
INSERT INTO pyd_Pacientes VALUES (2999, 2, 'Sura', 87654321);
INSERT INTO pyd_Pacientes VALUES (3000, 3, 'Compensar', 90345678);
INSERT INTO pyd_Pacientes VALUES (3001, 1, 'Sanitas', 12345685);
INSERT INTO pyd_Pacientes VALUES (3002, 3, 'Compensar', 12345686);
INSERT INTO pyd_Pacientes VALUES (3003, 5, 'Nueva EPS', 12345678);

--HISTORIAS CLINICAS

INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (2998, 'Sanitas', 'EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (2999, 'Sura', 'EPS Sura');
INSERT INTO pyd_HistoriasClinicas (Id_Historia, Eps, Nombre_Eps) VALUES (3000, 'Compensar', 'EPS Compensar');
INSERT INTO pyd_HistoriasClinicas VALUES (3001, 1, 'Sanitas');
INSERT INTO pyd_HistoriasClinicas VALUES (3002, 3, 'Compensar');
INSERT INTO pyd_HistoriasClinicas VALUES (3003, 5, 'Nueva EPS');

--PYD_VISITAS

INSERT INTO pyd_Visitas VALUES (5001,SYSDATE - 10,'Dolor torácico',NULL,'Arritmia leve','Reposo + medicación',3001);
INSERT INTO pyd_Visitas VALUES (5002,SYSDATE - 5,'Fiebre',NULL,'Infección viral','Acetaminofén',3002);
INSERT INTO pyd_Visitas VALUES (5003,SYSDATE - 2,'Erupción cutánea',NULL,'Dermatitis','Cremas tópicas',3003);
INSERT INTO pyd_Visitas VALUES (5004, SYSDATE - 8, 'Dolor abdominal', 'Ecografía abdominal', 'Gastritis leve', 'Omeprazol 20mg', 3001);
INSERT INTO pyd_Visitas VALUES (5005, SYSDATE - 3, 'Dolor de cabeza', 'Tomografía', 'Migraña', 'Analgésicos', 3002);
INSERT INTO pyd_Visitas VALUES (5006, SYSDATE - 1, 'Tos seca', 'Radiografía de tórax', 'Bronquitis', 'Jarabe expectorante', 3003);

--Cuartos
INSERT INTO pyd_Cuartos VALUES (101, 'Ocupado', 'Individual', 12345678);
INSERT INTO pyd_Cuartos VALUES (102, 'Disponible', 'individual', NULL);
INSERT INTO pyd_Cuartos VALUES (103, 'Mantenimiento', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (104, 'Ocupado', 'Suite', 90345678);
INSERT INTO pyd_Cuartos VALUES (105, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (106, 'Ocupado', 'Suit', 12345684);
INSERT INTO pyd_Cuartos VALUES (107, 'Ocupado', 'Individual', 12345685);

--citas
INSERT INTO pyd_Citas VALUES (7001, 12345678, SYSDATE + 0.5, SYSDATE + 1, 101, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7002, 87654321, SYSDATE + 1/24, SYSDATE + 2, 102, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7003, 90345678, SYSDATE + 3/24, SYSDATE + 3, 103, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7004,12345686, SYSDATE + 0.35,SYSDATE + 2,104,NULL,'Pendiente');
INSERT INTO pyd_Citas VALUES (7005,12345687,SYSDATE + 0.62,SYSDATE + 3,105,NULL,'Pendiente');
INSERT INTO pyd_Citas VALUES (7006,12345688,SYSDATE + 0.12,SYSDATE + 4,106,NULL,'Realizada');

--pqrs
INSERT INTO pyd_PQRS VALUES (8001, 'Demora en atención', 'Servicio', 'Paciente reporta larga espera');
INSERT INTO pyd_PQRS VALUES (8002, 'Mala atención del personal', 'Queja', 'Actitud inapropiada');
INSERT INTO pyd_PQRS VALUES (8003, 'Felicitación al personal', 'Felicitación', 'Excelente trato');
INSERT INTO pyd_PQRS VALUES (8004, 'Retraso en la asignación de cita', 'Citas médicas', 'El paciente reporta demoras en la programación.');
INSERT INTO pyd_PQRS VALUES (8005, 'Inconformidad con el trato recibido', 'Atención al usuario', 'El paciente manifiesta mal servicio.');
INSERT INTO pyd_PQRS VALUES (8006, 'Error en datos personales', 'Actualización de datos', 'Solicita corrección en su información.');

-- 1) pyd_Personas (9 registros: 12345690 .. 12345698)
INSERT INTO pyd_Personas VALUES (12345690,'T.I','Martín','Andrés','Serrano','Paz','martinserrano0@mail.com');
INSERT INTO pyd_Personas VALUES (12345691,'C.C','Andrea','Lucía','Muñoz','Gómez','andreamunoz1@mail.com');
INSERT INTO pyd_Personas VALUES (12345692,'C.C','Diego','Fernando','Herrera','Suárez','diegoherrera2@mail.com');
INSERT INTO pyd_Personas VALUES (12345693,'C.C','Camila','María','Ortiz','Rincón','camilaortiz3@mail.com');
INSERT INTO pyd_Personas VALUES (12345694,'C.C','Javier','Luis','Pacheco','Navarro','javierpacheco4@mail.com');
INSERT INTO pyd_Personas VALUES (12345695,'C.C','Sofía','Elena','Caballero','Castillo','sofiacaballero5@mail.com');
INSERT INTO pyd_Personas VALUES (12345696,'C.C','Andrés','Mateo','Vargas','Londoño','andresvargas6@mail.com');
INSERT INTO pyd_Personas VALUES (12345697,'C.C','Lucía','Isabel','Peña','Moreno','luciapena7@mail.com');
INSERT INTO pyd_Personas VALUES (12345698,'C.C','Tomás','Alejandro','Díaz','Carrillo','tomasdiaz8@mail.com');

-- 2) pyd_Doctores (3 doctores). Usan 3 personas C.C (12345691, 12345692, 12345693)
INSERT INTO pyd_Doctores VALUES (104, 'Cardiología', 'Cardiología', 2, 12345691);
INSERT INTO pyd_Doctores VALUES (105, 'Medicina General', 'Urgencias', 3, 12345692);
INSERT INTO pyd_Doctores VALUES (106, 'Ortopedia', 'Ortopedia', 1, 12345693);

-- 3) pyd_Enfermeras (3 enfermeras). Usan 3 personas C.C distintas (12345694,12345695,12345696)
INSERT INTO pyd_Enfermeras VALUES (204, (SELECT Area FROM (SELECT 'UCI' AS Area FROM DUAL) WHERE ROWNUM=1), 'Medicina Crítica', 1, 12345694);
INSERT INTO pyd_Enfermeras VALUES (205, (SELECT Area FROM (SELECT 'Urgencias' AS Area FROM DUAL) WHERE ROWNUM=1), 'Fisioterapia', 2, 12345695);
INSERT INTO pyd_Enfermeras VALUES (206, (SELECT Area FROM (SELECT 'Rehabilitación' AS Area FROM DUAL) WHERE ROWNUM=1), 'Ginecología', 3, 12345696);

-- 4) pyd_Pacientes (4 pacientes). Id_Paciente inicia en 3006 (continuando desde 3005)
INSERT INTO pyd_Pacientes VALUES (3006, 1, 'Sanitas', 12345697);
INSERT INTO pyd_Pacientes VALUES (3007, 2, 'Sura', 12345698);
INSERT INTO pyd_Pacientes VALUES (3008, 3, 'Compensar', 12345690);
INSERT INTO pyd_Pacientes VALUES (3009, 4, 'Colsubsidio', 12345694);

-- 5) pyd_HistoriasClinicas (Id_Historia = Id_Paciente)
INSERT INTO pyd_HistoriasClinicas VALUES (3006, 'Sanitas', 'EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas VALUES (3007, 'Sura', 'EPS Sura');
INSERT INTO pyd_HistoriasClinicas VALUES (3008, 'Compensar', 'EPS Compensar');
INSERT INTO pyd_HistoriasClinicas VALUES (3009, 'Colsubsidio', 'EPS Colsubsidio');

-- 6) pyd_Visitas (4 visitas, Id_Visita desde 5009)
INSERT INTO pyd_Visitas VALUES (5009, SYSDATE - 6, 'Dolor lumbar', NULL, 'Lumbalgia', 'Analgésicos y reposo', 3006);
INSERT INTO pyd_Visitas VALUES (5010, SYSDATE - 4, 'Fiebre y tos', NULL, 'Infección respiratoria', 'Antibiótico oral', 3007);
INSERT INTO pyd_Visitas VALUES (5011, SYSDATE - 2, 'Dolor articular', NULL, 'Tendinitis', 'Fisioterapia', 3008);
INSERT INTO pyd_Visitas VALUES (5012, SYSDATE - 1, 'Mareos', NULL, 'Hipoglucemia', 'Hidratación y control', 3009);

-- 7) pyd_Cuartos (5 cuartos, N_Cuarto desde 111). ocupante = Numero_doc si Ocupado
INSERT INTO pyd_Cuartos VALUES (111, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (112, 'Ocupado', 'Suit', 12345697);
INSERT INTO pyd_Cuartos VALUES (113, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (114, 'Ocupado', 'Suit', 12345698);
INSERT INTO pyd_Cuartos VALUES (115, 'Ocupado', 'Individual', 12345690);

-- 8) pyd_Citas (5 citas, Id_Cita desde 7010). Id_Paciente = Numero_doc
INSERT INTO pyd_Citas VALUES (7010, 12345697, SYSDATE + 0.25, SYSDATE + 2, 104, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7011, 12345698, SYSDATE + 0.45, SYSDATE + 3, 105, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7012, 12345690, SYSDATE + 0.60, SYSDATE + 4, 106, NULL, 'Realizada');
INSERT INTO pyd_Citas VALUES (7013, 12345694, SYSDATE + 0.12, SYSDATE + 5, 104, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7014, 12345691, SYSDATE + 0.80, SYSDATE + 6, 105, NULL, 'Pendiente');

-- 9) pyd_PQRS (5 registros, Id_PQR desde 8010)
INSERT INTO pyd_PQRS VALUES (8010, 'Demora en la atención', 'Servicio', 'Paciente reporta espera prolongada en urgencias');
INSERT INTO pyd_PQRS VALUES (8011, 'Falla en la facturación', 'Administrativo', 'Cobro duplicado en la factura del servicio');
INSERT INTO pyd_PQRS VALUES (8012, 'Condiciones de la habitación', 'Infraestructura', 'Sollozos de humedad en el cuarto asignado');
INSERT INTO pyd_PQRS VALUES (8013, 'Queja por trato', 'Atención al usuario', 'Paciente considera que el trato no fue el adecuado');
INSERT INTO pyd_PQRS VALUES (8014, 'Solicitud de cambio de cita', 'Agendamiento', 'Paciente solicita reagendar por motivos personales');

---------------------------------------------------------
-- 1) pyd_Personas (3 nuevas personas: 12345699–12345701)
---------------------------------------------------------
INSERT INTO pyd_Personas VALUES (12345699,'C.C','Paula','Andrea','López','Cárdenas','paulalopez9@mail.com');
INSERT INTO pyd_Personas VALUES (12345700,'T.I','Samuel','Esteban','Rojas','Pardo','samuelrojas10@mail.com');
INSERT INTO pyd_Personas VALUES (12345701,'C.C','Valentina','Sofía','Cano','Rivas','valentinacano11@mail.com');

---------------------------------------------------------
-- 2) pyd_Doctores (1 doctor nuevo: 107)
-- Persona asociada: 12345699
---------------------------------------------------------
INSERT INTO pyd_Doctores VALUES (107, 'Neurología', 'Consulta Externa', 2, 12345699);

---------------------------------------------------------
-- 3) pyd_Enfermeras (1 enfermera nueva: 207)
-- Persona asociada: 12345700
---------------------------------------------------------
INSERT INTO pyd_Enfermeras VALUES (207, 'Hospitalización', 'Cuidado General', 1, 12345700);

---------------------------------------------------------
-- 4) pyd_Pacientes (2 pacientes nuevos: 3010–3011)
-- Usan documentos 12345700 y 12345701
---------------------------------------------------------
INSERT INTO pyd_Pacientes VALUES (3010, 5, 'Sanitas', 12345700);
INSERT INTO pyd_Pacientes VALUES (3011, 6, 'Sura', 12345701);

---------------------------------------------------------
-- 5) pyd_HistoriasClinicas (Id_Historia = Id_Paciente)
---------------------------------------------------------
INSERT INTO pyd_HistoriasClinicas VALUES (3010, 'Sanitas', 'Paciente afiliado a EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas VALUES (3011, 'Sura', 'Paciente afiliado a EPS Sura');

---------------------------------------------------------
-- 6) pyd_Visitas (2 nuevas visitas: 5013–5014)
---------------------------------------------------------
INSERT INTO pyd_Visitas VALUES (5013, SYSDATE - 3, 'Dolor de cabeza', NULL, 'Migraña', 'Analgésicos + reposo', 3010);
INSERT INTO pyd_Visitas VALUES (5014, SYSDATE - 1, 'Tos seca', NULL, 'Resfriado común', 'Jarabe antitusivo', 3011);

---------------------------------------------------------
-- 7) pyd_Cuartos (3 nuevos cuartos: 116–118)
-- ocupante = Numero_doc si Ocupado
---------------------------------------------------------
INSERT INTO pyd_Cuartos VALUES (116, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (117, 'Ocupado', 'Suit', 12345700);
INSERT INTO pyd_Cuartos VALUES (118, 'Ocupado', 'Individual', 12345701);

---------------------------------------------------------
-- 8) pyd_Citas (3 nuevas citas: 7015–7017)
-- Id_Paciente = Numero_doc
-- Doctor puede ser 104, 105, 106 o 107
---------------------------------------------------------
INSERT INTO pyd_Citas VALUES (7015, 12345700, SYSDATE + 0.30, SYSDATE + 2, 104, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7016, 12345701, SYSDATE + 0.55, SYSDATE + 3, 107, NULL, 'Realizada');
INSERT INTO pyd_Citas VALUES (7017, 12345699, SYSDATE + 0.75, SYSDATE + 4, 105, NULL, 'Pendiente');

---------------------------------------------------------
-- 9) pyd_PQRS (3 nuevas PQRS: 8015–8017)
---------------------------------------------------------
INSERT INTO pyd_PQRS VALUES (8015, 'Queja por ruido', 'Infraestructura', 'El paciente reporta ruidos molestos cerca del cuarto.');
INSERT INTO pyd_PQRS VALUES (8016, 'Solicita copia de historia', 'Documentación', 'Paciente pide copia completa de su historia clínica.');
INSERT INTO pyd_PQRS VALUES (8017, 'Mala atención telefónica', 'Servicio al cliente', 'Paciente afirma que no atendieron correctamente la llamada.');

---------------------------------------------------------
-- 1) pyd_Personas (3 nuevas: 12345702–12345704)
---------------------------------------------------------
INSERT INTO pyd_Personas VALUES (12345702,'C.C','María','Fernanda','García','Suárez','mariagarcia12@mail.com');
INSERT INTO pyd_Personas VALUES (12345703,'C.C','Julián','David','Torres','Méndez','juliantorres13@mail.com');
INSERT INTO pyd_Personas VALUES (12345704,'T.I','Daniela','Isabel','Ramírez','Ortega','danielaramirez14@mail.com');

---------------------------------------------------------
-- 2) pyd_Doctores (1 nuevo: 108)
-- Persona con C.C → 12345702
---------------------------------------------------------
INSERT INTO pyd_Doctores VALUES (108, 'Ortopedia', 'Cirugía', 3, 12345702);

---------------------------------------------------------
-- 3) pyd_Enfermeras (1 nueva: 208)
-- Documento no usado por doctores → 12345703
---------------------------------------------------------
INSERT INTO pyd_Enfermeras VALUES (208, 'Urgencias', 'Medicina General', 2, 12345703);

---------------------------------------------------------
-- 4) pyd_Pacientes (2 nuevos: 3012–3013)
-- Usan documentos restantes 12345703 y 12345704
---------------------------------------------------------
INSERT INTO pyd_Pacientes VALUES (3012, 1, 'Sanitas', 12345703);
INSERT INTO pyd_Pacientes VALUES (3013, 2, 'Sura', 12345704);

---------------------------------------------------------
-- 5) pyd_HistoriasClinicas (Id = Id_Paciente)
---------------------------------------------------------
INSERT INTO pyd_HistoriasClinicas VALUES (3012, 'Sanitas', 'Paciente afiliado a EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas VALUES (3013, 'Sura', 'Paciente afiliado a EPS Sura');

---------------------------------------------------------
-- 6) pyd_Visitas (2 nuevas: 5015–5016)
---------------------------------------------------------
INSERT INTO pyd_Visitas VALUES (5015, SYSDATE - 4, 'Dolor abdominal', NULL, 'Gastritis', 'Antiácidos + dieta', 3012);
INSERT INTO pyd_Visitas VALUES (5016, SYSDATE - 1, 'Fiebre y escalofríos', NULL, 'Infección viral', 'Acetaminofén + hidratación', 3013);

---------------------------------------------------------
-- 7) pyd_Cuartos (3 nuevos: 119–121)
---------------------------------------------------------
INSERT INTO pyd_Cuartos VALUES (119, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (120, 'Ocupado', 'Suit', 12345703);
INSERT INTO pyd_Cuartos VALUES (121, 'Ocupado', 'Individual', 12345704);

---------------------------------------------------------
-- 8) pyd_Citas (3 nuevas: 7018–7020)
-- Id_Paciente = Numero_doc
---------------------------------------------------------
INSERT INTO pyd_Citas VALUES (7018, 12345703, SYSDATE + 0.25, SYSDATE + 2, 108, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7019, 12345704, SYSDATE + 0.60, SYSDATE + 3, 106, NULL, 'Realizada');
INSERT INTO pyd_Citas VALUES (7020, 12345702, SYSDATE + 0.80, SYSDATE + 4, 105, NULL, 'Pendiente');

---------------------------------------------------------
-- 9) pyd_PQRS (3 nuevas: 8018–8020)
---------------------------------------------------------
INSERT INTO pyd_PQRS VALUES (8018, 'Solicitud de cambio de cuarto', 'Infraestructura', 'El paciente solicita traslado por ruido.');
INSERT INTO pyd_PQRS VALUES (8019, 'Felicitación por buena atención', 'Servicio al cliente', 'Paciente destaca amabilidad del personal.');
INSERT INTO pyd_PQRS VALUES (8020, 'Demora en entrega de medicamentos', 'Farmacia', 'Paciente reporta retraso en dispensación.');

-- ==========================
-- 1) pyd_Personas (9 personas)
-- Numero_doc 12345705 .. 12345713
-- ==========================
INSERT INTO pyd_Personas VALUES (12345705,'C.C','Marcos','Andrés','Sánchez','Pérez','marcossanchez0@mail.com');
INSERT INTO pyd_Personas VALUES (12345706,'C.C','Amanda','Lucía','Vega','González','amandavega1@mail.com');
INSERT INTO pyd_Personas VALUES (12345707,'C.C','Rodrigo','Esteban','Ruiz','Castro','rodrigoruiz2@mail.com');
INSERT INTO pyd_Personas VALUES (12345708,'C.C','Gabriela','Isabel','Cruz','Martín','gabrielacruz3@mail.com');
INSERT INTO pyd_Personas VALUES (12345709,'C.C','Héctor','Luis','Medina','Rivas','hectormedina4@mail.com');
INSERT INTO pyd_Personas VALUES (12345710,'C.C','Estefanía','María','Pinto','Lara','estefaniapinto5@mail.com');
INSERT INTO pyd_Personas VALUES (12345711,'C.C','Jorge','Daniel','Sarmiento','Ruano','jorgesarmiento6@mail.com');
INSERT INTO pyd_Personas VALUES (12345712,'C.C','Natalia','Soledad','Fuentes','Ocampo','nataliafuentes7@mail.com');
INSERT INTO pyd_Personas VALUES (12345713,'C.C','Andrés','Samuel','Molina','Zapata','andresmolina8@mail.com');

-- ==========================
-- 2) pyd_Doctores (3 doctores)
-- Id_Doctor 109..111, usan 3 docs entre las personas (12345705..12345707)
-- ==========================
INSERT INTO pyd_Doctores VALUES (109, 'Cardiología', 'Cardiología', 2, 12345705);
INSERT INTO pyd_Doctores VALUES (110, 'Pediatría', 'Pediatría', 1, 12345706);
INSERT INTO pyd_Doctores VALUES (111, 'Medicina General', 'Urgencias', 3, 12345707);

-- ==========================
-- 3) pyd_Enfermeras (3 enfermeras)
-- Id_Enfermera 209..211, usan 3 distintas (12345708..12345710)
-- ==========================
INSERT INTO pyd_Enfermeras VALUES (209, 3, 'Medicina Crítica', 1, 12345708);
INSERT INTO pyd_Enfermeras VALUES (210, 4, 'Fisioterapia', 2, 12345709);
INSERT INTO pyd_Enfermeras VALUES (211, 5, 'Ginecología', 4, 12345710);

-- ==========================
-- 4) pyd_Pacientes (3 pacientes)
-- Id_Paciente 3014..3016, Numero_doc usan 12345711..12345713 (distintos)
-- ==========================
INSERT INTO pyd_Pacientes VALUES (3014, 1, 'Sanitas', 12345711);
INSERT INTO pyd_Pacientes VALUES (3015, 2, 'Sura', 12345712);
INSERT INTO pyd_Pacientes VALUES (3016, 3, 'Compensar', 12345713);

-- ==========================
-- 5) pyd_HistoriasClinicas (Id_Historia = Id_Paciente)
-- ==========================
INSERT INTO pyd_HistoriasClinicas VALUES (3014, 'Sanitas', 'EPS Sanitas');
INSERT INTO pyd_HistoriasClinicas VALUES (3015, 'Sura', 'EPS Sura');
INSERT INTO pyd_HistoriasClinicas VALUES (3016, 'Compensar', 'EPS Compensar');

-- ==========================
-- 6) pyd_Visitas (3 visitas; Id_Visita 5017..5019)
-- Fecha = SYSDATE - random days; Sintomas/Examen/Diagnostico/Tratamiento inventados; Id_Historia uno de los anteriores
-- ==========================
INSERT INTO pyd_Visitas VALUES (5017, SYSDATE - 7, 'Dolor lumbar', 'Rayos X columna', 'Lumbalgia', 'Analgésicos y reposo', 3014);
INSERT INTO pyd_Visitas VALUES (5018, SYSDATE - 4, 'Fiebre y malestar', 'Hemograma completo', 'Infección viral', 'Antipiréticos y reposo', 3015);
INSERT INTO pyd_Visitas VALUES (5019, SYSDATE - 1, 'Tos seca persistente', 'Radiografía de tórax', 'Bronquitis leve', 'Jarabe y aerosoles', 3016);

-- ==========================
-- 7) pyd_Cuartos (5 cuartos; N_Cuarto 122..126)
-- ocupante = Numero_doc si Estado = 'Ocupado'
-- ==========================
INSERT INTO pyd_Cuartos VALUES (122, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (123, 'Ocupado', 'Suit', 12345711);
INSERT INTO pyd_Cuartos VALUES (124, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (125, 'Ocupado', 'Suit', 12345712);
INSERT INTO pyd_Cuartos VALUES (126, 'Ocupado', 'Individual', 12345713);

-- ==========================
-- 8) pyd_Citas (5 citas; Id_Cita 7021..7025)
-- Id_Paciente = Numero_doc (del paciente), Hora = SYSDATE + frac (<1), Fecha = SYSDATE + integer >=1
-- Doctores elegidos entre 109..111
-- Diagnostico = NULL; Estado_Cita ∈ {'Pendiente','Realizada'}
-- ==========================
INSERT INTO pyd_Citas VALUES (7021, 12345711, SYSDATE + 0.25, SYSDATE + 2, 109, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7022, 12345712, SYSDATE + 0.50, SYSDATE + 3, 110, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7023, 12345713, SYSDATE + 0.75, SYSDATE + 4, 111, NULL, 'Realizada');
INSERT INTO pyd_Citas VALUES (7024, 12345711, SYSDATE + 0.10, SYSDATE + 5, 109, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7025, 12345712, SYSDATE + 0.60, SYSDATE + 6, 110, NULL, 'Pendiente');

-- ==========================
-- 9) pyd_PQRS (5 registros; Id_PQR 8021..8025)
-- ==========================
INSERT INTO pyd_PQRS VALUES (8021, 'Demora en entrega de resultados', 'Laboratorio', 'Paciente reporta retraso en resultados de laboratorio');
INSERT INTO pyd_PQRS VALUES (8022, 'Ruido en el pasillo', 'Infraestructura', 'Paciente solicita cambio de habitación por ruido');
INSERT INTO pyd_PQRS VALUES (8023, 'Doble cobro', 'Administrativo', 'Paciente indica cobro duplicado en facturación');
INSERT INTO pyd_PQRS VALUES (8024, 'Falta de información sobre procedimiento', 'Información', 'Paciente solicita mejor explicación del procedimiento');
INSERT INTO pyd_PQRS VALUES (8025, 'Solicita historial médico', 'Documentación', 'Paciente pide copia de su historial clínico');
-- ==========================
-- 1) pyd_Personas (9 personas nuevas)
-- Numero_doc 12345714 .. 12345722
-- ==========================
INSERT INTO pyd_Personas VALUES (12345714,'C.C','Laura','María','Gómez','Ríos','lauragomez@mail.com');
INSERT INTO pyd_Personas VALUES (12345715,'C.C','Felipe','Andrés','Torres','Mora','felipetorres@mail.com');
INSERT INTO pyd_Personas VALUES (12345716,'C.C','Daniela','Sofía','Ramírez','Delgado','danielaramirez@mail.com');
INSERT INTO pyd_Personas VALUES (12345717,'C.C','Julián','Mateo','Pardo','Jiménez','julianpardo@mail.com');
INSERT INTO pyd_Personas VALUES (12345718,'C.C','Carolina','Isabel','Barrera','Soto','carolinabarrera@mail.com');
INSERT INTO pyd_Personas VALUES (12345719,'C.C','Mauricio','Elías','Roa','Guerrero','mauricioroa@mail.com');
INSERT INTO pyd_Personas VALUES (12345720,'C.C','Viviana','Cristina','Campos','Díaz','vivianacampos@mail.com');
INSERT INTO pyd_Personas VALUES (12345721,'C.C','Santiago','Alejandro','Álvarez','Correa','santiagoalvarez@mail.com');
INSERT INTO pyd_Personas VALUES (12345722,'C.C','Valentina','Natalia','Prieto','Tejada','valentinaprieto@mail.com');

-- ==========================
-- 2) pyd_Doctores (3 doctores)
-- Id_Doctor 112..114
-- Personas: 12345714..12345716
-- ==========================
INSERT INTO pyd_Doctores VALUES (112, 'Neurología', 'Neurología', 4, 12345714);
INSERT INTO pyd_Doctores VALUES (113, 'Dermatología', 'Dermatología', 2, 12345715);
INSERT INTO pyd_Doctores VALUES (114, 'Oncología', 'Oncología', 3, 12345716);

-- ==========================
-- 3) pyd_Enfermeras (3 enfermeras)
-- Id_Enfermera 212..214
-- Personas: 12345717..12345719
-- ==========================
INSERT INTO pyd_Enfermeras VALUES (212, 2, 'Urgencias', 1, 12345717);
INSERT INTO pyd_Enfermeras VALUES (213, 5, 'Geriatría', 2, 12345718);
INSERT INTO pyd_Enfermeras VALUES (214, 3, 'Pediatría', 4, 12345719);

-- ==========================
-- 4) pyd_Pacientes (3 pacientes)
-- Id_Paciente 3017..3019
-- Personas: 12345720..12345722
-- ==========================
INSERT INTO pyd_Pacientes VALUES (3017, 1, 'Nueva EPS', 12345720);
INSERT INTO pyd_Pacientes VALUES (3018, 2, 'Famisanar', 12345721);
INSERT INTO pyd_Pacientes VALUES (3019, 3, 'Coomeva', 12345722);

-- ==========================
-- 5) pyd_HistoriasClinicas (Id_Historia = Id_Paciente)
-- ==========================
INSERT INTO pyd_HistoriasClinicas VALUES (3017, 'Nueva EPS', 'EPS Nueva');
INSERT INTO pyd_HistoriasClinicas VALUES (3018, 'Famisanar', 'EPS Famisanar');
INSERT INTO pyd_HistoriasClinicas VALUES (3019, 'Coomeva', 'EPS Coomeva');

-- ==========================
-- 6) pyd_Visitas (3 visitas nuevas)
-- Id_Visita 5020..5022
-- ==========================
INSERT INTO pyd_Visitas VALUES (5020, SYSDATE - 5, 'Dolor abdominal', 'Ecografía abdominal', 'Gastritis', 'Omeprazol 20mg', 3017);
INSERT INTO pyd_Visitas VALUES (5021, SYSDATE - 2, 'Cefalea intensa', 'TAC cerebral', 'Migraña', 'Analgesia y reposo', 3018);
INSERT INTO pyd_Visitas VALUES (5022, SYSDATE - 1, 'Dolor en rodilla', 'Radiografía de rodilla', 'Tendinitis', 'Antiinflamatorios', 3019);

-- ==========================
-- 7) pyd_Cuartos (5 cuartos)
-- N_Cuarto 127..131
-- ocupante = Numero_doc si Estado = 'Ocupado'
-- ==========================
INSERT INTO pyd_Cuartos VALUES (127, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (128, 'Ocupado', 'Suit', 12345720);
INSERT INTO pyd_Cuartos VALUES (129, 'Disponible', 'Individual', NULL);
INSERT INTO pyd_Cuartos VALUES (130, 'Ocupado', 'Suit', 12345721);
INSERT INTO pyd_Cuartos VALUES (131, 'Ocupado', 'Individual', 12345722);

-- ==========================
-- 8) pyd_Citas (5 citas)
-- Id_Cita 7026..7030
-- Id_Paciente = Numero_doc del paciente
-- ==========================
INSERT INTO pyd_Citas VALUES (7026, 12345720, SYSDATE + 0.20, SYSDATE + 2, 112, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7027, 12345721, SYSDATE + 0.40, SYSDATE + 3, 113, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7028, 12345722, SYSDATE + 0.60, SYSDATE + 4, 114, NULL, 'Realizada');
INSERT INTO pyd_Citas VALUES (7029, 12345720, SYSDATE + 0.10, SYSDATE + 5, 112, NULL, 'Pendiente');
INSERT INTO pyd_Citas VALUES (7030, 12345721, SYSDATE + 0.70, SYSDATE + 6, 113, NULL, 'Pendiente');

-- ==========================
-- 9) pyd_PQRS (5 PQRS)
-- Id_PQR 8026..8030
-- ==========================
INSERT INTO pyd_PQRS VALUES (8026, 'Retraso en asignación de citas', 'Citas', 'Paciente solicita agilización de asignación');
INSERT INTO pyd_PQRS VALUES (8027, 'Inconformidad con la comida', 'Servicios', 'Paciente reporta mala calidad de alimentos');
INSERT INTO pyd_PQRS VALUES (8028, 'Problemas con la factura', 'Administrativo', 'Paciente pide revisión del cobro');
INSERT INTO pyd_PQRS VALUES (8029, 'Habitación fría', 'Infraestructura', 'Paciente solicita revisión del aire acondicionado');
INSERT INTO pyd_PQRS VALUES (8030, 'Atención tardía', 'Urgencias', 'Paciente reporta espera prolongada');
