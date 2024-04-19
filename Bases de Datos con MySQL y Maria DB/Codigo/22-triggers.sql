-- Para actualizar el updated_at
USE metro_cdmx;

-- Para lines
CREATE TRIGGER update_updated_at_field
BEFORE UPDATE
ON `lines`
FOR EACH ROW
SET NEW.updated_at = NOW();

-- Para trains
CREATE TRIGGER update_updated_at_field_trains
BEFORE UPDATE
ON `trains`
FOR EACH ROW
SET NEW.updated_at = NOW();

-- Para stations
CREATE TRIGGER update_updated_at_field_stations
BEFORE UPDATE
ON `stations`
FOR EACH ROW
SET NEW.updated_at = NOW();

-- Para lines_stations
CREATE TRIGGER update_updated_at_field_lines_stations
BEFORE UPDATE
ON `lines_stations`
FOR EACH ROW
SET NEW.updated_at = NOW();



-- Podríamos evitar el trigger modificando el campo updated_at de la siguiente forma:
ALTER TABLE `lines` CHANGE COLUMN `updated_at` `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `created_at`;

-- Una segunda forma
ALTER TABLE `lines` MODIFY `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;