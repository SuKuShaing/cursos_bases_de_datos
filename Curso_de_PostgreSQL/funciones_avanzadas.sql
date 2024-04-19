-- Funciones avanzadas

COALES: compara dos valores y retorna el que es nulo
SELECT id, COALESCE(nombre, 'No Aplica') AS nombre, direccion_residencia, fecha_nacimiento
FROM public.pasajero WHERE id = 1;
-- En este caso el id 1, el nombre es Null, entonces se reemplaza por 'No Aplica'


NULLIF: compara dos valores y retorna null si son iguales
SELECT NULLIF (0, 0); -- Retorna null
-- Nos permite comparar dos valores y si son iguales, retorna null; esto se aplica antes de operaciones prohibidas como dividir por 0


GREATEST: Compara un arreglo de valores y retorna el mayor
SELECT GREATEST (0, 1, 2, 3, 4, 5, 6, 7);
-- Retorna 7


LEAST: Compara un arreglo de valores y retorna el menor
SELECT LEAST (0, 1, 2, 3, 4, 5, 6, 7);
-- Retorna 0


BLOQUES ANONIMOS: Ingresa condicionales dentro de una consulta de BD y lo retorno como una columna más
SELECT id, nombre, direccion_residencia, fecha_nacimiento,
CASE
	WHEN fecha_nacimiento > '2002-01-01' THEN
	'Niño'
	ELSE
	'Mayor'
END AS mas_18
FROM public.pasajero;
-- En este caso se evalua si la fecha de nacimiento es mayor a 2002-01-01, si es verdadero, se retorna 'Niño', de lo contrario 'Mayor' en la columna mas_18






SELECT id, nombre, direccion_residencia, fecha_nacimiento,
CASE
	WHEN fecha_nacimiento > '2002-01-01' THEN
	'Niño'
	ELSE
	'Mayor'
END AS mas_18,
CASE
	WHEN nombre ILIKE 'A%' OR nombre ILIKE 'E%' OR nombre ILIKE 'I%' OR nombre ILIKE 'O%' OR nombre ILIKE 'U%' THEN
	'Vocal'
	ELSE
	'Consonante'
END AS inicial
FROM public.pasajero;