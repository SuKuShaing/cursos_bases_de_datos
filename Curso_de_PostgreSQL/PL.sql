-- PL/pgSQL: PROCEDURAL LENGUAJE

-- Se puede insertar código en una función PL	

-- Para hacer un Procedimiento Almacenado se usa la siguiente estructura
DO $$ -- DO es para iniciar un bloque de código
DECLARE -- Aquí van las variables
    nombre_variable tipo_dato;
BEGIN
    -- Aquí va el código
END
$$;

-- Se puede hacer DO '', pero al momento de colocar otra comillas dentro del código, interfiere con comilla de apertura y falla, mejor usar los signos pesos dobles para marcar donde incian y cierran $$


--Ejemplo de un Procedimiento Almacenado
DO $$
DECLARE
    rec record; -- nombre_variable record(permite almacenar datos de una fila) y después su valor
    -- := (dos puntos igual) es para asignar el valor a una variable
    contador integer := 0;
BEGIN
 -- La estructura es
 -- FOR (variable) IN (lista a recorrer) LOOP
 -- (Cosas a hacer
 -- END LOOP
 FOR rec IN SELECT * FROM pasajero LOOP -- Cada una de las filas SELECT * FROM pasajero queda guardado en 'rec' 
	 	 -- rec.nombre
 	     -- rec.id
 
		 -- RAISE NOTICE 'mensaje' Esto se anota en la vitacora de Postgres
	 RAISE NOTICE 'Un pasajero se llama %' , rec.nombre; -- % será reemplazado con la variable rec.nombre
     contador := contador + 1;
 END LOOP;
    RAISE NOTICE 'El conteo es % ', contador;
END
$$;


-- Esto no se puede llamar como una función
-- Ahora para que sea función se debe hacer lo siguiente


CREATE FUNCTION importantePL()
 RETURNS void -- hay que indicarle el tipo de dato que retorna, en este caso no retorna nada
AS $$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
    RAISE NOTICE 'Un pasajero se llama %' , rec.nombre;
    contador := contador + 1;
 END LOOP;
    RAISE NOTICE 'El contateo es % ', contador;
END
$$
LANGUAGE PLPGSQL; -- Hay que indicarle el lenguaje que se va a usar la función
-- Soporta PLPGSQL, SQL, C++ y Python (hay que incluir librerías pero lo soporta)
-- RAISE Y FOR, SON OBJETOS PROPIOS DE POSTGRELSQL;


-- Para llamar a la función se usa
SELECT importantePL(); -- Se llama a la función


-- Para borrara la función se usa
DROP FUNCTION importantePL(); -- Se borra la función


-- Para actualizar la función se usa el mismo código modificado
CREATE OR REPLACE FUNCTION importantePL() -- con OR REPLACE se actualiza la función (DEBERÍA SER ASÍ)
 RETURNS integer -- aquí se actualizó el dato que retorna
AS $BODY$ -- $BODY$ es lo mismo que $$, pero se usa para indicar que es el cuerpo de la función
DECLARE 
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
    RAISE NOTICE 'Un pasajero se llama %' , rec.nombre;
    contador := contador + 1;
 END LOOP;
    RAISE NOTICE 'El contateo es % ', contador;
	RETURN contador; -- Se retorna el valor de la variable contador
END
$BODY$
LANGUAGE PLPGSQL;