-- Actualizamos cuando tenemos un dato equivocado, un typo, etc.
-- Actualizamos cuando la información cambia, cantidad de unidades, etc.
-- uPDATE Y DELETE siempre deben tener un WHERE para no afectar a toda la tabla

-- Trae datos al azar de la tabla, sirve para sacar una muestra aleatoria
SELECT * FROM authors 
ORDER BY rand()
LIMIT 10;

-- Cuenta las filas de la tabla authors
SELECT COUNT(*) FROM authors;

-- Diferente en mysql es <>, no usar !=
SELECT client_id, name, active FROM clients
WHERE active <> 1;

-- Trae 10 registros al azar de la tabla clients
SELECT client_id, name, active FROM clients 
ORDER BY rand()
LIMIT 10;

-- Trae los registros con id 80, 65, 76, 1, 61, 7, 19
SELECT client_id, name, active, email FROM clients 
WHERE client_id IN (80, 65, 76, 1, 61, 7, 19, 97);



-- Borra el registro con id 161, sí hay más de uno, solo se limita a borrar uno
DELETE FROM authors 
WHERE author_id = 161
LIMIT 1;

-- Borra el contenido de una tabla, pero queda la estructura
TRUNCATE nombre_tabla;



-- Formato del UPDATE
UPDATE tabla
SET 
    [columna = valor1, valor2, ...]
WHERE 
    [condición]
LIMIT 1;

-- Actualiza el campo active de 1 a 0
UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1;

-- Lo que haría es si es 7 o 9, actualiza el mail, el que encuentre primero
UPDATE clients
SET email = 'javier@gmail.com'
WHERE 
    client_id = 7
    OR client_id = 9;
-- lanza un error puesto que los mails son únicos


UPDATE clients
SET 
    active = 0
WHERE 
    client_id IN (1, 6, 8, 27, 90)
    OR name like '%Lopez%';


SELECT client_id, name, active FROM clients
WHERE
    client_id IN (1, 6, 8, 27, 90)
    OR name like '%Lopez%';
    -- eL or lista las condiciones que se cumplen