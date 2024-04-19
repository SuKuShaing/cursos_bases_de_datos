--Úsese con cuidado, puesto que esto vaciará la tabla completa
USE metro_cdmx;

-- Mode DELETE FROM
DELETE FROM `stations_delete`;


-- Esto es para que vean cómo un DELETE FROM  no restablece los id
--Inserta unas cuentas estaciones del metro
INSERT INTO `stations_delete` (name) VALUES
("Lázaro Cárdens"), -- Lázaro Cárdenas
("Ferería"), -- Ferrería 
("Pnttlán"), -- Pantitlán
("Tauga"), -- Tacuba
("MartínCrrera"), -- Martín Carrera
("Santa Anita");