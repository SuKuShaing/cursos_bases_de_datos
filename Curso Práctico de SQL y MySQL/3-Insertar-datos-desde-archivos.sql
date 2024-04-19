-- Insertar datos desde archivos en la base de datos
-- Insertar datos desde documentos en la base de datos

-- en la consola bash, no dentro de mysql
-- en bash tenemos que movernos a la carpeta donde se encuentra el archivo 
-- ejecutar 
mysql -u root -p < Insertar-arhivo-desde-archivos.sql
-- En este archivo van los parametros para crear la base de datos, y las tablas


mysql -u root -p -D libreriaplatzi < Insertar-datos-desde-un-archivos.sql
-- En este caso usamos la flag -D para decirle a que base de datos queremos ingresar los datos
-- puesto que en el arhivo solo dice INSERT INTO, no dice en que base de datos