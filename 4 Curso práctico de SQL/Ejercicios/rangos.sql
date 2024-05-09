-- Manejo de rangos

SELECT *
FROM platzi.alumnos
WHERE tutor_id IN (1, 2, 3, 4)
ORDER BY tutor_id ASC;


SELECT *
FROM platzi.alumnos
WHERE tutor_id BETWEEN 1 AND 10;


SELECT int4range(1, 20) @> 3; -- El @> significa "contiene", devuelve un True
-- Los rangos devulven [1, 20), es decir el 1 incluido en el rango y el 20 no incluido


SELECT numrange(11.1, 22.2); -- Te da un rango de números "[11.1,22.2) '[ <- incluido', ') <- no incluido', por ende es el 11.1 incluido en el rango y el 22.2 no incluido " 


SELECT * FROM generate_series(1, 20); -- Te muestra una lista con los número en la serie generada


SELECT UPPER(int8range(15,25)); -- Te da el valor más bajo del rango


SELECT LOWER(int8range(15,25)); -- Te da el valor más alto del rango


SELECT int4range(10, 20) * int4range(15,25); -- Regresa la intersección (15,20)


SELECT ISEMPTY(numrange(1,5)); -- Verifica sí es vacio


SELECT *
FROM platzi.alumnos
WHERE int4range(10, 20) @> tutor_id
ORDER BY tutor_id;
-- Devuelve la tabla con los tutores dentro de ese rango


-- Los tipos de rango que vienen en PostgreSQL son:
-- -- int4range: Que trae un rango de enteros.

-- -- int8range: Es un rango de enteros grandes.

-- -- numrange: Es un rango numérico.

-- -- tsrange: Es un rango del tipo timestamp pero sin la zona horaria.

-- -- tstzrange: Es un rango del tipo timestamp con la zona horaria

-- -- daterange: Es un rango del tipo fecha.

-- Esos son los que podemos usar como selectores de rango dentro de PostgreSQL si les interesa conocer más Acá (https://www.postgresql.org/docs/9.2/rangetypes.html)


-- Reto: Encontrar cruce de rangos
SELECT numrange(
	(SELECT min(tutor_id) FROM platzi.alumnos),
	(SELECT max(tutor_id) FROM platzi.alumnos)
) * numrange(
	(SELECT min(carrera_id) FROM platzi.alumnos),
	(SELECT max(carrera_id) FROM platzi.alumnos)
)