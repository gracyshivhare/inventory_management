-- INVENTORY TURNOVER RATIO IS THE RATIO OF THE TOTAL NUMBER OF GOODS SOLD TO THE AVERAGE INVENTORY LEVEL AT ANY GIVEN DAY FOR A PERIOD OF TIME
-- TAKING TIME PERIOD AS QUARTERS


-- QUARTER 1 '22
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 2 '22
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2022-04-01' AND '2022-06-30'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 3 '22
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2022-07-01' AND '2022-09-30'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 4 '22
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2022-10-01' AND '2022-12-31'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 1 '23
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 2 '23
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2023-04-01' AND '2023-06-30'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 3 '23
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2023-07-01' AND '2023-09-30'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;

-- QUARTER 4 '23
SELECT `Store ID`, `Region`, `Product ID`, SUM(`Units Sold`) AS `Total Units Sold`, ROUND(AVG(`Inventory Level`),2) AS `Average Inventory`, ROUND(SUM(`Units Sold`)/AVG(`Inventory Level`),2) AS `Inventory Turnover Ratio`
FROM corrected_inventory_zeroed
WHERE `Date` BETWEEN '2023-10-01' AND '2023-12-31'
GROUP BY `Store ID`, `Region`, `Product ID`
ORDER BY `Store ID`, `Region`, `Product ID`;