SELECT *
FROM inventory_staging2;

SELECT `Date`, `Store ID`, `Product ID`, `Region`
FROM inventory_staging2
GROUP BY `Store ID`, `Product ID`, `Region`, `Date`
ORDER BY 1 ASC;

SELECT `Date`, `Store ID`, `Product ID`, `Region`
FROM inventory_staging2
GROUP BY `Store ID`, `Product ID`, `Region`, `Date`
HAVING `Product ID`='P0096'
ORDER BY 1 ASC;

SELECT `Date`, `Store ID`, `Product ID`, `Region`
FROM inventory_staging2
GROUP BY `Store ID`, `Product ID`, `Region`, `Date`
HAVING `Product ID`='P0096' AND `Store ID`='S001'
ORDER BY 1 ASC;


SELECT `Date`, `Store ID`, `Product ID`, `Region`
FROM inventory_staging2
GROUP BY `Store ID`, `Product ID`, `Region`, `Date`
HAVING `Product ID`='P0096' AND `Store ID`='S001' AND `Region`='West'
ORDER BY 1 ASC;

-- IT CAN BE SEEN THAT FOR THE PRODUCT 'P0096' AND STORE 'S001' DISTRIBUTED ACROSS REGIONS, THE ENTRIES ARE IRREGULAR. FOR EXAMPLE, FOR PRODUCT 'P0096' 
-- IN STORE 'S001' IN THE WEST REGION, WE HAVE AN ENTRY ON 01-01-2022, THE NEXT ENTRY IS ON 07-01-2022 AND FURTHER ENTRIES ARE ON 08-01-2022, 09-01-2022 AND 18-01-2022.

-- THE REASON FOR THIS COULD BE EITHER THAT THE STORE WAS NON-OPERATIONAL, NO SALES WERE MADE OR SIMPLY THAT THE DATA WAS NOT RECORDED/AVAILABLE
-- ANALYSING FOR THE ABOVE REASONS

SELECT `Date`, `Store ID`, `Region`
FROM inventory_staging2
GROUP BY `Store ID`, `Region`, `Date`
HAVING `Store ID`='S001' AND `Region`='West'
ORDER BY 1 ASC;

-- THE DATA SHOWS THAT THE STORE IS OPERATIONAL ON ALMOST ALL THE DAYS

-- CHECKING IF OTHER PRODUCTS ARE LISTED ON MISSING DATES AND IF SALES WERE RECORDED

SELECT `Date`, `Store ID`, `Product ID`, `Region`, `Units Sold`
FROM inventory_staging2
GROUP BY `Store ID`, `Region`, `Date`, `Product ID`, `Units Sold`
HAVING `Store ID`='S001' AND `Region`='West'
ORDER BY 1 ASC;

-- SINCE OTHER PRODUCTS ARE STILL LISTED ALONG WITH THEIR UNITS SOLD, WE MAY BE LEAD TO ASSUME THAT NO SALES WERE MADE ON A PARTICULAR DATE FOR A PRODUCT IF IT HAS 
-- NOT BEEN LISTEN IN THE DATASET.

-- BUT TO STILL VERIFY THIS ASSUMPTION, WE NEED TO CHECK THE INVENTORY CALCULATIONS

 SELECT `Date`, `Store ID`, `Product ID`, `Region`, `Inventory Level`, `Units Ordered`, `Units Sold`
FROM inventory_staging2
GROUP BY `Store ID`, `Region`, `Date`, `Inventory Level`, `Units Ordered`, `Product ID`, `Units Sold`
HAVING `Product ID`='P0096' AND `Store ID`='S001' AND `Region`='West'
ORDER BY 1 ASC;

-- ASSUMING INVENTORY LEVEL IS RECORDED AT THE END OF THE DAY, AND THE DATA IS RECORDED ONLY WHEN SALES ARE MADE

 SELECT `Date`, `Store ID`, `Product ID`, `Region`, `Inventory Level`, `Units Ordered`, `Units Sold`, LAG(`Inventory Level`) OVER (ORDER BY `Date`) + `Units Ordered` - `Units Sold` AS `Ideal Inventory Level`
FROM inventory_staging2
GROUP BY `Store ID`, `Region`, `Date`, `Inventory Level`, `Units Ordered`, `Product ID`, `Units Sold`
HAVING `Product ID`='P0096' AND `Store ID`='S001' AND `Region`='West'
ORDER BY 1 ASC;

-- FROM THE DATA, IT'S CLEAR THAT THE IDEAL INVENTORY LEVEL DOESN'T MATCH UP WITH THE CURRENT INVENTORY LEVEL, DENOTING THAT THERE IS MISSING DATA IN THE DATASET ON THE DATES
-- WHERE NO SALE IS RECORDED.


-- WE NEED TO IMPUTE MISSING DATA

SELECT MIN(`Date`), MAX(`Date`)
FROM inventory_staging2;


-- CREATING A NEW TABLE CALENDAR, WITH ALL POSSIBLE DATES IN THE RANGE BETWEEN MIN AND MAX

CREATE TABLE calendar (
  cal_date DATE PRIMARY KEY
);

INSERT INTO calendar (cal_date)
WITH RECURSIVE dates AS (
  SELECT DATE('2022-01-01') AS cal_date
  UNION ALL
  SELECT DATE_ADD(cal_date, INTERVAL 1 DAY)
  FROM dates
  WHERE cal_date < '2023-12-31'
)
SELECT cal_date FROM dates;

SELECT *
FROM calendar;

-- CHECKING FOR ALL POSSIBLE COMBINATIONS OF STORE, PRODUCT AND REGION

WITH store_product_region AS (
  SELECT DISTINCT `Store ID`, `Product ID`, `Region`
  FROM inventory_staging2
),
calendar_dates AS (
  SELECT cal_date
  FROM calendar
  WHERE cal_date BETWEEN '2022-01-01' AND '2023-12-31'
),
all_combinations AS (
  SELECT 
    c.cal_date,
    spr.`Store ID`,
    spr.`Product ID`,
    spr.`Region`
  FROM calendar_dates c
  CROSS JOIN store_product_region spr
)
SELECT
  ac.cal_date,
  ac.`Store ID`,
  ac.`Product ID`,
  ac.`Region`,
  inv.`Inventory Level`,
  inv.`Units Sold`,
  inv.`Units Ordered`
FROM all_combinations ac
LEFT JOIN inventory_staging2 inv
  ON ac.cal_date = inv.`Date`
  AND ac.`Store ID` = inv.`Store ID`
  AND ac.`Product ID` = inv.`Product ID`
  AND ac.`Region` = inv.`Region`
ORDER BY ac.cal_date, ac.`Store ID`, ac.`Product ID`, ac.`Region`;



SELECT *
FROM inventory_staging2
WHERE `Product ID`='P0016' AND `Store ID`='S001';



-- CREATING A NEW TABLE WITH ALL POSSIBLE COMBINATIONS, AND THE DATA AS NULL FOR MISSING DATES

CREATE TABLE `corrected_inventory` (
  `Date` date,
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
  `Seasonality` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO corrected_inventory (
  `Date`,
  `Store ID`,
  `Product ID`,
  `Category`,
  `Region`,
  `Inventory Level`,
  `Units Sold`,
  `Units Ordered`,
  `Demand Forecast`,
  `Price`,
  `Discount`,
  `Weather Condition`,
  `Holiday/Promotion`,
  `Competitor Pricing`,
  `Seasonality`
)
WITH store_product_region AS (
  SELECT DISTINCT `Store ID`, `Product ID`, `Region`
  FROM inventory_staging2
),
calendar_dates AS (
  SELECT cal_date
  FROM calendar
  WHERE cal_date BETWEEN '2022-01-01' AND '2023-12-31'
),
product_category AS (
  SELECT `Product ID`, MAX(`Category`) AS `Category`
  FROM inventory_staging2
  WHERE `Category` IS NOT NULL
  GROUP BY `Product ID`
),
all_combinations AS (
  SELECT 
    c.cal_date,
    spr.`Store ID`,
    spr.`Product ID`,
    spr.`Region`
  FROM calendar_dates c
  CROSS JOIN store_product_region spr
),
final_data AS (
  SELECT
    CAST(ac.cal_date AS DATETIME) AS `Date`,
    ac.`Store ID`,
    ac.`Product ID`,
    pc.`Category`,
    ac.`Region`,
    inv.`Inventory Level`,
    inv.`Units Sold`,
    inv.`Units Ordered`,
    inv.`Demand Forecast`,
    inv.`Price`,
    inv.`Discount`,
    inv.`Weather Condition`,
    inv.`Holiday/Promotion`,
    inv.`Competitor Pricing`,
    inv.`Seasonality`
  FROM all_combinations ac
  LEFT JOIN inventory_staging2 inv
    ON ac.cal_date = inv.`Date`
    AND ac.`Store ID` = inv.`Store ID`
    AND ac.`Product ID` = inv.`Product ID`
    AND ac.`Region` = inv.`Region`
  LEFT JOIN product_category pc
    ON ac.`Product ID` = pc.`Product ID`
)
SELECT * FROM final_data;


SELECT *
FROM corrected_inventory
ORDER BY `Date` ASC, `Store ID`, `Product ID`, `Region`;
















