-- Crear las tablas

USE metro_cdmx; -- para decirle en que base de datos voy a crear la tabla
CREATE TABLE `lines` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, --se le agrego unsigned que significa que no puede ser negativo
    
    `name` varchar(10) not NULL,
    `color` varchar(15) not NULL,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `trains` (
    `serial_number` VARCHAR(10) NOT NULL,
    
    `line_id` BIGINT(20) UNSIGNED NOT NULL,
    `type` TINYINT(4) NOT NULL,
    `year` INT(4) NOT NULL,
    
    `created_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,
    `updated_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,

    PRIMARY KEY (serial_number),
    CONSTRAINT `trains_line_id_foreign` --se agrego esto
    FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`) -- y se agrego esto
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `stations` ( --se le agrego la S al final
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT, --se le agrego unsigned
    
    `name` varchar(50) NOT NULL,
    
    `created_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,
    `updated_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,

    PRIMARY KEY (id)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `stations_delete` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    
    `name` varchar(50) NOT NULL,
    
    `created_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,
    `updated_at` TIMESTAMP DEFAULT current_timestamp NOT NULL,

    PRIMARY KEY (id)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;