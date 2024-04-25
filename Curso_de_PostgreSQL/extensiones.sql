-- Las extensiones son módulos que se pueden agregar a PostgreSQL para agregar funcionalidades adicionales.
-- En esta web se pueden encontrar las extensiones disponibles: https://www.postgresql.org/docs/11/contrib.html
-- Para usarlas primero hay que habilitarlas con el comando CREATE EXTENSION nombre_extension;

-- Para instalar una extensión en PostgreSQL se utiliza la siguiente sintaxis:
CREATE EXTENSION fuzzystrmatch;

-- Para desinstalar una extensión en PostgreSQL se utiliza la siguiente sintaxis:
DROP EXTENSION fuzzystrmatch;

-- Para usar un modulo de la extensión fuzzystrmatch se puede hacer lo siguiente:
SELECT levenshtein ('oswaldo', 'osvaldo');



-- Puedes listar todas las extensiones disponibles en postgres y visualizar una pequeña descripción de su funcionamiento con este comando.
SELECT * FROM pg_available_extensions;
