USE metro_cdmx;

-- Creación de la tabla lines_stations
CREATE TABLE `lines_stations` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    
    `line_id` BIGINT(20) UNSIGNED NOT NULL,
    `station_id` BIGINT(20) UNSIGNED NOT NULL,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id),

    CONSTRAINT `lines_stations_line_id_foreign`
    FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`), 
    -- y se agrego esto
    
    CONSTRAINT `lines_stations_station_id_foreign`
    FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`) 
    -- y se agrego esto
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;