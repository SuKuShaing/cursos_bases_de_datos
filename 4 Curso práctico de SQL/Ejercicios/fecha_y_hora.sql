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


-- Reto: EXTRAER LA HORA, MINUTO Y SEGUNDO
SELECT EXTRACT(HOUR FROM fecha_incorporacion) AS hora_incorporacion,
        EXTRACT(MINUTE FROM fecha_incorporacion) AS minuto_incorporacion,
        EXTRACT(SECOND FROM fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('HOUR', fecha_incorporacion) AS hora_incorporacion,
        DATE_PART('MINUTE', fecha_incorporacion) AS minuto_incorporacion,
        DATE_PART('SECOND', fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;



-- Usar Fecha y hora para filtrar

SELECT *
FROM platzi.alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2018;
-- Selecciona los alumnos que se incorporaron en el 2018

SELECT *
FROM platzi.alumnos
WHERE (DATE_PART('YEAR', fecha_incorporacion)) = 2018;
-- Funciona exactamente igual que el anterior

SELECT *
FROM (
	SELECT *,
			DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
	FROM platzi.alumnos
) AS alumnos_con_anio
WHERE anio_incorporacion = 2020;
-- Crea una columna con el año de incorporación y luego filtra los alumnos que se incorporaron en el 2020


-- Reto: seleccionar a los del 2020 y que se incorporaron en mayo

-- Método 1
SELECT *
FROM (
	SELECT *,
			DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
			DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion
	FROM platzi.alumnos
) AS alumnos_con_anio
WHERE anio_incorporacion = 2020
	AND mes_incorporacion = 5;

-- Método 2
SELECT *
FROM platzi.alumnos
WHERE (DATE_PART('YEAR', fecha_incorporacion)) = 2018
	AND (DATE_PART('MONTH', fecha_incorporacion)) = 5;

-- Método 3
SELECT *
FROM platzi.alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2018
	AND (EXTRACT(MONTH FROM fecha_incorporacion)) = 5;