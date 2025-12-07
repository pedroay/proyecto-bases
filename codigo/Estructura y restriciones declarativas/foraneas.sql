--foraneas 
    ALTER TABLE pyd_Doctores ADD CONSTRAINT FK_DOCTOR_PERSONA
    FOREIGN KEY (Numero_Doc) REFERENCES pyd_Personas (Numero_doc)
    ON DELETE CASCADE;

    ALTER TABLE pyd_Enfermeras ADD CONSTRAINT FK_ENFERMERA_PERSONA
    FOREIGN KEY (Numero_Doc) REFERENCES pyd_Personas (Numero_doc)
    ON DELETE CASCADE;

    ALTER TABLE pyd_Pacientes ADD CONSTRAINT FK_PACIENTE_PERSONA
    FOREIGN KEY (Numero_Doc) REFERENCES pyd_Personas (Numero_doc)
    ON DELETE CASCADE;

    ALTER TABLE pyd_Cuartos ADD CONSTRAINT FK_CUARTO_OCUPANTE
    FOREIGN KEY (ocupante) REFERENCES pyd_Personas (Numero_doc)
    on delete set null;

    ALTER TABLE pyd_Areas ADD CONSTRAINT FK_AREA_DOCTOR_ENCARGADO
    FOREIGN KEY (doctor_encargado) REFERENCES pyd_Doctores (Id_Doctor)
    on delete set null;

    ALTER TABLE pyd_Areas ADD CONSTRAINT FK_AREA_ENFERMERA_JEFE
    FOREIGN KEY (enfermeria_jefe) REFERENCES pyd_Enfermeras (Id_Enfermera)
    on delete set null;

    ALTER TABLE pyd_Doctores ADD CONSTRAINT FK_DOCTOR_AREA
    FOREIGN KEY (Area_Especialidad) REFERENCES pyd_Areas (Area)
    on delete set null;

    ALTER TABLE pyd_Doctores ADD CONSTRAINT FK_DOCTOR_TURNO
    FOREIGN KEY (T_Turno) REFERENCES pyd_Turnos (Tipo_Turno)
    on delete set null;


    ALTER TABLE pyd_Enfermeras ADD CONSTRAINT FK_ENFERMERA_AREA
    FOREIGN KEY (Area) REFERENCES pyd_Areas (Area)
    on delete set null;

    ALTER TABLE pyd_Enfermeras ADD CONSTRAINT FK_ENFERMERA_TURNO
    FOREIGN KEY (Turno) REFERENCES pyd_Turnos (Tipo_Turno)
    on delete set null;

    ALTER TABLE pyd_Pacientes ADD CONSTRAINT FK_PACIENTE_HISTORIA
    FOREIGN KEY (Id_paciente) REFERENCES pyd_HistoriasClinicas (Id_Historia);

    ALTER TABLE pyd_Visitas ADD CONSTRAINT FK_VISITA_HISTORIA
    FOREIGN KEY (Id_Historia) REFERENCES pyd_HistoriasClinicas (Id_Historia)
    ON DELETE CASCADE;

    ALTER TABLE pyd_Citas ADD CONSTRAINT FK_CITA_PACIENTE
    FOREIGN KEY (Id_Paciente) REFERENCES pyd_Personas (Numero_doc)
    ON DELETE CASCADE;

    ALTER TABLE pyd_Citas ADD CONSTRAINT FK_CITA_DOCTOR
    FOREIGN KEY (Id_Doctor) REFERENCES pyd_Doctores (Id_Doctor)
    ON DELETE CASCADE;