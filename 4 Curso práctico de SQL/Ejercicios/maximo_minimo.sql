-- Obtener máximo y mínimo de una tabla

SELECT numrange(
	(SELECT min(tutor_id) FROM platzi.alumnos),
	(SELECT max(tutor_id) FROM platzi.alumnos)
) * numrange(
	(SELECT min(carrera_id) FROM platzi.alumnos), -- Se obtiene el valor mínimo de la columna carrera_id
	(SELECT max(carrera_id) FROM platzi.alumnos) -- Se obtiene el valor máximo de la columna carrera_id
)




SELECT fecha_incorporacion
FROM platzi.alumnos
ORDER BY fecha_incorporacion DESC
LIMIT 1;
-- Se ordena por fecha y se obtiene la fecha más reciente
-- si fuese ASC se obtendría la fecha más antigua