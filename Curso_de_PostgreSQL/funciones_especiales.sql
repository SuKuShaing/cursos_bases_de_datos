-- Funciones especiales

ON CONFLICT DO
-- Ayuda a manejar los conflictos que se generan al insertar datos en una tabla que tiene una restricción de unicidad, es decir que ya exista el dato y sea unique.
-- después nos deja actualizar el dato en conflicto

INSERT INTO public.estacion(
	id, nombre, direccion)
	VALUES (1, 'Nombre', 'Dirección')
	ON CONFLICT(id) DO 
		UPDATE SET nombre = 'Nombre', direccion = 'Dire';
	

-- ON CONFLICT DO NOTHING;
-- - NOTHING NO HACE NADA, NO INSERTA EL DATO

-- ON CONFLICT(id) DO UPDATE SET nombre = 'Nombre', direccion = 'Dire';
-- - Actualiza el dato en conflicto


-- Ejemplo de copilot:
INSERT INTO nombre_tabla (columna1, columna2, columna3)
VALUES (valor1, valor2, valor3)
ON CONFLICT (columna1)
DO UPDATE SET columna2 = valor2, columna3 = valor3;





RETURNING
-- Nos permite devolver los datos que acabamos de insertar, actualizar o eliminar.
-- para ver si se insertaron correctamente o si se actualizaron correctamente.

INSERT INTO public.estacion(
	nombre, direccion)
	VALUES ('Ret', 'otro')
RETURNING *;
-- Devuelve la fila que se insertó




LIKE / ILIKE
-- LIKE es un operador que se utiliza para comparar una cadena de texto con un patrón, por ejemplo: %, _.
-- ILIKE es un operador que se utiliza para comparar una cadena de texto con un patrón, pero no distingue entre mayúsculas y minúsculas.

SELECT nombre
	FROM public.pasajero
	WHERE nombre ILIKE 'o%';
	
-- LIKE recibe % (muchos caracteres) y _ (un solo caracter), diferencia entre mayuscula y minuscula
-- ILIKE es lo mismo, pero no diferencia entre entre mayuscula y minuscula




IS / IS NOT
-- IS es un operador que se utiliza para comparar si un valor es igual a otro.
-- en especial se utiliza para comparar si un valor es NULL.

SELECT * 
	FROM public.tren
	WHERE modelo IS NOT NULL;