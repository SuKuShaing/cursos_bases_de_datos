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



SELECT carrera_id, 
	MAX(fecha_incorporacion)
FROM platzi.alumnos
GROUP BY carrera_id
ORDER BY carrera_id;
--  Usando Max y Group by se puede obtener la fecha más reciente para cada carrera

-- Reto: obtener el nombre mínimo y obtener el nombre mínimo para cada tutor
SELECT MIN(nombre)
FROM platzi.alumnos


SELECT tutor_id, MIN(nombre)
FROM platzi.alumnos
GROUP BY tutor_id
ORDER BY tutor_id