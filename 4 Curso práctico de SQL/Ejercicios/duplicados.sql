-- Encontrar duplicados

SELECT *
FROM platzi.alumnos AS ou
WHERE (
	SELECT COUNT(*)
	FROM platzi.alumnos AS inr
	WHERE ou.id = inr.id
) > 1;
-- tabla vacía


SELECT (platzi.alumnos.*)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.*
HAVING COUNT(*) > 1;
-- tabla vacía


SELECT (
	platzi.alumnos.nombre,
	platzi.alumnos.apellido,
	platzi.alumnos.email,
	platzi.alumnos.colegiatura,
	platzi.alumnos.fecha_incorporacion,
	platzi.alumnos.carrera_id,
	platzi.alumnos.tutor_id
	)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY 
	platzi.alumnos.nombre,
	platzi.alumnos.apellido,
	platzi.alumnos.email,
	platzi.alumnos.colegiatura,
	platzi.alumnos.fecha_incorporacion,
	platzi.alumnos.carrera_id,
	platzi.alumnos.tutor_id
HAVING COUNT(*) > 1;
-- Funciona, devuelve una fila con solo una columna donde agrupa toda la información


SELECT *
FROM (
	SELECT id,
	ROW_NUMBER() OVER(
		PARTITION BY
			nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id
		ORDER BY id ASC
        -- Row_number() le va poner un 1 a cada fila que sea única y sí encuentra una fila que tenga los valores que están dentro PARTITION repetidos, a esas fila tendrá un 2, osea se repite
	) AS row,
	*
	FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1;
-- Funciona, devuelve una fila con todas sus columnas



-- Reto: eliminar los duplicados
DELETE FROM platzi.alumnos
WHERE id = (
-- WHERE id IN ( para borrar los duplicados
    SELECT id
    FROM (
        SELECT
        ROW_NUMBER() OVER(
            PARTITION BY
                nombre,
                apellido,
                email,
                colegiatura,
                fecha_incorporacion,
                carrera_id,
                tutor_id
            ORDER BY id ASC
            -- Row_number() le va poner un 1 a cada fila que sea única y sí encuentra una 
            -- fila que tenga los valores que están dentro PARTITION repetidos, a esas fila tendrá un 2, osea se repite
        ) AS row,
        *
        FROM platzi.alumnos
    ) AS duplicados
    WHERE duplicados.row > 1
);