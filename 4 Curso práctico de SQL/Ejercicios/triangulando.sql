-- LPAD() es una función que rellena una cadena de texto con un carácter específico hasta llegar a una longitud determinada

SELECT LPAD('sql', 15, '*')
-- ************sql
-- Genera una cadena de 15 caracteres, si la cadena es menor de 15 caracteres, rellenar con asteriscos


SELECT LPAD('sql', id, '*')
FROM platzi.alumnos
WHERE id < 10;
-- irá rellenando con asteriscos hasta llegar a la longitud de la columna id
-- s
-- sq
-- sql
-- *sql
-- **sql
-- ***sql
-- ****sql
-- *****sql


SELECT LPAD('*', CAST(row_id AS int), '*') -- CAST(row_id AS int) es para convertir el tipo de dato a otro, en este caso de bigint a int, sí no se convierte lanza un error de tipo de dato
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 5;



SELECT LPAD('*', CAST(row_id AS int), '*')
FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, * -- Se ordena por carrera_id para generar el el row_id
	FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 5
ORDER BY carrera_id; -- Se ordena por carrera_id
-- por ende queda ordenado el row_id por carrera_id y el triangulo sale bien


-- RPAD() es una función que rellena una cadena de texto con un carácter específico hasta llegar a una longitud determinada

SELECT RPAD('seba', CAST(row_id AS int), '*')
FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_id
WHERE row_id <= 10
ORDER BY carrera_id;