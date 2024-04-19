USE metro_cdmx;

DELIMITER //
CREATE PROCEDURE get_line_stations (
    IN line_name VARCHAR(15)
)
BEGIN

    -- Estas es una variable line_id
    DECLARE line_id BIGINT(20);

    SELECT id
    INTO line_id
    FROM `lines`
    WHERE name = line_name
    COLLATE utf8mb4_unicode_ci;

    -- Esta es otra forma de guardar valores de una consulta dentro de una variable
    SET @sql = CONCAT("
        SELECT 
            `lines_stations`.`id` AS relation_id,
            `lines`.`name` AS line_name,
            `stations`.`name` AS stations_name
        FROM `lines_stations`
        INNER JOIN `stations`
        ON `stations`.`id` = `lines_stations`.`station_id`
        INNER JOIN `lines`
        ON `lines`.`id` = `lines_stations`.`line_id`
        WHERE `lines_stations`.`line_id`= ", line_id);
    -- Esto es solo texto, ahora hay que ejecutarlo

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt; 
    -- DEALLOCATE lo saca de memoria


END //

DELIMITER ;

-- Para guardar el resultado de una búsqueda en la variable line_id
-- hay que escribir INTO debajo del SELECT para decirle donde la queremos guardar

-- Para ejecutar el procedimiento hay que llamar así, y estando dentro de mysql
-- CALL get_line_stations("Linea 9");

-- Para eliminar un procedimiento hay que usar
-- DROP PROCEDURE get_line_stations; -- y se eliminó el procedimiento o la fc almacenada