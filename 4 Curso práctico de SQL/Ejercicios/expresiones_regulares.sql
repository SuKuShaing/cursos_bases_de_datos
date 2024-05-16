SELECT email
FROM platzi.alumnos
WHERE email ~*'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'; -- Toda expresión regular en SQL debe empezar por ~ 
-- ~* es para hacer una búsqueda case insensitive, [A-Z0-9._%+-] es para buscar cualquier carácter de la lista, + es para que se repita una o más veces, @ es para buscar el arroba, [A-Z0-9.-] es para buscar cualquier carácter de la lista, \. es para buscar el punto, [A-Z]{2,4} es para buscar de 2 a 4 letras mayúsculas


SELECT email
FROM platzi.alumnos
WHERE email ~*'[A-Z0-9._%+-]+@google[A-Z0-9.-]+\.[A-Z]{2,4}'; -- Devuelve los correos que son de google
