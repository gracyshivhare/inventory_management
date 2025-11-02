-- COMBINING THE STORE ID AND REGION TO CREATE A NEW COLUMN

SELECT CONCAT(`Store ID`, ' ', `Region`) AS `Unique Store`
FROM corrected_inventory_zeroed;

ALTER TABLE corrected_inventory_zeroed
ADD `Unique Store` text;

SELECT *
FROM corrected_inventory_zeroed;

UPDATE corrected_inventory_zeroed
SET `Unique Store` = CONCAT(`Store ID`, ' ', `Region`);

SELECT *
FROM corrected_inventory_zeroed
WHERE `Product ID`='P0016' AND `Unique Store`='S001 North';

-- CALCULATING TOTAL UNITS SOLD FOR A PRODUCT IN A STORE OVER A SEASON

SELECT `Unique Store`, `Product ID`, `Seasonality`, SUM(`Units Sold`)
FROM corrected_inventory_zeroed
GROUP BY `Unique Store`, `Product ID`, `Seasonality`; 


-- CALCULATING AVERAGE DAILY USAGE BY DIVIDING TOTAL SALES BY NUMBER OF DAYS OVER A SEASON

DROP TABLE IF EXISTS average_daily_usage;
CREATE TABLE average_daily_usage
SELECT `Unique Store`, `Product ID`, `Seasonality`, SUM(`Units Sold`) / COUNT(*) AS `Average Daily Use`
FROM corrected_inventory_zeroed
GROUP BY `Unique Store`, `Product ID`, `Seasonality`;

SELECT *
FROM average_daily_usage;

-- CALCULATING LEAD TIME BY CHECKING INVENTORY LEVELS. ASSUMING THAT AN INCREASE IN INVENTORY LEVEL MEANS RESTOCKING OF INVENTORY, SIGNIFYING FULFILMENT OF ORDER.

SELECT `Date`, `Unique Store`, `Product ID`, `Inventory Level`, LAG(`Inventory Level`) OVER(PARTITION BY `Unique Store`, `Product ID` ORDER BY `Unique Store`, `Product ID`, `Date`) AS `Previous Inventory Level`, `Inventory Level` - LAG(`Inventory Level`) OVER(PARTITION BY `Unique Store`, `Product ID` ORDER BY `Unique Store`, `Product ID`, `Date`) AS `Inventory Difference`
FROM corrected_inventory_zeroed
ORDER BY `Unique Store`, `Product ID`, `Date`;


DROP TABLE IF EXISTS lead_time;
CREATE TABLE lead_time
SELECT *
FROM (
    SELECT 
        `Date`, 
        `Unique Store`, 
        `Product ID`, 
        `Seasonality`,
        `Inventory Level`,
        `Inventory Level` - LAG(`Inventory Level`) OVER (
            PARTITION BY `Unique Store`, `Product ID`
            ORDER BY `Date`
        ) AS `Inventory Difference`
    FROM corrected_inventory_zeroed
) AS sub
WHERE `Inventory Difference` > 0 OR `Date`='2022-01-01'
ORDER BY `Unique Store`, `Product ID`, `Date`;

SELECT *
FROM lead_time;


-- TO AVOID ERROR IN LEAD TIME DAYS DUE TO DISTRIBUTION IN SEASONS, WE UPDATE THE SEASONALITY COLUMN YEAR WISE

UPDATE lead_time
SET `Seasonality`='Winter 21'
WHERE `Date` BETWEEN '2022-01-01' and '2022-02-28';


UPDATE lead_time
SET `Seasonality`='Spring 22'
WHERE `Date` BETWEEN '2022-03-01' and '2022-04-30';

UPDATE lead_time
SET `Seasonality`='Summer 22'
WHERE `Date` BETWEEN '2022-05-01' and '2022-07-31';

UPDATE lead_time
SET `Seasonality`='Autumn 22'
WHERE `Date` BETWEEN '2022-08-01' and '2022-10-31';

UPDATE lead_time
SET `Seasonality`='Winter 22'
WHERE `Date` BETWEEN '2022-11-01' and '2023-02-28';

UPDATE lead_time
SET `Seasonality`='Spring 23'
WHERE `Date` BETWEEN '2023-03-01' and '2023-04-30';

UPDATE lead_time
SET `Seasonality`='Summer 23'
WHERE `Date` BETWEEN '2023-05-01' and '2023-07-31';

UPDATE lead_time
SET `Seasonality`='Autumn 23'
WHERE `Date` BETWEEN '2023-08-01' and '2023-10-31';

UPDATE lead_time
SET `Seasonality`='Winter 23'
WHERE `Date` BETWEEN '2023-11-01' and '2023-12-31';


-- CALCULATING DIFFERENCES IN DATES SIGNIFYING LEAD TIME

DROP TABLE IF EXISTS date_diffs;
CREATE TABLE date_diffs
SELECT *
FROM (
    SELECT 
        `Date`,
        LAG(`Date`) OVER (
            PARTITION BY `Unique Store`, `Product ID`, `Seasonality`
            ORDER BY `Date`
        ) AS `Previous Date`,
        DATEDIFF(`Date`, LAG(`Date`) OVER (
            PARTITION BY `Unique Store`, `Product ID`, `Seasonality`
            ORDER BY `Date`
        )) AS `Date Difference`,
        `Unique Store`, 
        `Product ID`,
        `Seasonality`,
        `Inventory Difference`
    FROM lead_time
) AS sub
ORDER BY `Unique Store`, `Product ID`, `Date`;



SELECT *
FROM date_diffs;


-- RE-UPDATING THE SEASONALITY COLUMN

UPDATE date_diffs
SET `Seasonality`= 'Winter'
WHERE `Seasonality` LIKE 'Winter%';

UPDATE date_diffs
SET `Seasonality`= 'Spring'
WHERE `Seasonality` LIKE 'Spring%';

UPDATE date_diffs
SET `Seasonality`= 'Summer'
WHERE `Seasonality` LIKE 'Summer%';

UPDATE date_diffs
SET `Seasonality`= 'Autumn'
WHERE `Seasonality` LIKE 'Autumn%';


DROP TABLE IF exists lead_time_final;
CREATE TABLE lead_time_final
SELECT `Unique Store`, `Product ID`, `Seasonality`, ROUND(AVG(`Date Difference`),2) AS `Seasonal Lead Time`, ROUND(STDDEV_POP(`Date Difference`),2) AS `Std. Dev. Lead Time`
FROM date_diffs
GROUP BY `Unique Store`, `Product ID`, `Seasonality`
ORDER BY `Unique Store`, `Product ID`;

SELECT *
FROM lead_time_final; 


-- CALCULATING LEAD TIME DEMAND, WHICH IS ALSO THE ROP FOR OUR CASE, SINCE DUE TO FORWARD FILLING OF DATA, THE SAFETY STOCK BECOMES AN INCORRECT ESTIMATE DUE TO HIGH STANDARD DEVIATIONS

DROP TABLE IF EXISTS lead_time_demand;
CREATE TABLE lead_time_demand
SELECT adu.`Unique Store`, adu.`Product ID`, adu.`Seasonality`, adu.`Average Daily Use`, ltf.`Seasonal Lead Time`, adu.`Average Daily Use` * ltf.`Seasonal Lead Time` AS `ROP`
FROM average_daily_usage adu
JOIN lead_time_final ltf
ON adu.`Unique Store`=ltf.`Unique Store` AND adu.`Product ID`=ltf.`Product ID` AND adu.`Seasonality`=ltf.`Seasonality`
ORDER BY `Unique Store`, `Product ID`;



SELECT *
FROM lead_time_demand;



















SELECT *
FROM inventory_forecasting
WHERE `Product ID`='P0096' AND `Store ID`='S001' AND `Region`='East';
