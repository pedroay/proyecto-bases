--vistas para saber que cuarto esta vacío
CREATE OR REPLACE VIEW V_CUARTOS_VACIOS AS
SELECT
    N_Cuarto
FROM pyd_Cuartos
WHERE Estado = 'Disponible';

--VISta DE PERSONAS QUE VINIERON EL DIA DE HOY AL MEDICO
CREATE OR REPLACE VIEW V_VISITAS_HOY AS
SELECT
    P.Numero_doc
from pyd_Citas C
join pyd_Personas P on C.Id_Paciente= P.Numero_doc
where TRUNC(C.fecha_cita) =TRUNC(TO_DATE('2026-05-18 14:52:33', 'YYYY-MM-DD HH24:MI:SS'))

--vista para contar cuantas citas pendientes
CREATE OR REPLACE VIEW V_citas_pendientes AS
SELECT
 count(*) as citas_pentientes
from pyd_Citas
where Estado_Cita = 'Programada'

SELECT * FROM V_citas_pendientes;
