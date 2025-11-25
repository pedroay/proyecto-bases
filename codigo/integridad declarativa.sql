ALTER TABLE pyd_Personas ADD CONSTRAINT CHK_TIPO_DOC_VALIDO CHECK (
    (Tipo_documento = 'CC' AND LENGTH(Numero_doc) BETWEEN 8 AND 12) OR
    (Tipo_documento = 'TI' AND LENGTH(Numero_doc) BETWEEN 6 AND 10) OR
    (Tipo_documento = 'PAS' AND LENGTH(Numero_doc) BETWEEN 6 AND 15) OR
    (Tipo_documento NOT IN ('CC', 'TI', 'PAS'))
);

-- Restricción en pyd_Cuartos: Un cuarto solo puede estar 'Ocupado' si tiene un 'ocupante' asignado.
ALTER TABLE pyd_Cuartos ADD CONSTRAINT CHK_ESTADO_OCUPANTE CHECK (
    (Estado = 'Disponible' AND ocupante IS NULL) OR
    (Estado = 'Ocupado' AND ocupante IS NOT NULL) OR
    (Estado = 'Mantenimiento')
);

-- Restricción en pyd_Visitas: El Diagnostico solo puede existir si los Sintomas son proporcionados (ambos deben estar presentes o ausentes).
ALTER TABLE pyd_Visitas ADD CONSTRAINT CHK_SINTOMAS_DIAGNOSTICO CHECK (
    (Sintomas IS NOT NULL AND Diagnostico IS NOT NULL) OR (Sintomas IS NULL AND Diagnostico IS NULL)
);

-- Restricción en pyd_Turnos: La fecha de inicio debe ser anterior a la fecha de fin.
ALTER TABLE pyd_Turnos ADD CONSTRAINT CHK_INICIA_ACABA CHECK (
    Inicia < Acaba
);