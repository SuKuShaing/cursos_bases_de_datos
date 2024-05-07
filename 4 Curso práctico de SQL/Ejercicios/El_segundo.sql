-- En este ejercicio, vamos a encontrar el segundo valor más alto de una columna en una tabla

SELECT DISTINCT colegiatura
FROM platzi.alumnos AS a1
WHERE 2 = (
	SELECT COUNT (DISTINCT colegiatura)
	FROM platzi.alumnos a2
	WHERE a1.colegiatura <= a2.colegiatura
);
-- Retorna una columna llamada colegiatura con una fila con el segundo valor más alto de la columna colegiatura


SELECT DISTINCT colegiatura, tut
FROM platzi.alumnos
ORDER BY colegiatura DESC
LIMIT 1 OFFSET 1; -- OFFSET 1 es sáltate el primer valor
-- Retorna una columna llamada colegiatura con una fila con el segundo valor más alto de la columna colegiatura
-- Esta es más rápida que la de arriba

-- Colegiatura más alta con ese tutor
SELECT DISTINCT colegiatura, tutor_id
FROM platzi.alumnos
WHERE tutor_id = 20
ORDER BY colegiatura DESC
LIMIT 1 OFFSET 1;


SELECT DISTINCT *
FROM platzi.alumnos AS datos_alumnos
INNER JOIN (
	SELECT DISTINCT colegiatura
    -- SELECT DISTINCT colegiatura, tutor_id -- así debiese ser y se obtiene los alumnos con la colegiatura más alta y con ese tutor
	FROM platzi.alumnos
	WHERE tutor_id = 20 -- dado que no está tutor_id en el listado de columnas, este where es omitido
	ORDER BY colegiatura DESC
	LIMIT 1 OFFSET 1
) AS segunda_mayor_colegiatura
ON datos_alumnos.colegiatura = segunda_mayor_colegiatura.colegiatura;
-- Trae todos los alumnos que pagan 4800 que son los que pagan la segunda colegiatura más alta


SELECT DISTINCT *
FROM platzi.alumnos AS datos_alumnos
WHERE colegiatura = (
	SELECT DISTINCT colegiatura
	FROM platzi.alumnos
	ORDER BY colegiatura DESC
	LIMIT 1 OFFSET 1
);
-- Trae todos los alumnos que pagan 4800 que son los que pagan la segunda colegiatura más alta



-- Retornar la mitad inferior de la tabla
SELECT *
FROM platzi.alumnos
LIMIT (
	SELECT COUNT(*)/2
	FROM platzi.alumnos
) OFFSET (
	SELECT COUNT(*)/2
	FROM platzi.alumnos
);


-- La mejor solución que encontré
SELECT *
FROM platzi.alumnos
OFFSET (
	SELECT COUNT(*)/2
	FROM platzi.alumnos
);