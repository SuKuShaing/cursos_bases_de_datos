SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a -- Tabla principal
JOIN books AS b -- Tabla secundaria
    -- En este caso hay un autor que no tiene libros, no sale dicho autor con un RIGHT JOIN, por lo que se usará LEFT JOIN
    -- ON b.author_id = a.author_id -- da igual el orden, pero es mejor ponerlo en el orden de la tabla principal
    ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id ASC;
-- sí no se especifica el tipo de orden, por defecto es ASC (ascendente)



SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a -- Tabla secundaria
LEFT JOIN books AS b -- Tabla principal
    -- En este caso hay un autor que no tiene libros, no sale dicho autor con un RIGHT JOIN, por lo que se usa LEFT JOIN
    ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id ASC;



SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS books
FROM authors AS a
LEFT JOIN books AS b -- sí se retira el left, no se mostrará el autor que no tiene libros
    ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id -- agrupar por autor
ORDER BY a.author_id;