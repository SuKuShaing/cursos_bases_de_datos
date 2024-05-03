SELECT IF (500 < 1000, 'YES', 'NO');

SELECT OrderID, Quantity, 
CASE
    WHEN Quantity > 30 THEN 'Over 30'
    WHEN Quantity = 30 THEN '30'
    ELSE 'Under 30'
END AS QuantityText
-- Dará una columna llamada QuantityText que tendrá el valor 'Over 30' si Quantity es mayor que 30, '30' si Quantity es igual a 30 y 'Under 30' si Quantity es menor que 30


-- nombre, apellido, carrera y año de estudio de los alumnos
SELECT a.nombre, a.apellido, c.carrera, EXTRACT(YEAR FROM now()) - EXTRACT(YEAR FROM a.fecha_incorporacion) AS nivel
FROM platzi.alumnos AS a
JOIN platzi.carreras AS c
    ON a.carrera_id = c.id;