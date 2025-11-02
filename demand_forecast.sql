-- CHECKING FORECAST ERROR TRENDS ACROSS IN GENERAL
SELECT `Date`, `Store ID`, `Region`, `Product ID`, `Seasonality`, `Units Sold`, `Demand Forecast`, ROUND(`Units Sold`-`Demand Forecast`,2) AS `Error in Forecasting`, ROUND(ABS((`Units Sold`-`Demand Forecast`))*100/`Demand Forecast`,2) AS `Percent Error in Forecasting`
FROM inventory_forecasting;

-- CHECKING FORECAST ERROR TRENDS ACROSS STORES AND SEASONS FOR A PARTICULAR PRODUCT
SELECT `Store ID`, `Region`, `Product ID`, `Seasonality`, SUM(`Units Sold`) AS `Total Sales`, ROUND(SUM(`Demand Forecast`),2) AS `Total Demand`, ROUND(SUM(`Units Sold`-`Demand Forecast`),2) AS `Total Error in Forecasting `
FROM inventory_forecasting
GROUP BY `Store ID`, `Region`, `Product ID`, `Seasonality`
ORDER BY `Store ID`,`Seasonality`, `Product ID`, `Region`;

