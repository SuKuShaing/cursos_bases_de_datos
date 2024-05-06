-- En los siguientes 3 casos traemos le primer registro de la tabla

SELECT *
FROM platzi.alumnos
FETCH FIRST 1 ROWS ONLY; -- Trae la primera fila de la tabla o los primeros registros de la tabla
-- FETCH se utiliza para recuperar una fila de un conjunto de resultados

-- Limita a uno
SELECT *
FROM platzi.alumnos
LIMIT 1;

-- aquí se utiliza ROW_NUMBER() para asignar un número de fila a cada fila en la tabla y luego se filtra por el número de fila 1
SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, * -- ROW_NUMBER() le coloca un número a cada fila de la tabla -- OVER() se utiliza con funciones de ventana para determinar el conjunto de filas sobre las que se aplica la función
	FROM platzi.alumnos
) AS alumnos_with_row_num
WHERE row_id = 1;