-- LEFT JOIN EXCLUSIVO, solo trae el lado izq, no incluye ni la intersección, ni el lado derecho
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


-- LEFT JOIN (NORMAL O INCLUSIVO), trae el lado izq y la intersección, no el lado derecho
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	LEFT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
-- WHERE c.id is NULL -- simplemente se quita esto
ORDER BY a.carrera_id;


-- RIGHT JOIN (NORMAL O INCLUSIVO), trae el lado derecho y la intersección, no el lado izquierdo
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	RIGHT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
ORDER BY a.carrera_id;


-- RIGHT JOIN EXCLUSIVO, solo trae el lado derecho, no incluye ni la intersección, ni el lado izquierdo
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	RIGHT JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE a.id is NULL
ORDER BY a.carrera_id;


-- FULL OUTER JOIN, trae todo de ambas tablas, incluye el lado izquierdo, el derecho y la intersección
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


-- INNER JOIN, trae la intersección, no el lado izquierdo ni el derecho
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	INNER JOIN platzi.carreras AS c -- Puede colocarse el INNER JOIN o simplemente JOIN
	-- JOIN platzi.carreras AS c -- Sí solo se coloca JOIN, se asume que es un INNER JOIN
	ON a.carrera_id = c.id
ORDER BY a.carrera_id;


-- Diferencia Simétrica, trae los elementos que no están en la intersección
SELECT a.nombre,
		a.apellido,
		a.carrera_id,
		c.id,
		c.carrera
FROM platzi.alumnos AS a
	FULL OUTER JOIN platzi.carreras AS c
	ON a.carrera_id = c.id
WHERE a.id IS NULL
	OR c.id IS NULL
ORDER BY a.carrera_id DESC, c.id DESC;