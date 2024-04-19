USE metro_cdmx;

CREATE TABLE `active_drivers` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    
    `driver_id` BIGINT(20) UNSIGNED NOT NULL,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id),
    CONSTRAINT `status_drivers_driver_id_foreign`
    FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;