Comandos SQL

--:::::::::::::::::::::::::::::::::::::::::::::
--:::::::::::::::: Crear bd o db ::::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
CREATE SCHEMA `platzi_test` ; -- para crear db
CREATE DATABASE test_db; -- para crear db
USE DATABASE test_db; -- en un ambiente gráfico indica que quiero usar esta db por defecto

-- con las opciones del botón secundario, es recomendable establecer una base de datos por defecto, así todos los comandos que se envíen se enviaran a esa base de datos
-- no puede haber espacio despues donde debería haber un enter



--:::::::::::::::::::::::::::::::::::::::::::::
--:::::::::::::::: Crea una tabla :::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
CREATE TABLE `platzi_test`.`people` ( --crea la tabla con las siguientes columnas
  `people_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(255) NULL,
  `first_name` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `city` VARCHAR(255) NULL,
  PRIMARY KEY (`people_id`), --su pk
  UNIQUE INDEX `people_id_UNIQUE` (`people_id` ASC) VISIBLE);--Esta última linea es solo si hay un unique seleccionado

--Establece una Foreign Key (FK)
ALTER TABLE `platzi_blog`.`posts` --altera la tabla
ADD INDEX `posts_usuarios_idx` (`usuario_id` ASC) VISIBLE; --agrega un indice
;
ALTER TABLE `platzi_blog`.`posts` --altera la tabla
ADD CONSTRAINT `posts_usuarios` --añade una restricción
  FOREIGN KEY (`usuario_id`) --esa columna contendrá una PK
  REFERENCES `platzi_blog`.`usuarios` (`id`) --Referenciando a esa columna de esa tabla
  ON DELETE NO ACTION -- lo que pasaría sí se borra el id en la otra tabla, nada (no action)
  ON UPDATE CASCADE; -- lo que pasaría al actualizar el id en la tabla original (se actualiza aquí)




--:::::::::::::::::::::::::::::::::::::::::::::
--:::::::::::::::: Insertar :::::::::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
--Insertar valores en la tabla, indicar en que columna, luego los valores
INSERT INTO `platziblog`.`people` (`person_id`, `last_name`, `first_name`, `address`, `city`) --insertar en  
VALUES ('1', 'Vásquez', 'Israel', 'Calle Famosa Num 1', 'México'), -- coloca los siguientes datos
	      ('2', 'Hernández', 'Mónica', 'Reforma 222', 'México'),
	      ('3', 'Alanis', 'Edgar', 'Central 1', 'Monterrey');

INSERT INTO people (last_name, first_name, address, city) --vamos a insertar una valor en la tabla people y las columnas que están entre parentesis 
  VALUES ('Hernández', 'Laura', 'Calle 21', 'Monterrey'); --estos son los valores




--:::::::::::::::::::::::::::::::::::::::::::::
--::::::::::: Borra la taba o la bd :::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
DROP TABLE `platziblog`.`people`; --Borra la tabla
DROP DATABASE `platziblog`; --Borra la base de datos
DELETE FROM platzi_test.people --borra y se le indica la base de datos.tabla 
WHERE people_id= 1; -- qué fila o arrow borre

-- ojo: Hay que usar comillas francesa en las instrucciones, por lo menos en la interfaz de Workbench



--:::::::::::::::::::::::::::::::::::::::::::::
--::::::::::::: Actualizar datos ::::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
UPDATE people --Actualiza los datos de la tabla people
SET last_name = 'Chavez', city= 'Merida' --Estos son los datos a cambiar en tales columnas
WHERE people_id = 1; -- y se le cambia a esta persona




--:::::::::::::::::::::::::::::::::::::::::::::
--::::::::::::::::::: Vistas ::::::::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
--(para ver xd)
SELECT * FROM platzi_test.people; --selecciona y muestra toda la tabla people de la base de datos platzi_test
--*resultado*: muestra la tabla
SELECT first_name, last_name FROM people; --selecciona y visualiza las columnas first_name, last_name y muestra una tabla, esto se extrae de la tabla grande people
--*resultado*: muestra una tabla con las dos columnas y lo que hay en ellas 

SELECT * FROM posts
WHERE YEAR(fecha_publicacion) > '2024'; --Filtra por el año de publicación, el filtrado lo realiza desde un TIMESTAMP()

SELECT estacion FROM cdmx_metro
WHERE inaugurada >= '2000-01-01'; --Filtra por una fecha concreta

SELECT titulo, fecha_publicacion, estatus --selecciona las columnas a traer
FROM posts; --de qué tabla

SELECT titulo AS encabezado, fecha_publicacion AS Publicado_en, estatus AS Estado --Les cambia el nombre en la tabla a mostrar, en vez de salir titulo, se muestra Encabezado y así con el resto, solo para la visualización, en la bd se sigue llamando titulo la columna
FROM posts; -- de la tabla

SELECT sum(id) as total_suma_id --suma todos los valores de la lista
FROM posts;

SELECT avg(id) as promedio_monto_id --devuelve el promedio de los valores numéricos de la lista
FROM posts;

SELECT max(id) as valor_maximo --devuelve el valor máximo de la lista
FROM posts;

SELECT min(id) as valor_minimo --devuelve el valor mínimo de la lista
FROM posts;

SELECT COUNT(*) --cuenta cuantos arrows hay en la tabla
FROM posts;

SELECT COUNT(*) AS numero_posts --Le cambiamos el nombre a la cuenta para que sea más agradable 
FROM posts;

select estatus, count(*) post_quantity --cuenta los que son iguales en estatus, los agrupo y le pone nombre a la columna post_quantity
from posts
group by estatus; --debe ir esta columna, hasta ahora debe ser igual a la de select, es decir, estatus
--Respuesta: dos columnas agrupadas por estatus y post_quantity y te dice la cantidad de activos y de inactivos

select year(fecha_publicacion) as post_year, count(*) post_quantity
from posts
group by post_year; --agrupa los post por año, de la columna fecha_publicacion, referida con el alias, y los cuenta en la columna de al lado con post_quantity

select monthname(fecha_publicacion) as post_month, count(*) post_quantity
from posts
group by post_month;--agrupa los post por mes y cuenta cuantos se publicaron por mes

select estatus, monthname(fecha_publicacion) as post_month, count(*) post_quantity
from posts
group by estatus, post_month;--agrupa en 3 categorias, estatus, post_month y post_quantity

select * from posts
where id <= 50; --trae todos los id menores o iguales a 50

select * from posts
where estatus='activo'; --trae todos los que tengan status activo

select * from posts
where estatus != 'activo'; --trae todos los que no sean activo, en un caso binario, el otro

select * from posts
where id != 50; --trae todos los id menos el 50
where id <> 50; --exactamente lo mismo que el de arriba, <> es otra manera de expresar "distinto de" o "diferente de"

select * from posts
where titulo like '%escandalo%'; --trae todos los artículos que contengan la palabra escándalo en cualquier parte de su texto
where titulo like 'escandalo%'; --trae todos los artículos que contengan la palabra escándalo al inicio. Sí se le quita el % del final y no el del principio, solo traerá, los que terminen con esa palabra; " %termina_en ", " %en medio% ", " inicia_con% "

select * from posts
where fecha_publicacion > '2025-01-01'; --trae todas las fechas posteriores a la indicada
where fecha_publicacion between '2023-01-01' and '2025-12-31';-- trae todos las fechas entremedio de las indicadas, between, funciona con 2 indicaciones y el and, between considera el rango completo (ambos incluidos)
where id between 50 and 60;--otro ejemplo de lo anterior
where year(fecha_publicacion) between '2023' and '2024';--trae las publicaciones entre esos años, ambos incluidos
where month(fecha_publicacion) = '04';--trae todo los post que se publicaron en ese mes, independiente del año 

select * from posts
where usuario_id is null; --regresa los post con usuario_id nulo
where usuario_id is not null; --regresa los NO nulos

select * from posts
where usuario_id is not null
and estatus = 'activo' --AND une condicionales
and id < 50 --se puede usar varios
and categories_id = 2 --se puede usar varios más
and year(fecha_publicacion) = '2025';--y más

select * from posts
order by fecha_publicacion desc; --Ordena en forma descendiente (de mayor a menor) la columna fecha_publicación 
order by fecha_publicacion asc; --Ordena en forma ascendiente (de mayor a menor) la columna fecha_publicación 

select * from posts
order by fecha_publicacion asc
limit 5; -- sirve para limitar, limita a los primeros 5 resultados

select monthname(fecha_publicacion) as post_month, estatus, count(*) as post_quantity
from posts
--where post_quantity > 1 --where no nos sirve en este caso puesto que hace el filtrado de la columna post_quantity, pero esa columna solo existe después de que se agrupen en las siguientes lineas; no se puede seleccionar datos agrupados con el comando where
group by estatus, post_month
having post_quantity > 1 -- having va despues de group by, hace el filtrado en grupos que where no puede hacer, funciona muy similar a where
order by post_month;


--Query anidados
select new_table_projection.date, count(*) as posts_count
from ( --lo que está dentro del parentesis es un query anidado, extrae la información de la tabla "post", ese extracto de información se le pasará a la tabla externa
	--entrega la fecha del primer post de cada año
  select date(min(fecha_publicacion)) as date, year(fecha_publicacion) as post_year
	from posts
	group by post_year
	order by post_year
) as new_table_projection
group by new_table_projection.date
order by new_table_projection.date;
--el query global entrega la cantidad de post por la primera fecha que le fue entregada en el anidado

select * from posts
where fecha_publicacion = ( --el siguiente query solo entrega una tabla con una fecha y una columna que tiene el máximo valor de fecha
	select max(fecha_publicacion)
    from posts
);
-- el query global de la pregunta, devuelve el post que sea igual a la fecha del select



--:::::::::::::::::::::::::::::::::::::::::::::
--::::::::::::::::::: Joins :::::::::::::::::::
--:::::::::::::::::::::::::::::::::::::::::::::
--Trae todo el lado A completo, incluyendo el trozo entremedio de la unión A u B
SELECT *
FROM usuarios
	LEFT JOIN posts ON usuarios.id = posts.usuario_id; --une usuarios (izquierda [porque va primero]) con posts (derecha) mediante el vinculo tabla.columna, usuarios.id con posts.usuario_id
  --Resultado: trae todas las columnas de la tabla usuario y las conecta con posts, colocándole todos los post que c/u escribió; incluyendo a los usuario que no han posteado

--Trae solo el lado A qué no está en la unión A u B
SELECT *
FROM usuarios
	LEFT JOIN posts ON usuarios.id = posts.usuario_id
    WHERE posts.usuario_id IS null; --Al ver la tabla anterior nos damos cuenta que la columna usuario_id de la tabla posts, solo es nulo sí el unario no ha escrito ningún post y ese es el que seleccionamos
    --Resultado: solo traen al usuario que no ha escrito post

--Trae todo el lado B completo, incluyendo el trozo entremedio de la unión A u B
select * from usuarios
	right join posts on usuarios.id = posts.usuario_id; 
  --Resultado: al hacerlo así con right, parte viendo todos los posts, los empareja con los usuarios y no trae usuarios sin post

select * from usuarios
	right join posts on usuarios.id = posts.usuario_id
    where posts.usuario_id = 3;
    --Resultado solo trae los usuario de la usuario_id = 3, partiendo la revisión desde la derecha, que es posts

--Trae solo lo que está entremedio de la unión A u B
select * from usuarios
	inner join posts on usuarios.id = posts.usuario_id;
  --Resultado inner: solo trae los datos de entremedio, usuarios que hayan escrito post y post que tengan usuarios

--Trae todo de ambos círculos de la unión A u B (full outer) 
select * from usuarios
	full outer join posts on usuarios.id = posts.usuario_id
  --Resultado: "full outer" NO ES VALIDO EN MySQL, pero trae todo de ambos lados
--Equivalente en MySQL es
select * from usuarios
	left join posts on usuarios.id = posts.usuario_id
union --une la petición de arriba con la de abajo
select * from usuarios
	right join posts on usuarios.id = posts.usuario_id;
  --Resultado: al escribir todo esta sintaxis trae todo el universo de A u B

--trae todo lo que no está en la unión de A u B
select * from usuarios
	left join posts on usuarios.id = posts.usuario_id
    where posts.usuario_id is null --solo trae los usuario sin post
union
select * from usuarios
	right join posts on usuarios.id = posts.usuario_id
  where posts.usuario_id is null; --solo trae los posts sin usuarios
  --Resultado global: solo trae al usuarios sin post y al post sin usuarios


--Caso practico 1
select posts.titulo as titulo_post, count(*) as num_etiquetas --crea las dos columnas a mostrar, dado que son dos hay que ocupar group by
from posts
	inner join posts_etiquetas on posts.id = posts_etiquetas.post_id --lo intersecta con la tabla intermedia posts_etiquetas
  inner join etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id --la intersección la intersecta con la tabla final etiquetas
group by posts.id --por el parametro que ordenaremos, puede tambien ser posts.titulo
order by num_etiquetas desc;
--Resultado: muestra cuantas etiquetas tiene cada post

--Caso practico 1.1
select posts.titulo as titulo_post, count(*) as num_etiquetas, group_concat(" ", etiquetas.nombre_etiqueta) as nombre_etiquetas --group_concat concatena el nombre de las etiquetas que están en cada post
--group_concat(DISTINCT etiquetas.nombre_etiqueta ORDER BY etiquetas.nombre SEPARATOR " - ") -- usar Distinct evita los duplicados, Separator ", " para separar por , + espacio 
from posts
	inner join posts_etiquetas on posts.id = posts_etiquetas.post_id
    inner join etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
group by posts.titulo
order by num_etiquetas desc;
--Resultado: muestra 3 columnas, el nombre del post, cuantas etiquetas tiene cada post, y cuales etiquetas son concatenadas

--caso practico 2
select * from etiquetas
	left join posts_etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
--Respuesta: trae toda la tabla etiquetas y la une con posts_etiquetas
where posts_etiquetas.etiqueta_id is null --al agregar esta linea se filtra
--Respuesta: solo trae la etiqueta que no tiene post asociado

--caso practico 3
select c.nombre_categoria, count(*) as cant_posts
from categories as c --a la tabla categories se le puso el apodo "c" para no escribir tanto
	inner join posts as p on c.id = p.categories_id --a la tabla posts se le puso el apodo "p" para no escribir tanto
group by c.id --se agrupa por el nombre o el id
order by cant_posts desc
--Resultado: devueve una tabla con los nombre de las categorias y cuantos post tiene c/u

--caso practico 4
select u.nickname, count(*) as cant_posts, group_concat(p.titulo separator " - ")
from usuarios as u --a la tabla usuarios se le puso el apodo "u" para no escribir tanto
	inner join posts as p on u.id = p.usuario_id
group by u.id
order by cant_posts desc
--Resultado: cuantos post tiene cada usuario y cuales son

--caso practico 4.2
select u.nickname, count(*) as cant_posts, group_concat(nombre_categoria separator ", ")
from usuarios as u
	inner join posts as p on u.id = p.usuario_id
  inner join categories as c on c.id = p.categories_id
group by u.id
order by cant_posts desc
--Resultado: cuantos post tiene cada usuario, cuales son y en qué categorias está escribiendo

--caso practico 5
select * from usuarios as u
	left join posts on u.id = posts.usuario_id
where usuario_id is null
--Resultado: devuelve todos los usuarios que no han creado un post