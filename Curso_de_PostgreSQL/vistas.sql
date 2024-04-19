vistas

-- Vistas Volátil:
-- Son vistas que se actualizan cada vez que se consultan.
-- Van a la base de datos y traen los datos en tiempo real.

-- Se guardó el siguiente código bajo el nombre "rango_view"
SELECT id,
    nombre,
    direccion_residencia,
    fecha_nacimiento,
        CASE
            WHEN fecha_nacimiento > '2002-01-01'::date THEN 'Niño'::text
            ELSE 'Mayor'::text
        END AS mas_18
FROM pasajero;

-- ahora solo se llama a la vista así
SELECT * FROM rango_view;





-- Vistas Materializadas:
-- Son vistas que se consultan una sola vez a la base de datos y quedan guardadas en memoria.
-- La siguiente vez que se consulte la vista, se traerán los datos guardados en memoria, por ende son más rápidas.

-- Se guardó el siguiente código bajo el nombre "despues_2000_mview"
SELECT *, NOW() AS updated FROM viaje
WHERE inicio > '2000-01-01 00:00:00'
ORDER BY inicio;

-- ahora solo se llama a la vista así:
SELECT * FROM despues_2000_mview;

-- Para actualizar la vista materializada se usa el siguiente comando
REFRESH MATERIALIZED VIEW despues_2000_mview;

-- Se recomienda agregar una columna para indicar la fecha del último “refresh” de la información