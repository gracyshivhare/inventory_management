SELECT `Unique Store`, `Seasonality`, `Reference Product`, `Final Inventory Tag`
FROM final_tag
WHERE `Reference Product`='P0016' AND `Seasonality`='Autumn';

-- SINCE URBAN RETAIL WAREHOUSES SERVE A PARTICULAR REGION, WE ARE RECOMMENDING STOCK ADUSTMENTS BY STORE IDs AND NOT UNIQUE STORE IDs. ALSO, FOR SIMPLICATION
-- WE ARE CONSIDERING PRODUCTS IN CATEGORIES.

SELECT 
SUBSTRING_INDEX(`Unique Store`, ' ', 1) AS `Store ID`,
SUBSTRING_INDEX(`Unique Store`, ' ', -1) AS `Region`
FROM final_tag;

ALTER TABLE final_tag
ADD `Store ID` varchar(255);


UPDATE final_tag
SET `Store ID` = SUBSTRING_INDEX(`Unique Store`, ' ', 1);

SELECT *
FROM final_tag;

SELECT DISTINCT `Product ID`, `Category`
FROM inventory_forecasting
ORDER BY `Category`;

-- FOR CLOTHING PRODUCTS

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0016', 'P0046', 'P0057', 'P0061', 'P0066', 'P0069', 'P0125', 'P0126', 'P0133', 'P0178', 'P0187') AND `Seasonality`='Autumn'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0016', 'P0046', 'P0057', 'P0061', 'P0066', 'P0069', 'P0125', 'P0126', 'P0133', 'P0178', 'P0187') AND `Seasonality`='Spring'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0016', 'P0046', 'P0057', 'P0061', 'P0066', 'P0069', 'P0125', 'P0126', 'P0133', 'P0178', 'P0187') AND `Seasonality`='Summer'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;


-- FOR TOYS

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0017', 'P0083', 'P0096') AND `Seasonality`='Autumn'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0017', 'P0083', 'P0096') AND `Seasonality`='Winter'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0017', 'P0083', 'P0096') AND `Seasonality`='Spring'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0017', 'P0083', 'P0096') AND `Seasonality`='Summer'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

-- FOR GROCERIES

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0094', 'P0166') AND `Seasonality`='Autumn'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0094', 'P0166') AND `Seasonality`='Winter'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0094', 'P0166') AND `Seasonality`='Spring'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0094', 'P0166') AND `Seasonality`='Summer'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

-- FOR FURNITURE

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0067', 'P0079', 'P0116', 'P0129', 'P0149', 'P0153') AND `Seasonality`='Autumn'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0067', 'P0079', 'P0116', 'P0129', 'P0149', 'P0153') AND `Seasonality`='Winter'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0067', 'P0079', 'P0116', 'P0129', 'P0149', 'P0153') AND `Seasonality`='Spring'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0067', 'P0079', 'P0116', 'P0129', 'P0149', 'P0153') AND `Seasonality`='Summer'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

-- FOR ELECTRONICS

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0031', 'P0068', 'P0070', 'P0085', 'P0159', 'P0171', 'P0175', 'P0183') AND `Seasonality`='Autumn'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0031', 'P0068', 'P0070', 'P0085', 'P0159', 'P0171', 'P0175', 'P0183') AND `Seasonality`='Winter'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0031', 'P0068', 'P0070', 'P0085', 'P0159', 'P0171', 'P0175', 'P0183') AND `Seasonality`='Spring'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;

SELECT `Store ID`, `Seasonality`, `Final Inventory Tag`, COUNT(*)
FROM final_tag
WHERE `Reference Product` IN ('P0031', 'P0068', 'P0070', 'P0085', 'P0159', 'P0171', 'P0175', 'P0183') AND `Seasonality`='Summer'
GROUP BY `Store ID`, `Seasonality`, `Final Inventory Tag`;