--Para WINDOWS debes ocupar así para entrar a mariadb y empezar a ejecutar código sql
$ mysql -u root -p
$ mysql -u Sebastian -p --(cuando tienes usuarios creados)

-- para ejecutar instrucciones completas ya escritas
$ mysql -u Sebastian -p < nombre-del-archivo.sql -- después de esto te pedirá el password del usuario

-u --para decirle que lo que viene es el usuario
-p -- para decirle que te pida la contraseña

-- en caso de que en respuesta tengas un warning
-- para verlo debes escribir
SHOW WARNINGS;


--Para Salir 
exit;