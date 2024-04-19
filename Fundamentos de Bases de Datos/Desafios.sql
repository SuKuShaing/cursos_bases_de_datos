-- Petición 1
CREATE VIEW v_madrid_customers AS
SELECT person_id, last_name, first_name
FROM people
WHERE city= "Madrid";

CREATE VIEW vista_personas AS
SELECT person_id
FROM people;

-- Petición 2
SELECT * FROM v_madrid_customers;

-- Petición 3
ALTER TABLE people
ADD COLUMN date_of_birth DATE;

-- Petición 4
ALTER TABLE people
DROP COLUMN address;

--⬆ aprendí que no van comas al final de la sentencia



-- 2° Desafió
-- Petición 1
SELECT * FROM students;

-- Petición 2
INSERT INTO students(nombre, apellido, edad, correo_electronico, telefono)
VALUES ("Alexis", "Araujo", "33", "alexis@gmail.com", "777-1234");

SELECT * FROM students;

-- Petición 3
DELETE FROM students
WHERE id= 1;

-- Petición 4
UPDATE students
SET edad = 55
WHERE id = 2;

SELECT * FROM students;
--⬆ aprendí que hay que colocar el punto y coma al final de cada instrucción individual



-- 3° Desafió
SELECT * FROM cursos;
SELECT COUNT(*) AS cantidad FROM cursos;
SELECT nombre AS name, profe AS teacher, n_calificaciones AS n_reviews FROM cursos;



-- 4° Desafió
SELECT courses.id, courses.name, courses.teacher_id, teachers.name AS teacher_name FROM courses
  INNER JOIN teachers ON courses.teacher_id = teachers.id;
--⬆ hay que fijarse bien con que columna estamos vinculando



-- 5° Desafió
SELECT *
FROM COURSES
WHERE n_reviews > 0;

SELECT *
FROM COURSES
WHERE n_reviews between 1 and 100;

SELECT *
FROM COURSES
WHERE name like '%SQL%';



-- 6° Desafió
--SELECT * FROM courses;
--SELECT * FROM teachers;
select teachers.name as teacher, sum(courses.n_reviews) as total_reviews
FROM teachers
  inner join courses on teachers.id = courses.teacher_id
  group by teacher
  order by total_reviews desc;
-- ⬆ se puede sumar desde otra tabla y al colocar un join "la otra tabla" se vinculan
-- con group by, se colocan todos los items distinto de esa columna ya c/u será un grupo
-- y se ordena por la columna que se le pida
-- si son columnas de distinta fuente, se debe colocar la tabla.columna



-- 7° Desafió
--SELECT * FROM usuarios
--limit 2;
--SELECT * FROM categorias
--limit 2;
--SELECT * FROM etiquetas
--limit 2;
--SELECT * FROM posts
--limit 2;
--SELECT * FROM posts_etiquetas
--limit 2;
--Si las anteriores lineas no se comentaban, no pasaba

--Crea una tabla
CREATE TABLE `comentarios` ( --crea la tabla con las siguientes columnas
  `id` INT NOT NULL,
  `cuerpo_comentario` VARCHAR(255) NOT NULL,
  `usuario_id` INT NULL,
  `post_id` INT NULL,
  PRIMARY KEY (`id`));

--Insertar valores en la tabla
INSERT INTO `comentarios` (`id`, `cuerpo_comentario`, `usuario_id`, `post_id`)
VALUES (1, "Vasquez se la come", 1, 43), 
      (2, "lorean el isum", 1, 43),
      (3, "comentario 3", 3, 50);
-- ⬆ los número sin comillas
-- ⬆ los textos a ingresar con comillas normales

--mostrar tabla
SELECT * FROM comentarios;

--Hacer la unión
select c.cuerpo_comentario as comentario, u.login as usuario, p.titulo as post
from comentarios as c
	inner join usuarios as u on c.usuario_id = u.id
	inner join posts as p on c.post_id = p.id
where u.id = 1