-- Crear usuarios para que usen la db

CREATE USER 'nombredelusuario'@'localhost' IDENTIFIED BY 'qwe';
-- comandos, nombre del usuario; donde se va a ocupar el usuario y su contraseña

user: Sebastian
pass: qwe

DROP USER 'nombredelusuario'@'localhost';
-- comandos, nombre del usuario; desde donde se va a eliminar

--Accesos del usuario
-- Más info aquí https://mariadb.com/kb/en/grant/#grant-option
GRANT ALL PRIVILEGES ON *.* TO 'nombredelusuario'@'localhost';
-- Comando, tipos de privilegios, en donde, a quién

FLUSH PRIVILEGES;
--Para activar los privilegios otorgados

--Para ver los usuarios
SELECT User, Host FROM mysql.user;
SELECT User FROM mysql.user;

--Para ver los privilegios de todos los usuarios
SHOW GRANTS;

--Para ver los privilegios de un usuario
SHOW GRANTS FOR 'nombredelusuario'@'localhost';

