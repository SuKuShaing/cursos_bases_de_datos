USE metro_cdmx;
--se puede agregar OUT después de los IN, que sobre escribe algo en medio de la fc
--así tbm es como se usa el if

DELIMITER //
CREATE PROCEDURE calculate_distance_between_lines(
    IN station_one POINT,
    IN station_two POINT,
    IN meters BOOLEAN
)
BEGIN

    IF meters THEN

        SELECT
        ST_Distance_Sphere(station_one, station_two) AS distances;
    
    ELSE

        SELECT
        ST_Distance_Sphere(station_one, station_two) / 1000 AS distances;

    END IF;

END //

DELIMITER ;
--el punto y coma debe ir separado de la palabra DELIMITER, por que si

-------------Para Usar una fc en mysql--------------------------
-- Para usar esa fc dentro de mysql en la terminal hay que usar lo siguiente
-- CALL nombre_de_la_fc(parametros, todos, los, puestos); --así de simple
-- ejemplo 
-- CALL calculate_distance_between_lines(POINT(-99.144337718, 19.40702104), POINT(-99.173702, 19.49039233));
-- y dá el resultado


-------------Para Eliminar una fc en mysql--------------------------
-- Para eliminar una fc se usa
-- DROP PROCEDURE nombre_de_la_fc;
-- Ejemplo: 
-- DROP PROCEDURE calculate_distance_between_lines;
