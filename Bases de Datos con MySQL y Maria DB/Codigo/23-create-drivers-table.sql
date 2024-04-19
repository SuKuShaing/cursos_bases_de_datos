USE metro_cdmx;

CREATE TABLE `drivers` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `name` varchar(30) not NULL,
    `status` BOOLEAN not NULL DEFAULT FALSE,
    
    `created_at` timestamp not NULL default current_timestamp,
    `updated_at` timestamp not NULL default current_timestamp,

    PRIMARY KEY (id)
)

default CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;