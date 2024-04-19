SELECT * FROM clients;
-- Trae todos los registros de la tabla clients

SELECT name FROM clients;
-- Trae todos los registros de la columna name de la tabla clients

SELECT name, email, gender FROM clients;
-- Trae todos los registros de las columnas name, email y genero de la tabla clients

SELECT name, email, gender FROM clients LIMIT 10;
-- Trae los primeros 10 registros de las columnas name, email y genero de la tabla clients

SELECT name, email, gender FROM clients WHERE gender = 'M';
-- Trae los registros de las columnas name, email y genero de la tabla clients donde el genero sea 'M'

SELECT birthdate FROM clients; 
-- Trae los registros de la columna birthdate de la tabla clients

SELECT YEAR(birthdate) FROM clients; 
-- Trae todos los registros, pero solo el año de la columna birthdate de la tabla clients

SELECT NOW();
-- Trae la fecha y hora actual

SELECT YEAR(NOW());
-- Trae el año actual

SELECT name, YEAR(NOW()) - YEAR(birthdate) FROM clients LIMIT 10;
-- Trae los nombres y la edad de los primeros 10 registros de la tabla clients
-- La edad se calcula restando el año actual menos el año de nacimiento

SELECT * FROM clients WHERE name LIKE '%Saav%';
-- Trae todos los registros de la tabla clients donde el nombre contenga 'Saav'
-- LIKE es un operador que se usa para buscar patrones en una columna como % y _
-- El % es un comodín que indica que puede haber cualquier cantidad de caracteres antes o después de 'Saav'
-- El _ es un comodín que indica que puede haber un solo caracter antes o después de 'Saav_' (solo coincidiría con 'Saava' o Saave')

SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender FROM clients WHERE gender = 'F' AND name LIKE '%Lop%';
-- Trae los nombres, correos, edades y generos de los registros de la tabla clients donde el genero sea 'F' y el nombre contenga 'Lop' y el calculo de la edad lo trae con el nombre edad