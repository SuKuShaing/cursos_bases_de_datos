-- Group By

SELECT *
FROM tabla_diaria
GROUP BY marca;

SELECT *
FROM tabla_diaria
GROUP BY marca, modelo;

-- GROUP BY Suele usarse frecuentemente con las funciones 
-- COUNT, MAX, MIN, MAX, SUM y AVG a un grupo de una o más columnas.



-- Limit
SELECT *
FROM tabla_diaria
LIMIT 1500;


SELECT *
FROM tabla_diaria
OFFSET 1500 -- Salta los primeros 1500 registros
LIMIT 1500; -- Muestra los siguientes 1500 registros