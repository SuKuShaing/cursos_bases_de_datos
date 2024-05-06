
-- nombre, apellido, carrera y año de estudio de los alumnos
SELECT a.nombre, a.apellido, c.carrera, EXTRACT(YEAR FROM now()) - EXTRACT(YEAR FROM a.fecha_incorporacion) AS nivel
FROM platzi.alumnos AS a
JOIN platzi.carreras AS c
    ON a.carrera_id = c.id;

-- Para ver si hay alumnos que esten registrados y que no tengan carrera
SELECT a.nombre, a.apellido, c.carrera, EXTRACT(YEAR FROM now()) - EXTRACT(YEAR FROM a.fecha_incorporacion) AS nivel
FROM platzi.alumnos AS a
LEFT JOIN platzi.carreras AS c
 ON a.carrera_id = c.id
 WHERE a.carrera_id is null;
-- no hay alumnos que no tengan carrera