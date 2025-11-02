-- CHECKING INVENTORY LEVELS AGAINST ROP


CREATE TABLE low_inventory
SELECT ci.`Date`, ltd.`Unique Store`, ltd.`Product ID`, ltd.`Seasonality`, ci.`Inventory Level` AS `Inventory Level`, ROUND(ltd.`ROP`,2) AS `ROP`, 
IF(`Inventory Level`<`ROP`, 'Low Inventory Detected', 'Normal Inventory') AS `Inventory Status`
FROM lead_time_demand ltd
JOIN corrected_inventory ci
ON ltd.`Unique Store`=ci.`Unique Store` AND ltd.`Product ID`=ci.`Product ID` AND ltd.`Seasonality`=ci.`Seasonality`;

SELECT *
FROM low_inventory;

-- CHECKING LOW INVENTORY FOR PRODUCTS ACROSS STORES BASED ON SEASONS

SELECT `Unique Store`, `Product ID`, `Seasonality`, `Inventory Status`, COUNT(*) AS `Number of Days`
FROM low_inventory
GROUP BY `Unique Store`, `Product ID`, `Seasonality`, `Inventory Status`
HAVING `Inventory Status`='Low Inventory Detected'
ORDER BY `Unique Store`, `Product ID`;


-- CHECKING LOW INVENTORY FOR PRODUCTS ACROSS STORES IRRESPECTIVE OF SEASONS

SELECT `Unique Store`, `Product ID`, `Inventory Status`, COUNT(*) AS `Number of Days`
FROM low_inventory
GROUP BY `Unique Store`, `Product ID`, `Inventory Status`
HAVING `Inventory Status`='Low Inventory Detected'
ORDER BY `Unique Store`, `Product ID`;


-- CHECKING MAXIMUM LOW INVENTORY DAYS FOR EACH UNIQUE STORE

WITH low_inventory_counts AS (
    SELECT 
        `Unique Store`, 
        `Product ID`, 
        `Inventory Status`, 
        COUNT(*) AS `Number of Days`
    FROM low_inventory
    WHERE `Inventory Status`='Low Inventory Detected'
    GROUP BY `Unique Store`, `Product ID`, `Inventory Status`
)

SELECT 
    `Unique Store`, 
    MAX(`Number of Days`) AS `Max Low Inventory Days`
FROM low_inventory_counts
GROUP BY `Unique Store`
ORDER BY `Unique Store`;






