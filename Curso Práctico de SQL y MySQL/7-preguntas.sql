-- Preguntas del admin sobre el bussiness 

-- 1. ¿Qué nacionalidades hay?
SELECT DISTINCT nationality FROM authors ORDER by nationality;
-- -- te muestra la lista de nacionalidades sin repetir, y al final dice cuantas filas hay

SELECT COUNT(nationality) AS total
FROM authors
-- -- Este sumó en total cuantos autores hay


-- 2. ¿Cuántos autores hay por nacionalidad
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
-- WHERE nationality IS NOT NULL -- para que no tome en cuenta los null
WHERE nationality IS NOT NULL
    AND nationality IN ('RUS', 'AUS') -- y para que no tome en cuenta las nacionalidades que no queremos, si quito el NOT, solo me traerá esas dos nacionalidades
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;
-- -- Para ordenar va por orden de escritura, primero ordena por c_authors de forma descendente y luego por nacionalidad de forma ascendente
-- -- Esta es la mejor forma de escribir la consulta, con "author_id" puesto que si hay un autor que no tiene nacionalidad, no lo toma en cuenta; después colocamos el Where Is Not Null, para ejercitar

SELECT nationality, COUNT(nationality) AS total
FROM authors
GROUP BY nationality
ORDER BY nationality;
-- -- Este agrupó por nacionalidad y contó cuantos autores hay por nacionalidad, pero el null lo toma en 0, en cambio en el de arriba
-- -- el null lo muestra en 71, puesto que si, hay 71 autores que no tienen nacionalidad


-- 2.5. ¿Cuántos libros ha escrito cada autor?
SELECT a.author_id, a.name, COUNT(b.book_id) AS c_books
FROM authors AS a
LEFT JOIN books AS b -- sí se retira el left, no se mostrará el autor que no tiene libros
    ON a.author_id = b.author_id
GROUP BY a.author_id
ORDER BY c_books DESC, a.name ASC;

-- 2.6. libros que no tengan autor
SELECT b.book_id, b.title
FROM books AS b
LEFT JOIN authors AS a
    ON a.author_id = b.author_id
WHERE a.author_id IS NULL;

SELECT * FROM books 
WHERE book_id = 136;

-- 2.7 lista de autores gringos
SELECT name AS author
FROM authors
WHERE nationality = 'USA';


-- 3 ¿Cuál es el promedio / desviación estándar del precio de los libros?
SELECT price FROM books;

-- Para colocarle precio a los libros, puesto que estaban en null
UPDATE books
SET price = FLOOR(RAND()*(35-10+1))+10
WHERE book_id between 1 and 198 

-- Titulo y precio de los libros
SELECT title, price 
FROM books
ORDER by price DESC
LIMIT 10;

-- Promedio de los precios
SELECT AVG(price) AS avg_price FROM books;

-- Promedio y Desviación estándar
SELECT AVG(price) AS avg_price, STD(price) AS std_price FROM books;

-- promedio y desviación estándar por nacional
SELECT nationality, COUNT(a.name) AS autores, COUNT(b.book_id) AS libros, AVG(price) AS prom, STD(price) AS std 
FROM books as b -- lado derecho
LEFT JOIN authors as a -- lado izquierdo, al ser un inner join, solo tomará la intersección
    ON b.author_id = a.author_id
    -- Solo presenta un row porque hay que agruparlos por nacionalidad
GROUP BY nationality
ORDER BY libros DESC;

-- Libros de autores Australianos
SELECT b.title, a.nationality, a.name 
FROM books AS b
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE nationality = 'AUS';

-- Libros sin nacionalidad
SELECT b.title, a.nationality, a.name 
FROM books AS b
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE nationality IS NULL;


-- 6 ¿Cuál es el precio máximo y mínimo de los libros?
SELECT a.nationality, COUNT(b.book_id) AS libros, MAX(b.price) AS max_price, MIN(b.price) AS min_price 
FROM books AS b
JOIN authors AS a
    ON b.author_id = a.author_id
GROUP BY a.nationality
ORDER BY max_price DESC;


-- 7 ¿Quién transacciono libros?
SELECT c.name AS cliente, t.type, t.transaction_id, b.title,
    CONCAT(a.name, " (", a.nationality, ")") AS author, t.created_at AS fecha, 
    TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS ago
FROM transactions AS t
LEFT JOIN clients AS c
    ON t.client_id = c.client_id
LEFT JOIN books AS b
    ON t.book_id = b.book_id
LEFT JOIN authors AS a
    ON b.author_id = a.author_id;
-- CONCAT para unir dos columnas, en este caso, el nombre del autor y su nacionalidad
-- TO_DAYS para saber cuantos días han pasado desde el año 0 hasta la fecha colocada dentro,
-- da el número de días desde el año 0 hasta la fecha actual, y se le resta los días desde el año 0 hasta la fecha de la transacción, por ende, queda cuantos días han pasado desde la transacción hasta la fecha actual