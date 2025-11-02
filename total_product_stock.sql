SELECT COUNT(*)
FROM inventory_staging2;

-- CHECKING TOTAL STOCK BASED ON DATES
SELECT `Date`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Date`
ORDER BY 1;

-- CHECKING TOTAL STOCKS BASED ON STORES
SELECT `Date`, `Store ID`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Date`, `Store ID`
ORDER BY 1;

-- CHECKING TOTAL STOCKS BASED ON REGION
SELECT `Date`, `Region`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Date`, `Region`
ORDER BY 1;

-- CHECKING TOTAL STOCKS BASED ON SEASONALITY
SELECT `Date`, `Seasonality`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Date`, `Seasonality`
ORDER BY 1;

-- CHECKING INVENTORY LEVELS BASED ON PRODUCT CATEGORIES
SELECT `Date`, `Category`, SUM(`Inventory Level`) As `Total Inventory`
FROM inventory_staging2
GROUP BY `Category`, `Date`
ORDER BY `Date` ASC;

-- CHECKING INVENTORY LEVELS BASED ON PRODUCT CATEGORIES AND REGION
SELECT `Date`, `Category`, `Region`, SUM(`Inventory Level`) As `Total Inventory`
FROM inventory_staging2
GROUP BY `Category`, `Region`, `Date`
ORDER BY `Date` ASC;

-- CHECKING INVENTORY LEVELS BASED ON PRODUCT IDs AND REGION
SELECT `Date`, `Product ID`, `Region`, SUM(`Inventory Level`) As `Total Inventory`
FROM inventory_staging2
GROUP BY `Product ID`, `Region`, `Date`
ORDER BY `Date` ASC;

-- CHECKING INVENTORY LEVELS BASED ON PRODUCT IDs
SELECT `Date`, `Product ID`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Product ID`, `Date`
ORDER BY `Date` ASC;

-- CHECKING INVENTORY LEVELS BASED ON PRODUCT IDs, STORE IDs AND REGION

SELECT `Date`, `Store ID`, `Product ID`, `Region`, SUM(`Inventory Level`) AS `Total Inventory`
FROM inventory_staging2
GROUP BY `Product ID`, `Store ID`, `Region`, `Date`
ORDER BY `Date` ASC, `Product ID` ASC;