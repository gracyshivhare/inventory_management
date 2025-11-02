SELECT *
FROM inventory_forecasting;

CREATE TABLE inventory_staging
LIKE inventory_forecasting;

SELECT *
FROM inventory_staging;

INSERT inventory_staging
SELECT *
FROM inventory_forecasting;

SELECT COUNT(*)
FROM inventory_staging;


-- REMOVING DUPLICATES FROM THE GIVEN DATASET


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Date`, `Store ID`, `Product ID`, Category, Region, `Inventory Level`, `Units Sold`, `Units Ordered`, `Demand Forecast`, Price, Discount, `Weather Condition`, `Holiday/Promotion`, `Competitor Pricing`, Seasonality ) AS row_num
FROM inventory_staging
)
DELETE
FROM duplicate_cte
WHERE row_num>1;


CREATE TABLE `inventory_staging2` (
  `Date` text,
  `Store ID` text,
  `Product ID` text,
  `Category` text,
  `Region` text,
  `Inventory Level` int DEFAULT NULL,
  `Units Sold` int DEFAULT NULL,
  `Units Ordered` int DEFAULT NULL,
  `Demand Forecast` double DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `Discount` int DEFAULT NULL,
  `Weather Condition` text,
  `Holiday/Promotion` int DEFAULT NULL,
  `Competitor Pricing` double DEFAULT NULL,
  `Seasonality` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO inventory_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Date`, `Store ID`, `Product ID`, Category, Region, `Inventory Level`, `Units Sold`, `Units Ordered`, `Demand Forecast`, Price, Discount, `Weather Condition`, `Holiday/Promotion`, `Competitor Pricing`, Seasonality ) AS row_num
FROM inventory_staging;

SELECT *
FROM inventory_staging2
WHERE row_num>1; 

-- SINCE THERE ARE NO ROW NUMBERS GREATER THAN 1, WE CONCLUDE THAT THERE ARE NO DUPLICATE VALUES

SELECT COUNT(*)
FROM inventory_staging2
WHERE row_num=1;

-- STANDARDISING THE DATA

SELECT DISTINCT Category
FROM inventory_staging2
ORDER BY 1;

-- NO STANDARDISATION NEEDED IN THE CATEGORIES COLUMN

SELECT DISTINCT Region
FROM inventory_staging2
ORDER BY 1;

-- NO STANDARDISATION NEEDED IN THE REGION COLUMN

SELECT DISTINCT `Weather Condition`
FROM inventory_staging2
ORDER BY 1;

-- NO STANDARDISATION NEEDED IN THE WEATHER CONDITION COLUMN

SELECT DISTINCT Seasonality
FROM inventory_staging2
ORDER BY 1;

-- NO STANDARDISATION NEEDED IN THE WEATHER CONDITION COLUMN

-- CHECKING FOR NULL VALUES 

SELECT *
FROM inventory_staging2
WHERE `Date` IS NULL
OR `Date`='';

SELECT *
FROM inventory_staging2
WHERE `Store ID` IS NULL
OR `Store ID`='';

SELECT *
FROM inventory_staging2
WHERE `Product ID` IS NULL
OR `Product ID`='';

SELECT *
FROM inventory_staging2
WHERE `Category` IS NULL
OR `Category`='';

SELECT *
FROM inventory_staging2
WHERE `Region` IS NULL
OR `Region`='';

SELECT *
FROM inventory_staging2
WHERE `Inventory Level` IS NULL
OR `Inventory Level`='';

SELECT *
FROM inventory_staging2
WHERE `Units Sold` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Units Ordered` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Demand Forecast` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Price` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Discount` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Weather Condition` IS NULL
OR `Weather Condition`='';

SELECT *
FROM inventory_staging2
WHERE `Holiday/Promotion` IS NULL;

SELECT *
FROM inventory_staging2
WHERE `Competitor Pricing` IS NULL
OR `Competitor Pricing`='';

SELECT *
FROM inventory_staging2
WHERE `Seasonality` IS NULL
OR `Seasonality`='';

-- AS CAN BE SEEN, THERE ARE NO ENTRIES WITH NULL VALUES

-- CONVERTING DATE COLUMN TO DATETIME FORMAT
SELECT `Date`,
STR_TO_DATE(`Date`, '%Y-%m-%d') AS Parsed_Date
FROM inventory_staging2;

UPDATE inventory_staging2
SET `Date` = STR_TO_DATE(`Date`, '%Y-%m-%d');


SELECT COUNT(*)
FROM inventory_staging2;

ALTER TABLE inventory_staging2
DROP COLUMN row_num;















