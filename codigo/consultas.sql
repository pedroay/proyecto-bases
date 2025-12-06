SELECT
    D.primer_nombre || ' ' || D.primer_apellido AS Nombre_Doctor,
    P.primer_nombre || ' ' || P.primer_apellido AS Nombre_Paciente,
    C.Fecha_Cita,
    C.Diagnostico
FROM pyd_Citas C
JOIN pyd_Doctores DOC ON C.Id_Doctor = DOC.Id_Doctor
JOIN pyd_Personas D ON DOC.Numero_Doc = D.Numero_doc -- Persona del Doctor
JOIN pyd_Personas P ON C.Id_Paciente = P.Numero_doc -- Persona del Paciente
WHERE
    DOC.Id_Doctor = 1013259701 -- Reemplazar con el ID del Doctor deseado
    AND C.Fecha_Cita BETWEEN DATE '2025-01-01' AND DATE '2025-03-31' -- Reemplazar con el rango de fechas
ORDER BY
    C.Fecha_Cita DESC;


    SELECT
    CU.N_Cuarto,
    CU.Tipo_Cuarto,
    CU.Estado,
    COALESCE(PE.primer_nombre || ' ' || PE.primer_apellido, 'N/A') AS Nombre_Ocupante,
    COALESCE(PE.Tipo_documento || ': ' || PE.Numero_doc, 'N/A') AS Identificacion_Ocupante
FROM pyd_Cuartos CU
LEFT JOIN pyd_Personas PE ON CU.ocupante = PE.Numero_doc
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
FROM pyd_Pacientes PA
JOIN pyd_Personas P ON PA.Numero_Doc = P.Numero_doc
JOIN pyd_HistoriasClinicas HC ON PA.Id_Historia = HC.Id_Historia -- Nota: Asegúrate de que esta columna exista en pyd_Pacientes
JOIN pyd_Visitas V ON HC.Id_Historia = V.Id_Historia
WHERE
    P.Numero_doc = 10000422 -- Reemplazar con el Número de Documento del Paciente
ORDER BY
    V.Fecha DESC;
