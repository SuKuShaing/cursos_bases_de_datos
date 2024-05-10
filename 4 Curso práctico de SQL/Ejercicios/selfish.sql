-- son join con la misma tabla


-- Supongamos que un alumno puede ser un tutor a la vez entonces se hace un joven con la misma tabla
SELECT a.nombre,
		a.apellido,
		t.nombre,
		t.apellido
FROM platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t
	ON a.tutor_id = t.id;


-- La misma expresión anterior pero ahora la tabla es más legible
SELECT CONCAT(a.nombre, ' ', a.apellido) AS alumno,
		CONCAT(t.nombre, ' ', t.apellido) AS tutor
FROM platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t
	ON a.tutor_id = t.id;


-- Ahora contamos cuántos alumnos tiene cada tutor y sacamos el top 10
SELECT CONCAT(t.nombre, ' ', t.apellido) AS tutor,
		COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t
	ON a.tutor_id = t.id
GROUP BY tutor
ORDER BY alumnos_por_tutor DESC
LIMIT 10;


-- Reto: obtener el número promedio de alumnos por tutor
SELECT AVG(alumnos_por_tutor) AS promedio
FROM (
	SELECT CONCAT(t.nombre, ' ', t.apellido) AS tutor,
		COUNT(*) AS alumnos_por_tutor
	FROM platzi.alumnos AS a
		INNER JOIN platzi.alumnos AS t
		ON a.tutor_id = t.id
	GROUP BY tutor
) AS alumnos_tutor;