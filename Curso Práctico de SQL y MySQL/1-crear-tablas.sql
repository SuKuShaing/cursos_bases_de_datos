-- Crearemos la base de datos de una librería

-- Las palabras reservadas en mayúscula y los nombres de tablas, columnas y bases de datos en minúscula, por acuerdo.

-- Crear la base de datos si no existe, en caso de que exista no la crea
CREATE DATABASE IF NOT EXISTS platzi_operation;

CREATE TABLE IF NOT EXISTS `books` (
    `book_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `author_id` INT UNSIGNED,
    `title` VARCHAR(100) NOT NULL,
    `year` INT UNSIGNED NOT NULL DEFAULT 1900,
    `lenguage` VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language Code',
    `cover_url` VARCHAR(500),
    `price` DOUBLE(6,2) NOT NULL DEFAULT 10.00,
    -- Double es un número con decimales, almacena el número y sus decimales
    -- double(6,2) significa que el número tendrá 6 dígitos en total y 2 decimales, es decir, 4 dígitos enteros y 2 decimales
    -- float es un número con decimales, almacena el número y hasta 6 decimales
    `sellable` TINYINT(1) DEFAULT 1,
    -- Sellable, es vendible, se puede vender o no
    -- tinyint(1) es un número entero que puede almacenar valores de -128 a 127
    -- bigint(20) es un número entero que puede almacenar valores de -9223372036854775808 a 9223372036854775807
    `copies` INT NOT NULL DEFAULT 1,
    `description` TEXT
    -- tinitext es un texto que puede almacenar hasta 255 caracteres
    -- text es un texto que puede almacenar hasta 65535 caracteres
    -- varchar es un texto que puede almacenar hasta 65535 caracteres
    -- mediumtext es un texto que puede almacenar hasta 16777215 caracteres
    -- longtext es un texto que puede almacenar hasta 4294967295 caracteres
    -- bigtext es un texto que puede almacenar hasta 4294967295 caracteres
);

CREATE TABLE IF NOT EXISTS `authors` (
    `author_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `nationality` VARCHAR(2) NOT NULL DEFAULT 'MX' COMMENT 'ISO 3166-1 Country Code'
);

CREATE TABLE IF NOT EXISTS `clients` (
    `client_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `birthdate` DATE,
    `gender` ENUM('M', 'F', 'ND') NOT NULL,
    -- ENUM es un tipo de dato que puede almacenar un valor de una lista de valores predefinidos
    `active` TINYINT(1) NOT NULL DEFAULT 1,
    `phone` VARCHAR(20),
    `address` VARCHAR(200),
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    -- TIMESTAMP es un número "epoc", el número de segundos desde 1970 (el inicio de los pc) a la fecha, es un número entero, el programa lo convierte a `yyyy-mm-dd hh:mm:ss`
    -- DATE es un valor que puede almacenar fechas anteriores al 1970 y los cumpleaños deben ser guardados en DATE
    -- TIMESTAMP tiene el formato `yyyy-mm-dd hh:mm:ss`
    -- DATE tiene el formato `yyyy-mm-dd`
    -- TIME tiene el formato `hh:mm:ss`
    -- YEAR tiene el formato `yyyy`
    -- DATETIME tiene el formato `yyyy-mm-dd hh:mm:ss`
    -- MONTH tiene el formato `yyyy-mm`
    -- DAY tiene el formato `yyyy-mm-dd`
    -- HOUR tiene el formato `hh`
    -- MINUTE tiene el formato `mm`
    -- SECOND tiene el formato `ss`
    -- WEEK tiene el formato `yyyy-ww`
    -- QUARTER tiene el formato `yyyy-q`
    -- MICROSECOND tiene el formato `yyyy-mm-dd hh:mm:ss.000000`
    -- NANOSECOND tiene el formato `yyyy-mm-dd hh:mm:ss.000000000`
);


CREATE TABLE IF NOT EXISTS `operations` (
    `operation_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `book_id` INT UNSIGNED,
    `client_id` INT UNSIGNED,
    `operation_type` ENUM('rent', 'return', 'sell') NOT NULL,
    -- Se debe usar comilla normal para los valores dentro de ENUM
    `finshed` TINYINT(1) NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);