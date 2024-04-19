--Lo que enseño el profe
USE metro_cdmx;

ALTER TABLE `stations`
MODIFY `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT
ADD PRIMARY KEY(id);

--añadir llaves foraneas
--ADD CONSTRAINT `nombreTabla_columna_foreign`
--FOREIGN KEY (`line_id`) REFERENCES `lines`(`ìd`)
--FOREIGN KEY (`columna_en_estaTabla`) REFERENCES `nombre_otra_tabla`(`columna_otra_tabla`)


-- estas son las modificaciones que hice yo
USE metro_cdmx;

ALTER TABLE `trains`
ADD CONSTRAINT `trains_line_id_foreign`
FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`);


ALTER TABLE `station`
MODIFY `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT;


ALTER TABLE `station` RENAME `stations`;