-- Crear la base de datos

CREATE DATABASE metro_cdmx;

SHOW DATABASES; --muestra las bases de datos

DROP DATABASE metro_cdmx; --elimina la bd


USE nombre_de_la_base_de_datos; --Para decirle a que bd voy a pedirle información
SHOW TABLES; --para ver todas las tablas

-- Si entré a una base de datos y no recuerdo el nombre o en cual estoy
SELECT DATABASE(); --para saber en que base de datos estoy


DESCRIBE nombre_de_la_tabla; -- para ver las características o propiedades de las columnas de nuestra base de datos
DESC nombre_de_la_tabla; -- para ver las columnas y sus tipos de datos (es la abreviación de la anterior)
SHOW FULL COLUMNS FROM books; --para ver todo de la tabla, como el describe más comentarios y privilegios

SELECT id From `stations` WHERE name = "Merced";
-- Las tablas siempre con comilla francesa, los nombres con comilla normal