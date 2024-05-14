SELECT *
FROM generate_series(1,5);
-- Se genera una serie de 1 a 5
-- 1
-- 2
-- 3
-- 4
-- 5

SELECT *
FROM generate_series(5,1); -- no genera nada

SELECT *
FROM generate_series(5,1,-2); -- -2 es el paso
-- se genera una serie de 5 a 1 con un paso de -2
-- 5
-- 3
-- 1


SELECT *
FROM generate_series(1.1, 4, 1.3);
-- 1.1
-- 2.4
-- 3.7


SELECT current_date + s.a AS dates -- Se le suma a la fecha actual la serie generada de la tabla s y la columna a
FROM generate_series(0, 14, 7) AS s(a) -- A la tabla generada se le asigna un alias S y la columna generada se le asigna el alias a
-- genera la fecha actual y le suma 0, 7 y 14 días
-- "2024-05-14"
-- "2024-05-21"
-- "2024-05-28"



SELECT *
FROM generate_series('2020-09-01 00:00:00'::timestamp, -- ::timestamp es para convertir el tipo de dato de string a timestamp, los dos puntos es lo mismo que CAST()
					'2020-09-04 00:00:00', '10 hours');
-- Se genera una serie de fechas de 2020-09-01 a 2020-09-04 con un paso de 10 horas
-- "2020-09-01 00:00:00"
-- "2020-09-01 10:00:00"
-- "2020-09-01 20:00:00"
-- "2020-09-02 06:00:00"
-- "2020-09-02 16:00:00"
-- "2020-09-03 02:00:00"
-- "2020-09-03 12:00:00"


SELECT a.id,
	    a.nombre,
	    a.apellido,
	    a.carrera_id,
	    s.a
FROM platzi.alumnos AS a -- Le colocamos un alias a la tabla alumnos
	INNER JOIN generate_series(0, 10) AS s(a) -- Se genera una serie de 0 a 10 y se le asigna el alias s y la columna generada se le asigna el alias a
	ON s.a = a.carrera_id -- Los unimos 
ORDER BY a.carrera_id;
-- Devuelve los alumnos que su carrera id está en la serie generada


-- Reto: Generar un triangulo con serie generada
SELECT LPAD('*', CAST(s.a AS int), '*')
FROM (
    SELECT generate_series(0, 10)
    UNION ALL -- UNION ALL es para colocar una segunda tabla abajo de la otra
    SELECT generate_series(9, 1, -1)
) AS s(a);

-- Resultado:
*
**
***
****
*****
******
*******
********
*********
**********
*********
********
*******
******
*****
****
***
**
*