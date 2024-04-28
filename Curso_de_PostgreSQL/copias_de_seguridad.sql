-- En PgAdmin, para hacer una copia de seguridad de una BD, se puede hacer lo siguiente:
-- botón derecho sobre la BD -> Backup -> Custom o Plain-> Guardar en un archivo .sql

-- para restaurar una BD:
-- botón derecho sobre la BD -> Restore -> Custom o Plain -> Seleccionar el archivo .sql

-- Tipos de formatos
"
Custom -> Un formato propio de Postgres -> funciona muy bien con la misma versión desde la que fue exportado
Tar -> Un archivo comprimido que contiene la estructura de la BD
Plain -> SQL plano
Directory -> Estructura sin comprimir
"