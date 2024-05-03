SELECT IF (500 < 1000, "YES", "NO");

SELECT OrderID, Quantity, 
CASE
    WHEN Quantity > 30 THEN "Over 30"
    WHEN Quantity = 30 THEN "30"
    ELSE "Under 30"
END AS QuantityText
-- Dará una columna llamada QuantityText que tendrá el valor "Over 30" si Quantity es mayor que 30, "30" si Quantity es igual a 30 y "Under 30" si Quantity es menor que 30
