-- ENTRAR A LA CONSOLA DE POSTGRES
psql -U postgres -W

-- VER LOS COMANDOS \ DE POSTGRES
\? -- Equivalente a HELP;

-- LISTAR TODAS LAS BASES DE DATOS
\l -- Equivalente a SHOW DATABASES;

-- VER LAS TABLAS DE UNA BASE DE DATOS
\dt -- Equivalente a SHOW TABLES;

-- CAMBIAR A OTRA BD
\c nombre_BD -- Equivalente a USE nombre_BD;

-- DESCRIBIR UNA TABLA
\d nombre_tabla -- Equivalente a DESCRIBE nombre_tabla o DESC nombre_tabla;

-- VER TODOS LOS COMANDOS SQL
\h

-- VER COMO SE EJECTUA UN COMANDO SQL
\h nombre_de_la_funcion

-- CANCELAR TODO LO QUE HAY EN PANTALLA
Ctrl + C

-- VER LA VERSION DE POSTGRES INSTALADA, IMPORTANTE PONER EL ';'
SELECT version();

-- VOLVER A EJECUTAR LA FUNCION REALIADA ANTERIORMENTE ya sea por ti o por cualquier otro usuario conectado, se hace la última
\g

-- INICIALIZAR EL CONTADOR DE TIEMPO PARA QUE LA CONSOLA TE DIGA EN CADA EJECUCION ¿CUANTO DEMORO EN EJECUTAR ESA FUNCION?
\timing -- Equivalente a SET TIMING ON;

-- LIMPIAR PANTALLA DE LA CONSOLA PSQL
Ctrl + L

-- ver donde se encuentran los archivos de configuración de postgres
SHOW config_file;

-- Listar las funciones disponibles de la base de datos actual
\df

-- Listar las vistas de la base de datos actual
\dv

-- Listar los usuarios y sus roles de la base de datos actual
\du

-- Ver el historial de comandos ejecutados
\s

-- Si se quiere guardar la lista de comandos ejecutados en un archivo de texto plano
\s <nombre_archivo>

-- Ejecutar los comandos desde un archivo
\i <nombre_archivo> 

-- Permite abrir un editor de texto plano, escribir comandos y ejecutar en lote. \e abre el editor de texto, escribir allí todos los comandos, luego guardar los cambios y cerrar, al cerrar se ejecutarán todos los comandos guardados.
\e

-- Equivalente al comando anterior pero permite editar también funciones en PostgreSQL
\ef

-- Cerrar la consola
\q

-- Crear un usuario
CREATE ROLE usuario_consulta;
CREATE USER usuario_consulta; -- Este es el comando en SQL estándar;
\h CREATE ROLE; -- Para ver todos los permisos que se pueden asignar a un usuario; 

-- Para ver los roles de todos los usuarios
\dg -- Equivalente a SHOW GRANTS;

-- Le asignamos un atributo al usuario
ALTER ROLE usuario_consulta WITH LOGIN; -- Ahora puede loguearse en la base de datos;
ALTER ROLE usuario_consulta WITH SUPERUSER;
ALTER ROLE usuario_consulta WITH PASSWORD 'etc123';

-- Eliminar un usuario desde otra cuenta
DROP ROLE usuario_consulta;