SELECT * 
FROM tabla_diaria 
WHERE id = 1;


SELECT * 
FROM tabla_diaria 
WHERE cantidad > 10;


SELECT * 
FROM tabla_diaria 
WHERE cantidad < 100;


SELECT * 
FROM tabla_diaria 
WHERE cantidad > 10
    AND cantidad < 100;


SELECT * 
FROM tabla_diaria 
WHERE cantidad BETWEEN 10
    AND 100;


SELECT *
FROM users
WHERE name = 'Israel'
    AND (
        lastname = 'Vázquez'
        OR
        lastname = 'López'
    );


SELECT *
FROM users
WHERE name = 'Israel'
    AND lastname = 'Vázquez'
    OR lastname = 'López';


SELECT *
FROM users
WHERE name LIKE 'Is%'; -- % es un comodín que puede ser reemplazado por cualquier cantidad de caracteres


SELECT *
FROM users
WHERE name LIKE 'Is_ael'; -- el _ es un comodín que puede ser ser reemplazado por cualquier carácter


SELECT *
FROM users
WHERE name NOT LIKE 'Is_ael'; -- el _ es un comodín que puede ser ser reemplazado por cualquier carácter


SELECT *
FROM users
WHERE name IS NULL;


SELECT *
FROM users
WHERE name IS NOT NULL;


SELECT *
FROM users
WHERE name IN ('Israel', 'Juan', 'Pedro');