DROP TABLE IF EXISTS average_stay;
CREATE TABLE average_stay
SELECT `Unique Store`, `Product ID`, COUNT(*) AS `Cumulative Number of Days`, `Seasonality`, SUM(`Units Ordered`) AS `Total Units Ordered`, COUNT(*)/SUM(`Units Ordered`) AS `Average Stay`
FROM corrected_inventory
GROUP BY `Unique Store`, `Product ID`, `Seasonality`
ORDER BY `Unique Store`;

SELECT *
FROM average_stay
ORDER BY `Unique Store`, `Seasonality`, `Product ID`;


-- CALCULATING CUMULATIVE AVERAGE STAY
DROP TABLE IF EXISTS comparison;
CREATE TABLE comparison
SELECT 
  ref.`Unique Store`,
  ref.`Seasonality`,
  ref.`Product ID` AS `Reference Product`,
  ref.`Average Stay` AS `Reference Stay`,
  other.`Product ID` AS `Compared Product`,
  other.`Average Stay` AS `Compared Stay`
FROM average_stay AS ref
JOIN average_stay AS other
ON ref.`Unique Store` = other.`Unique Store`
AND ref.`Seasonality` = other.`Seasonality`
WHERE other.`Average Stay` >= ref.`Average Stay`
ORDER BY ref.`Unique Store`, ref.`Seasonality`, ref.`Product ID`, other.`Product ID`;

SELECT *
FROM comparison;

SELECT `Unique Store`, `Seasonality`, `Reference Product`, SUM(`Compared Stay`) AS `Cumulative Average Stay`
FROM comparison
GROUP BY `Unique Store`, `Seasonality`, `Reference Product`;


-- CALCULATING CUMULATIVE CONSUMPTION RATE

DROP TABLE IF EXISTS comparison2;
CREATE TABLE comparison2
SELECT 
  ref.`Unique Store`,
  ref.`Seasonality`,
  ref.`Product ID` AS `Reference Product`,
  ref.`Average Daily Use` AS `Reference Consumption Rate`,
  other.`Product ID` AS `Compared Product`,
  other.`Average Daily Use` AS `Compared Consumption Rate`
FROM average_daily_usage AS ref
JOIN average_daily_usage AS other
ON ref.`Unique Store` = other.`Unique Store`
AND ref.`Seasonality` = other.`Seasonality`
WHERE other.`Average Daily Use` >= ref.`Average Daily Use`
ORDER BY ref.`Unique Store`, ref.`Seasonality`, ref.`Product ID`, other.`Product ID`;

SELECT *
FROM comparison2;

SELECT `Unique Store`, `Seasonality`, `Reference Product`, SUM(`Compared Consumption Rate`) AS `Cumulative Cosnumption Rate`
FROM comparison2
GROUP BY `Unique Store`, `Seasonality`, `Reference Product`;


-- COMBINING BOTH THE CUMULATIVES

CREATE TABLE cumulatives
SELECT c1.`Unique Store`, c1.`Seasonality`, c1.`Reference Product`, c1.`Cumulative Average Stay`, c2.`Cumulative Consumption Rate`
FROM (
SELECT `Unique Store`, `Seasonality`, `Reference Product`, SUM(`Compared Stay`) AS `Cumulative Average Stay`
FROM comparison
GROUP BY `Unique Store`, `Seasonality`, `Reference Product`) AS c1
JOIN (
SELECT `Unique Store`, `Seasonality`, `Reference Product`, SUM(`Compared Consumption Rate`) AS `Cumulative Consumption Rate`
FROM comparison2
GROUP BY `Unique Store`, `Seasonality`, `Reference Product`) AS c2
ON c1.`Unique Store`=c2.`Unique Store` AND c1.`Seasonality`=c2.`Seasonality` AND c1.`Reference Product`=c2.`Reference Product`
ORDER BY c1.`Unique Store`, c1.`Seasonality`, c1.`Reference Product`;

SELECT *
FROM cumulatives;

-- CALCULATING PERCENTAGE CUMULATIVES

CREATE TABLE percent_cumulatives
SELECT a1.`Unique Store`, a1.`Seasonality`, a1.`Reference Product`, a1.`Cumulative Average Stay`, a1.`Cumulative Consumption Rate`, a1.`Cumulative Average Stay`*100/a2.`Total Cumulative Average Stay` AS `Percentage Cumulative Average Stay`, a1.`Cumulative Consumption Rate`*100/a2.`Total Cumulative Consumption Rate` AS `Percentage Cumulative Consumption Rate`
FROM cumulatives AS a1
JOIN (
SELECT `Unique Store`, `Seasonality`, SUM(`Cumulative Average Stay`) AS `Total Cumulative Average Stay`, SUM(`Cumulative Consumption Rate`) AS `Total Cumulative Consumption Rate`
FROM cumulatives
GROUP BY `Unique Store`, `Seasonality`
) AS a2
ON a1.`Unique Store`=a2.`Unique Store` AND a1.`Seasonality`=a2.`Seasonality`
ORDER BY a1.`Unique Store`, a1.`Seasonality`, a1.`Reference Product`;

SELECT *
FROM percent_cumulatives;

-- RANKING THE PRODUCTS BASED ON CONSUMPTION RATE

CREATE TABLE rank_by_cons
WITH `Ranking` AS (
  SELECT
    `Unique Store`,
    `Seasonality`,
    `Reference Product`,
    `Percentage Cumulative Consumption Rate`,
    ROW_NUMBER() OVER (
      PARTITION BY `Unique Store`, `Seasonality` 
      ORDER BY `Percentage Cumulative Consumption Rate` DESC
    ) AS `Ranking`
  FROM percent_cumulatives
)
SELECT 
  `Unique Store`, 
  `Seasonality`, 
  `Reference Product`, 
  `Percentage Cumulative Consumption Rate`, 
  `Ranking`,
  CASE 
    WHEN `Ranking` >= 1 AND `Ranking` <= 21 THEN 'F'
    WHEN `Ranking` > 21 AND `Ranking` <= 27 THEN 'S'
    WHEN `Ranking` > 27 AND `Ranking` <= 30 THEN 'N'
  END AS `Inventory Tags 1`
FROM `Ranking`
ORDER BY `Unique Store`, `Seasonality`, `Ranking`, `Reference Product`;

-- RANKING THE PRODUCTS BASED ON THEIR AVERAGE STAY

CREATE TABLE rank_by_stay
WITH `Ranking2` AS (
  SELECT
    `Unique Store`,
    `Seasonality`,
    `Reference Product`,
    `Percentage Cumulative Average Stay`,
    ROW_NUMBER() OVER (
      PARTITION BY `Unique Store`, `Seasonality` 
      ORDER BY `Percentage Cumulative Average Stay` DESC
    ) AS `Ranking`
  FROM percent_cumulatives
)
SELECT 
  `Unique Store`, 
  `Seasonality`, 
  `Reference Product`, 
  `Percentage Cumulative Average Stay`, 
  `Ranking`,
  CASE 
    WHEN `Ranking` >= 1 AND `Ranking` <= 21 THEN 'N'
    WHEN `Ranking` > 21 AND `Ranking` <= 27 THEN 'S'
    WHEN `Ranking` > 27 AND `Ranking` <= 30 THEN 'F'
  END AS `Inventory Tags 2`
FROM `Ranking2`
ORDER BY `Unique Store`, `Seasonality`, `Ranking`, `Reference Product`;


SELECT *
FROM rank_by_cons;

SELECT *
FROM rank_by_stay;

SELECT r1.*, r2.*
FROM rank_by_cons AS r1
JOIN rank_by_stay AS r2
ON r1.`Unique Store`=r2.`Unique Store` AND r1.`Seasonality`=r2.`Seasonality` AND r1.`Reference Product`=r2.`Reference Product`
ORDER BY r1.`Unique Store`, r1.`Seasonality`, r1.`Reference Product`;

-- FINAL RANKING OF PRODUCTS 

DROP TABLE IF EXISTS final_tag;
CREATE TABLE final_tag
SELECT r1.`Unique Store`, r1.`Seasonality`, r1.`Reference Product`, r1.`Inventory Tags 1`, r2.`Inventory Tags 2`,
CASE
WHEN `Inventory Tags 1`='F' AND `Inventory Tags 2`='F' THEN 'F'
WHEN `Inventory Tags 1`='F' AND `Inventory Tags 2`='S' THEN 'F'
WHEN `Inventory Tags 1`='F' AND `Inventory Tags 2`='N' THEN 'S'
WHEN `Inventory Tags 1`='S' AND `Inventory Tags 2`='F' THEN 'S'
WHEN `Inventory Tags 1`='S' AND `Inventory Tags 2`='S' THEN 'S'
WHEN `Inventory Tags 1`='S' AND `Inventory Tags 2`='N' THEN 'N'
WHEN `Inventory Tags 1`='S' AND `Inventory Tags 2`='N' THEN 'N'
WHEN `Inventory Tags 1`='N' AND `Inventory Tags 2`='F' THEN 'N'
WHEN `Inventory Tags 1`='N' AND `Inventory Tags 2`='N' THEN 'N'
END AS `Final Inventory Tag`
FROM rank_by_cons AS r1
JOIN rank_by_stay AS r2
ON r1.`Unique Store`=r2.`Unique Store` AND r1.`Seasonality`=r2.`Seasonality` AND r1.`Reference Product`=r2.`Reference Product`
ORDER BY r1.`Unique Store`, r1.`Seasonality`, `Final Inventory Tag`;

SELECT *
FROM final_tag;