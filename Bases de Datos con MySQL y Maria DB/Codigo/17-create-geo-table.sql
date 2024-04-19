USE metro_cdmx;

-- Creación de la tabla de tabla
CREATE TABLE `locations` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `stations_id` BIGINT(20) UNSIGNED NOT NULL,
    `location` POINT NOT NULL,
    -- `number_street` INT(10) NOT NULL

    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id),

    CONSTRAINT `locations_stations_id_foreign`
    FOREIGN KEY (`stations_id`) REFERENCES `stations` (`id`)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;