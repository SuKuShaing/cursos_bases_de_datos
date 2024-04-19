USE metro_cdmx;

-- Seleccionar todo
SELECT * FROM `lines`; -- el más básico, selecciona todo

-- Filtrar por columnas
SELECT id, name, color FROM `lines`;

-- Operaciones matemáticas con SELECT
SELECT (2 + 2);
SELECT ("Hola Mundo");

SELECT (2 + 2) AS "resultado"; -- renombra lo que aparecerá arriba 

SELECT ROUND(AVG(year)) AS "año promedio" FROM `trains`;

-- Juntar tablas
SELECT
`lines`.`name`, 
`trains`.`serial_number`
FROM `lines`
INNER JOIN `trains`
ON `lines`.`id`= `trains`.`line_id`;