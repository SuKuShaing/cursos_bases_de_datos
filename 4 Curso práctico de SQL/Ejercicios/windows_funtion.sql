-- Windows function
-- Son funciones que se aplican a un conjunto de filas y devuelven un solo valor para cada fila del conjunto
-- Realizan cálculos en algunas tuplas que se encuentran relacionadas con la tupla actual


SELECT *,
	AVG(colegiatura) OVER(PARTITION BY carrera_id)
FROM platzi.alumnos
-- Está particionado por carrera_id, cada id va a ser un grupo
-- Devuelve todas las columnas y al final una columna con el promedio de colegiatura por carrera
-- Cada carrera_id, un promedio igual entre ellas y diferente promedio con otro id de carrera


SELECT *,
	AVG(colegiatura) OVER()
FROM platzi.alumnos
-- No hay partición, se toma todo el conjunto de datos y se promedia
-- Devuelve todas las columnas y al final una columna con el promedio de colegiatura de todos los alumnos
-- En la columna final hay un está el promedio para todos los alumnos


SELECT *,
	SUM(colegiatura) OVER(ORDER BY colegiatura)
FROM platzi.alumnos
-- Suma las colegiaturas que están por encima de la fila actual, pero por grupo, tomo todas las de 2000 y las sumo y le puso el resultado a cada una de ellas
-- Cuando llega a la siguiente 2300, suma las colegiaturas de 2300 y 2000 y le pone el resultado a cada una de las de 2300 y así con las que siguen


SELECT *,
	SUM(colegiatura) OVER(PARTITION BY carrera_id ORDER BY colegiatura)
FROM platzi.alumnos
-- Ahora el proceso es el mismo, solo que vuelve a reiniciar por cada carrera_id


SELECT *,
	RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC)
FROM platzi.alumnos
-- Por cada carrera_id, ordena las colegiaturas de mayor a menor y le asigna un rango,
-- la colegiatura más cara de 5000 tiene el rango 1 y hay 4 colegiaturas del mismo valor, esas 4 tienen el rango 1
-- ahora la colegiatura de 4500 tiene el rango 5, en vez del rango 2, y es el 5 porque hay 4 antes de esta, y todas las del mismo valor tienen el mismo rango 5
-- Todo esto se reinicia por cada carrera_id, porque está partido, en el carrera_id 2 se resetea el rango y parte de nuevo desde 1


SELECT *,
	RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
FROM platzi.alumnos
ORDER BY carrera_id, brand_rank
-- Ordena primero por carrera_id y luego por brand_rank, sinceramente lo veo igual que el anterior el orden


SELECT *,
	RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
FROM platzi.alumnos
WHERE brand_rank < 3 -- lanzará un error
ORDER BY carrera_id, brand_rank
-- Lanza un error porque Brand_rank no existe aún dado que la Windows function se ejecuta al final o casi al final 
-- solo antes de Order By, por ende, cuando el sistema pasa por Where aún no existe ese campo (brand_rank) por el cual buscar


-- Para solucionar el error anterior, se puede hacer un subquery
SELECT *
FROM(
	SELECT *,
	RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
	FROM platzi.alumnos
) AS ranked_colegiaturas_por_carrera
WHERE brand_rank < 3
ORDER BY carrera_id, brand_rank
-- Ahora si funciona porque el campo brand_rank ya existe en el subquery y se puede hacer el filtro
-- ahora viene ordenado por carrera_id y después por brand_rank



-- Más ejemplos de la siguiente clase

SELECT ROW_NUMBER() OVER() AS row_id, *
FROM platzi.alumnos;
-- Asigna un número de fila a cada fila, sin importar el orden, solo asigna un número de fila a cada una
-- Coincide el número de fila con el id del alumno


SELECT ROW_NUMBER() OVER(ORDER BY fecha_incorporacion) AS row_id, *
FROM platzi.alumnos;
-- Ahora asigna un número de fila a cada fila, pero ordenado por fecha de incorporación
-- El número de fila (que está ordenado) no coincide con el id del alumno


SELECT ROW_NUMBER() OVER() AS row_id, *
FROM platzi.alumnos
ORDER BY fecha_incorporacion;
-- En este caso, primero asigna un número de fila a cada fila y luego ordena por fecha de incorporación
-- por ende el número de fila y el id coinciden, pero el orden es por fecha de incorporación
-- entonces no está ordenado


SELECT FIRST_VALUE(colegiatura) OVER() AS row_id, *
FROM platzi.alumnos;
-- En la primera columna coloca el valor de la primera fila (first_value) de la colegiatura, 5000, y lo repite en todas las filas de toda la tabla


SELECT FIRST_VALUE(colegiatura) OVER(PARTITION BY carrera_id) AS row_id, *
FROM platzi.alumnos;
-- Ahora está particionado por carrera_id, entonces del grupo de carrera_id 1, el valor de la primera fila es 4800 y lo repite en todas las filas de grupo de carrera_id 1
-- en el carrera_id 2, el valor de la primera fila es 2300 y lo repite en todas las filas de grupo de carrera_id 2


SELECT LAST_VALUE(colegiatura) OVER(PARTITION BY carrera_id) AS row_id, *
FROM platzi.alumnos;
-- lo mismo que lo anterior, pero ahora toma el valor de la última fila del grupo de carrera_id y lo repite en todas las filas del grupo


SELECT NTH_VALUE(colegiatura, 3) OVER(PARTITION BY carrera_id) AS row_id, *
FROM platzi.alumnos;
-- NTH_VALUE (valor enésimo) toma el valor de la fila que le indiquemos, en este caso, le indicamos la tercera fila
-- Toma el valor de la tercera fila del grupo de carrera_id y lo repite en todas las filas del grupo


SELECT *,
	RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS colegiatura_rank
FROM platzi.alumnos
ORDER BY carrera_id, colegiatura_rank;
-- Como ya vimos genera el ranking los primero 4 iguales valores tienen el ranking 1, el siguiente valor tiene el ranking 5
-- Tiene gaps, espacios entre posiciones, porque hay 4 valores con el mismo ranking 1, entonces el siguiente valor no es 2, es 5


SELECT *,
	DENSE_RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS colegiatura_rank
FROM platzi.alumnos
ORDER BY carrera_id, colegiatura_rank;
-- DENSE_RANK no tiene gaps, no hay espacios entre posiciones, si hay 4 valores con el mismo ranking 1, el siguiente valor del ranking es 2
-- y todos los similares tienen el 2 en el ranking


SELECT *,
	PERCENT_RANK() OVER(PARTITION BY carrera_id ORDER BY colegiatura DESC) AS colegiatura_rank
FROM platzi.alumnos
ORDER BY carrera_id, colegiatura_rank;
-- Entrega el porcentaje como decimal, el 0 es el primer valor, el 1 es el último valor
-- Calcula el porcentaje de rango, el porcentaje de la posición de la fila en el ranking
-- usa esta fórmula (rank - 1)/(total rows - 1)