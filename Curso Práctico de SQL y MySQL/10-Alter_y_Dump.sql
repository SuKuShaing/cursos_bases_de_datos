-- Agrega una columna más a la tabla, año de nacimiento, después de la columna name y con el default de 1930
ALTER TABLE authors ADD COLUMN birthyear INT DEFAULT 1930 AFTER name;

-- Cambia el tipo de dato de la columna birthyear a year y el año default a 1920
ALTER TABLE authors MODIFY COLUMN birthyear year DEFAULT 1920;

-- Elimina la columna birthyear
ALTER TABLE authors DROP COLUMN birthyear;


--
-- DUMP
--

-- La estructura de la base de datos se puede versionar con git
-- Los datos se respaldan, no se versionan

-- Exportar la base de datos libreriaplatzi con todos sus datos
$ mysqldump -u root -p libreriaplatzi 
-- -- Arroja toda la base de datos en la terminal, con sus comandos para crearla y sus datos

-- Exportar la base de datos libreriaplatzi sin los datos, solo la estructura
$ mysqldump -u root -p -d libreriaplatzi

-- Entrega el resultado paginado
$ mysqldump -u root -p -d libreriaplatzi | more

-- Exportar la base de datos libreriaplatzi sin los datos, solo la estructura, a un archivo
$ mysqldump -u root -p -d libreriaplatzi > libreriaplatzi.sql