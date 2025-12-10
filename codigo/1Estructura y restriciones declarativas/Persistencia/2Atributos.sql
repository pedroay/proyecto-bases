ALTER TABLE pyd_Personas ADD CONSTRAINT CHK_TIPO_DOC_VALIDO CHECK (
    (Tipo_documento = 'CC' AND LENGTH(Numero_doc) BETWEEN 8 AND 12) OR
    (Tipo_documento = 'TI' AND LENGTH(Numero_doc) BETWEEN 6 AND 10) OR
    (Tipo_documento = 'PAS' AND LENGTH(Numero_doc) BETWEEN 6 AND 15) OR
    (Tipo_documento NOT IN ('CC', 'TI', 'PAS'))
);

ALTER TABLE pyd_Cuartos ADD CONSTRAINT CHK_ESTADO_OCUPANTE CHECK (
    (Estado = 'Disponible' AND ocupante IS NULL) OR
    (Estado = 'Ocupado' AND ocupante IS NOT NULL) OR
    (Estado = 'Mantenimiento')
);