-- En este ejercicio vamos a seleccionar algunos datos, un set de datos

SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, * -- ROW_NUMBER() OVER() es una función que asigna un número a cada fila
	FROM platzi.alumnos
) AS alumnos_with_row_num -- Se le tiene que colocar un nombre a las ventanas


SELECT *
FROM platzi.alumnos
WHERE id IN (1, 5, 10, 12, 15, 20);


SELECT *
FROM platzi.alumnos
WHERE id IN (
	SELECT id
	FROM platzi.alumnos
	WHERE tutor_id = 30
		AND carrera_id = 31
);
-- Retorna los alumnos que tienen tutor_id 30 y carrera_id 31


SELECT *
FROM platzi.alumnos
WHERE tutor_id = 30
AND carrera_id = 31;
-- Retorna lo mismo que lo anterior, pero más simple
-- La ventaja de un query anidado es que se puede complejizar mucho más


-- Reto: retornar los que no son del tutor 30
-- Manera 1
SELECT *
FROM platzi.alumnos
WHERE id IN (
	SELECT id
	FROM platzi.alumnos
	WHERE tutor_id != 30 -- solo le agregué el signo de exclamación (no es igual a)
	-- WHERE tutor_id <> 30 -- también se puede hacer de esta manera (diferente de)
);

-- Manera 2
SELECT *
FROM platzi.alumnos
WHERE id NOT IN ( -- Le agregué NOT
	SELECT id
	FROM platzi.alumnos
	WHERE tutor_id = 30
);