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