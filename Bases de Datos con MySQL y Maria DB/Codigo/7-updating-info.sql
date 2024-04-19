USE metro_cdmx;

--Actualizar información en algunas columnas de las tablas
UPDATE `stations`
SET name = "Lázaro Cárdenas"
WHERE id = 1; -- EXTREMADAMENTE IMPORTANTE COLOCAR WHERE, puesto que sino se va a cambiar el nombre a todos las filas por Lázaro Cárdenas, con where, solo a la que corresponde


UPDATE `stations`
SET name = "Ferrería"
WHERE id = 2;

UPDATE `stations`
SET name = "Pantitlán"
WHERE id = 3;

UPDATE `stations`
SET name = "Tacuba"
WHERE id = 4;

UPDATE `stations`
SET name = "Martín Carrera"
WHERE id = 5;