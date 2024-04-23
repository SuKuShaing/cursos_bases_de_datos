-- Las transacciones son un conjunto de operaciones que se ejecutan como una sola unidad de trabajo.
-- si una de las operaciones falla, todas las operaciones fallan.
-- por ende, no se guardan los cambio realizados
-- por el contrario, si todas las operaciones se ejecutan correctamente, se guardan los cambios

-- Esto es especialmente util cuando se tienen que hacer varias operaciones que dependen unas de otras


-- para iniciar una transacción se usa el comando BEGIN
BEGIN;

INSERT INTO public.estacion(
	nombre, direccion)
	VALUES ('Estacion Transac', 'direcccccctiooiin');
	
INSERT INTO public.tren(
	modelo, capacidad)
	VALUES ('Tren Trans', 123);

COMMIT;
-- COMMIT; guarda los cambios
-- ROLLBACK; deshace los cambios



-- Ejemplo de una transacción que fallará
BEGIN;
	
INSERT INTO public.tren( -- Esta es correcta
	modelo, capacidad)
	VALUES ('Tren last', 456);

INSERT INTO public.estacion( -- Esta fallará
	id, nombre, direccion)
	VALUES (100, 'Estacion Fallada', 'direc fallada'); -- falla porque el id ya existe
	
COMMIT;

-- a pesar de la que primera inserción es correcta, la segunda no lo es, por ende, al ser un transacción, no se guardará nada, dado que ambas deben ser exitosas para que se guarden los cambios




-- Ejemplo de Rollback explicito
-- Si falla cualquier cosa dentro de la transacción, se hace un rollback implícito (automático)
-- pero también se puede hacer un rollback explicito (manual), como en el caso que sigue
BEGIN;
INSERT INTO tren (modelo, capacidad)
    VALUES ( Mustang z', 108), ('Caterpillar XX' , 126), ('kenworth 2020' , 119');

SAVEPOINT modeladd;

UPDATE trayecto
SET id_tren = 100
WHERE id = 88;

ROLLBACK TO modeladd;

COMMIT;

-- en este caso, se hace un rollback a un punto de guardado (SAVEPOINT), en este caso, el punto de guardado es modeladd
-- por ende, se deshacen los cambios hechos después de ese punto, en este caso, el UPDATE de trayecto
-- pero se guardan los cambios de las inserciones de tren
-- por ende, se guardan los trenes, pero no se actualiza el trayecto
