-- Distinct se utiliza para eliminar duplicados
SELECT distinct nationality FROM authors;
-- -- Solo trae un registro de cada uno de los que existan

-- Actualiza la nacionalidad de los autores de 'ENG' a 'GBR'
UPDATE authors
SET nationality = 'GBR'
WHERE nationality = 'ENG';

-- Cuenta cuantas filas hay en la tabla books
SELECT count(*), sum(1) FROM books;
-- -- Se puede utilizar count(*) o count(book_id) para contar las filas, count(*) es más rápido, count(book_id) es más preciso 

-- Obtienes el monto total si vendes todos los libros
SELECT sum(price * copies) FROM books WHERE sellable = 1;

-- Obtienes el monto total si vendes todos los libros agrupados por si son vendibles o no
SELECT sellable, sum(price * copies) FROM books GROUP BY sellable;


-- if(condición, valor_si_es_verdadero, valor_si_es_falso)
-- Si el año es menor a 1950, suma 1, si no, suma 0
SELECT count(book_id), sum(if(year < 1950, 1, 0)) as `< 1950` FROM books;

-- Cuenta cuantos libros hay con año menor a 1950
SELECT count(book_id) FROM books WHERE year < 1950;

-- Cuenta los libros con año menor a 1950 y los que son mayores a 1950
SELECT count(book_id), 
    sum(if(year < 1950, 1, 0)) as `< 1950`,
    sum(if(year < 1950, 0, 1)) as `> 1950`
FROM books;

-- Cuenta los libros con año menor a 1950, entre 1950 y 1990, entre 1990 y 2000 y mayores a 2000
SELECT nationality, count(book_id), 
    sum(if(year < 1950, 1, 0)) as `< 1950`,
    sum(if(year >= 1950 and year < 1990, 1, 0)) as `< 1990`,
    sum(if(year >= 1990 and year < 2000, 1, 0)) as `< 2000`,
    sum(if(year > 2000, 1, 0)) as `> 2000`
FROM books AS b
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE
    a.nationality IS NOT null
GROUP BY nationality;
