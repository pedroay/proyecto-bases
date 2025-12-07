--vistas para saber que cuarto esta vacío
CREATE OR REPLACE VIEW V_CUARTOS_VACIOS AS
SELECT
    N_Cuarto
FROM pyd_Cuartos
WHERE Estado = 'Disponible';

--VISta DE PERSONAS QUE VINIERON EL DIA DE HOY AL MEDICO
CREATE OR REPLACE VIEW V_VISITAS_HOY AS
SELECT
    Numero_doc
from pyd_Citas c
join pyd_Personas P on Id_Paciente=Numero_doc
where TRUNC(fecha_cita) =TRUNC(SYSDATE)

--vista de personas con citas para hoy
