USE metro_cdmx;

INSERT INTO `lines_stations` (line_id, station_id) VALUES
(
    (
        SELECT `lines`.`id`
        -- Se le coloca lines.id para ser más especifico puesto que puede ser solo id
        FROM `lines`
        WHERE `lines`.`name`="Línea 9"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Lázaro Cárdenas"
    )
),
(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 6"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Ferrería"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 1"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Pantitlán"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 5"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Pantitlán"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 9"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Pantitlán"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea A"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Pantitlán"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 2"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Tacuba"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 7"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Tacuba"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 4"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Martín Carrera"
    )
),(
    (
        SELECT `lines`.`id`
        FROM `lines`
        WHERE `lines`.`name`="Línea 6"
    ),
    (
        SELECT `stations`.`id`
        FROM `stations`
        WHERE `stations`.`name`="Martín Carrera"
    )
);