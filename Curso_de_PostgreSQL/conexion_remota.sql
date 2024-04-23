-- Como conectarse a una base de datos remota en PostgreSQL
-- En este caso recrearemos una conexción remota



-- CREATE EXTENSION dblink; -- con este comando habilitamos la extensión dblink en postgresql

-- Simplemente hay que llenar los campos con los datos de la base de datos remota
SELECT * FROM -- en caso de que no se haya habilitado la extensión dblink usar el comando de arriba
dblink ('dbname=remota 
		port=5432 
		host=127.0.0.1 
		user=usuario_consulta
		password=etc123',
        'SELECT id, fecha FROM vip') -- Depues de llenados los campos se hace la consulta a la base de datos remota
        AS datos_remotos (id integer, fecha date); -- Hay que especificar el alias y el tipo de datos que se va a recibir

-- El usuario que está haciendo la consulta debe tener permisos el la tabla remota para hacer las consultas, es decir, el usuario que le pasemos debe existir allá


-- para cruzar datos de una tabla local y una remota simplemente se hace un JOIN
SELECT * FROM pasajero
JOIN
dblink ('dbname=remota 
		port=5432 
		host=127.0.0.1 
		user=usuario_consulta
		password=etc123',
	   'SELECT id, fecha FROM vip')
	   AS datos_remotos (id integer, fecha date)
USING (id) -- USING (id) es lo mismo que escribir ON (pasajero.id = datos_remotos.id);, funciona igual



-- reto, crear la conexión pero de una tabla remota a una local

-- CREATE EXTENSION dblink; -- la extensión también se debe habilitar en la otra base de datos

SELECT * FROM vip
JOIN
dblink ('dbname=transporte 
		port=5432 
		host=127.0.0.1 
		user=usuario_consulta
		password=etc123',
	   'SELECT id, nombre, direccion_residencia, fecha_nacimiento FROM pasajero')
	   AS datos_remotos (id integer, nombre  character varying, direccion_residencia character varying, fecha_nacimiento date)
USING (id);
-- ON (pasajero.id = datos_remotos.id);
