SELECT carrera_id, COUNT(*) AS cuenta
FROM platzi.alumnos
GROUP BY carrera_id
ORDER BY cuenta DESC;

-- Diferencias, es seleccionar el lado izquierdo en una unión de diagrama Ben, o encontrar alumnos que no tienen carrera

SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	LEFT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE c.id is NULL
ORDER BY a.carrera_id;


-- Reto: traer todo de ambas tablas
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	FULL OUTER JOIN platzi.carreras AS c -- Se ocupa un FULL OUTER JOIN para traer todo de ambas tablas
	ON a.carrera_id = c.id
-- WHERE c.id is NULL
ORDER BY a.carrera_id;