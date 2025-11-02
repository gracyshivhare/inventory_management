-- ASSUMING THE SUPPLIERS NEGLIGIENCE AND INCONSISTENCY IN A CASE WHEN UNITS ORDERED - UNITS SOLD + INVENTORY LEVEL ARE OVERSHADOWED BY THE DEMAND FORECASR
-- ASSUMING SUPPLIER TO OPERATE STOREWISE AND NOT INDIVIDUAL REGIONS

CREATE TABLE supplier_inconsistency
SELECT `Store ID`, `Seasonality`, `Units Ordered`, `Units Sold`, `Inventory Level`, `Demand Forecast`,
IF(`Units Ordered`-`Units Sold`+`Inventory Level`<`Demand Forecast`, 'Supplier Inconsistency', ' ') AS `Supplier Performance?`
FROM inventory_forecasting;


SELECT `Store ID`, `Seasonality`, `Supplier Performance?`, COUNT(*) AS `Number of Occurences of Negligience Across Products`
FROM supplier_inconsistency
WHERE `Supplier Performance?`='Supplier Inconsistency'
GROUP BY `Store ID`, `Seasonality`, `Supplier Performance?`
ORDER BY `Store ID`, `Seasonality`, `Supplier Performance?`;