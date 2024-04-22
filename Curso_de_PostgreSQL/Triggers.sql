-- Triggers (Disparadores o lanzadores)

-- Se activan con un evento en una tabla, los eventos son INSERT, UPDATE, DELETE

-- Primero se crea la función o PL que se va a ejecutar

-- Función original de la clase de PL modificada para que sirva de trigger
CREATE OR REPLACE FUNCTION public.impl(
	)
    RETURNS TRIGGER -- Se cambió el tipo de dato que retorna de integer a trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
	-- RAISE NOTICE 'Un pasajero se llama %' , rec.nombre;  -- lo comentamos porque ya no vamos a mostrar mensajes
    contador := contador + 1;
 END LOOP;
    INSERT INTO cont_pasajero (total, tiempo) -- Se agregó esta línea
    VALUES (contador, now());                 -- que va a insertar el contador y la fecha actual en la tabla cont_pasajero 
    RAISE NOTICE 'El contateo es % ', contador;
	-- RETURN contador;      -- Se quitó el retorno porque retorna un trigger
    RETURN NEW; -- OLD, NEW; los triggers deben retornar algo, sino falla al momento de ejecutarse, OLD lo que estaba antes del cambio, NEW es el cambio

END
$BODY$;

ALTER FUNCTION public.impl() -- Esto lo agrega por defecto postgres
    OWNER TO postgres;



-- Luego se crea el trigger
CREATE TRIGGER mitrigger -- el nombre del trigger
AFTER INSERT -- Esta AFTER, BEFORE, y INSTEAD OF; osea el trigger se puede ejecutar antes, después o en lugar de lo que se iba a hacer
ON pasajero -- en la tabla pasajero
FOR EACH ROW -- para cada fila
EXECUTE PROCEDURE impl(); -- ejecuta la siguiente función



-- Ejercicio de trigger
-- que se ejecute al borrar una fila de la tabla pasajero
CREATE OR REPLACE FUNCTION public.dele(
	)
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    rec record;
    contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM pasajero LOOP
    contador := contador + 1;
 END LOOP;
    INSERT INTO cont_pasajero (total, tiempo) 
        VALUES (contador, now());                  
    RAISE NOTICE 'El conteo es % ', contador;
	RETURN NEW;
END
$BODY$;

ALTER FUNCTION public.dele()
    OWNER TO postgres;


-- Luego se crea el trigger
CREATE TRIGGER trigger_delete
AFTER DELETE
ON pasajero
FOR EACH ROW
EXECUTE PROCEDURE dele();

-- Perfecto