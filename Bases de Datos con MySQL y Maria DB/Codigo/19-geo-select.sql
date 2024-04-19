USE metro_cdmx;

-- Calculamos distancia con datos quemados
SELECT ST_Distance_Sphere(
    POINT(-99.14912224, 19.42729875),
    POINT(-99.13303971, 19.42543703)
) AS distance;


-- Calculamos en kilometros con datos quemados
SELECT ST_Distance_Sphere(
    POINT(-99.14912224, 19.42729875),
    POINT(-99.13303971, 19.42543703)
) / 1000 AS distance;


-- Reto superado así
SELECT ST_Distance_Sphere(
    (
        SELECT `locations`.`location` 
        FROM `locations`
        WHERE `locations`.`stations_id` = (
            SELECT `id` 
            FROM `stations`
            WHERE `name` = "Santa Anita" 
        )
    ),
    (
        SELECT `locations`.`location` 
        FROM `locations`
        WHERE `locations`.`stations_id` = (
            SELECT `id` 
            FROM `stations`
            WHERE `name` = "Tacuba" 
        )
    )
) / 1000 AS distance;


-- Reto: Así lo hizo el profe
SELECT ST_Distance_Sphere(
    (
        SELECT `locations`.`location` 
        FROM `locations`
        INNER JOIN `stations`
        ON `stations`.`id` = `locations`.`stations_id`
        WHERE `stations`.`name`= "Santa Anita"
    ),
    (
        SELECT `locations`.`location` 
        FROM `locations`
        INNER JOIN `stations`
        ON `stations`.`id` = `locations`.`stations_id`
        WHERE `stations`.`name`= "Tacuba"
    )
) / 1000 AS distace;