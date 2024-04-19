SELECT count(*) FROM books;
-- Trae el número de registros de la tabla books

SELECT * FROM authors WHERE author_id > 0 AND author_id <= 5;
-- Trae todos los registros de la tabla authors donde el author_id sea mayor a 0 y menor o igual a 5 (del 1 al 5)

SELECT * FROM books WHERE author_id BETWEEN 1 AND 5;
-- Trae todos los registros de la tabla books donde el author_id este entre 1 y 5

SELECT book_id, author_id, title 
FROM books 
WHERE author_id BETWEEN 1 AND 5;
-- Trae los registros de las columnas book_id, author_id y title de la tabla books donde el author_id este entre 1 y 5
+---------+-----------+---------------------------------------+
| book_id | author_id | title                                 |
+---------+-----------+---------------------------------------+
|       1 |         1 | The Startup Playbook                  |
|       2 |         1 | The Startup Playbook                  |
|       3 |         3 | Estudio en escarlata                  |
|      12 |         5 | El llano en llamas                    |
|      41 |         3 | The - Vol I Complete Sherlock Holmes  |
|      42 |         3 | The - Vol II Complete Sherlock Holmes |
+---------+-----------+---------------------------------------+


-- *****************************************************************
-- *************************** Join ********************************
-- *****************************************************************

-- Iner Join o Join es lo mismo
-- por defecto es Inner Join es join, es decir, si no se especifica nada es un Inner Join


SELECT b.book_id, a.name, b.title,
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;
-- Trae los registros de las columnas book_id, name y title de las tablas books y authors donde el author_id este entre 1 y 5
-- JOIN es una clausula que se usa para combinar filas de dos o más tablas basándose en una columna relacionada entre ellas
-- La tabla authors se une a la tabla books por la columna author_id reemplazando el autor id por el nombre del autor
-- a traves de ON a.author_id = b.author_id trae a.name
+---------+--------------------+---------------------------------------+
| book_id | name               | title                                 |
+---------+--------------------+---------------------------------------+
|       1 | Sam Altman         | The Startup Playbook                  |
|       2 | Sam Altman         | The Startup Playbook                  |
|       3 | Arthur Conan Doyle | Estudio en escarlata                  |
|      12 | Juan Rulfo         | El llano en llamas                    |
|      41 | Arthur Conan Doyle | The - Vol I Complete Sherlock Holmes  |
|      42 | Arthur Conan Doyle | The - Vol II Complete Sherlock Holmes |
+---------+--------------------+---------------------------------------+


SELECT b.book_id, a.name, a.author_id, b.title
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;
+---------+--------------------+-----------+---------------------------------------+
| book_id | name               | author_id | title                                 |
+---------+--------------------+-----------+---------------------------------------+
|       1 | Sam Altman         |         1 | The Startup Playbook                  |
|       2 | Sam Altman         |         1 | The Startup Playbook                  |
|       3 | Arthur Conan Doyle |         3 | Estudio en escarlata                  |
|      12 | Juan Rulfo         |         5 | El llano en llamas                    |
|      41 | Arthur Conan Doyle |         3 | The - Vol I Complete Sherlock Holmes  |
|      42 | Arthur Conan Doyle |         3 | The - Vol II Complete Sherlock Holmes |
+---------+--------------------+-----------+---------------------------------------+

SELECT name FROM authors WHERE author_id = 4;
-- Trae el nombre del autor con el author_id 4, es Chuck Palahniuk

SELECT title, copies FROM books WHERE copies <= 4;
-- Trae los titulos y las copias de los libros donde las copias sean menores o iguales a 4

select * from transactions;
-- Trae todos los registros de la tabla transactions
+----------------+---------+-----------+------+---------------------+---------------------+----------+
| transaction_id | book_id | client_id | type | created_at          | modified_at         | finished |
+----------------+---------+-----------+------+---------------------+---------------------+----------+
|              1 |      12 |        34 | sell | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
|              2 |      54 |        87 | lend | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        0 |
|              3 |       3 |        14 | sell | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
|              4 |       1 |        54 | sell | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
|              5 |      12 |        81 | lend | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
|              6 |      12 |        81 | sell | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
|              7 |      87 |        29 | sell | 2024-03-22 12:44:38 | 2024-03-22 12:44:38 |        1 |
+----------------+---------+-----------+------+---------------------+---------------------+----------+


SELECT c.name, b.title, t.type
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id;
+-----------------------+--------------------------------------+------+
| name                  | title                                | type |
+-----------------------+--------------------------------------+------+
| Maria Teresa Castillo | El llano en llamas                   | sell |
| Luis Saez             | Tales of Mystery and Imagination     | lend |
| Jose Maria Bermudez   | Estudio en escarlata                 | sell |
| Rafael Galvez         | The Startup Playbook                 | sell |
| Antonia Giron         | El llano en llamas                   | lend |
| Antonia Giron         | El llano en llamas                   | sell |
| Juana Maria Lopez     | Vol 39 No. 1 Social Choice & Welfare | sell |
+-----------------------+--------------------------------------+------+


SELECT c.name, b.title, t.type
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id
WHERE c.gender = 'F'
    AND t.type = 'sell';
+-----------------------+--------------------------------------+------+
| name                  | title                                | type |
+-----------------------+--------------------------------------+------+
| Maria Teresa Castillo | El llano en llamas                   | sell |
| Antonia Giron         | El llano en llamas                   | sell |
| Juana Maria Lopez     | Vol 39 No. 1 Social Choice & Welfare | sell |
+-----------------------+--------------------------------------+------+


SELECT c.name, b.title, a.name AS autor, t.type
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE c.gender = 'F'
    AND t.type = 'sell';
+-----------------------+--------------------------------------+------------+------+
| name                  | title                                | autor      | type |
+-----------------------+--------------------------------------+------------+------+
| Maria Teresa Castillo | El llano en llamas                   | Juan Rulfo | sell |
| Antonia Giron         | El llano en llamas                   | Juan Rulfo | sell |
| Juana Maria Lopez     | Vol 39 No. 1 Social Choice & Welfare | Various    | sell |
+-----------------------+--------------------------------------+------------+------+


SELECT c.name, b.title, a.name AS autor, t.type
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE c.gender = 'M'
    AND t.type IN ('sell', 'lend');
+---------------------+----------------------------------+--------------------+------+
| name                | title                            | autor              | type |
+---------------------+----------------------------------+--------------------+------+
| Luis Saez           | Tales of Mystery and Imagination | Edgar Allen Poe    | lend |
| Jose Maria Bermudez | Estudio en escarlata             | Arthur Conan Doyle | sell |
| Rafael Galvez       | The Startup Playbook             | Sam Altman         | sell |
+---------------------+----------------------------------+--------------------+------+


-- Query para traer el nombre del autor y el titulo del libro
-- Query de búsqueda por defecto es un Inner Join o Join
select b.title, a.name
from authors as a, books as b
where a.author_id = b.author_id
limit 10;

-- Query para traer el nombre del autor y el titulo del libro
-- Query igual al anterior pero con Join
SELECT b.title, a.name
FROM books AS b
JOIN authors AS a
    ON a.author_id = b.author_id
LIMIT 10;