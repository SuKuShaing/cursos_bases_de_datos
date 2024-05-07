-- Manejo de fecha y hora

SELECT EXTRACT(YEAR FROM fecha_incorporacion) AS anio_incorporacion
FROM platzi.alumnos;
-- Extrae el año

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
FROM platzi.alumnos;
-- Extrae el año al igual que el anterior pero con otra sintaxis


-- PARA EXTRAER EL AÑO, MES Y DÍA, mediante EXTRACT y DATE_PART
SELECT EXTRACT(YEAR FROM fecha_incorporacion) AS anio_incorporacion,
		EXTRACT(MONTH FROM fecha_incorporacion) AS mes_incorporacion,
		EXTRACT(DAY FROM fecha_incorporacion) AS dia_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
		DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
		DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion
FROM platzi.alumnos;