--Úsese con cuidado, puesto que esto vaciará la tabla completa y reiniciará los ID
USE metro_cdmx;

-- Mode TRUNCATE
TRUNCATE TABLE `stations_delete`;


-- Esto es para que vean cómo un TRUNCATE TABLE si restablece los ID
--Inserta unas cuentas estaciones del metro
INSERT INTO `stations_delete` (name) VALUES
("Lázaro Cárdens"), -- Lázaro Cárdenas
("Ferería"), -- Ferrería 
("Pnttlán"), -- Pantitlán
("Tauga"), -- Tacuba
("MartínCrrera"), -- Martín Carrera
("Santa Anita");