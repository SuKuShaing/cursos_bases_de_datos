USE metro_cdmx;

DELETE FROM `stations`
WHERE id = 164;

DELETE FROM `stations`
WHERE id = 165;

DELETE FROM `stations`
WHERE name = "Benito Cardenas"; --no diferencia entre acentos y no Cárdenas y Cardenas, lo borra igual
-- Si diferencia la comilla francesa de las demás ``, debe usarse para la tabla y las normales para los textos y nada para los números