# Inventory Management System

<<<<<<< HEAD
A comprehensive SQL-based inventory management and analytics system that provides data-driven insights for retail operations. This system analyzes inventory levels, demand patterns, supplier performance, and product categorization to optimize stock management across multiple stores and regions.

## 📋 Table of Contents

- [Overview](#overview)
- [System Architecture](#system-architecture)
- [Data Flow](#data-flow)
- [Key Features](#key-features)
- [Database Schema](#database-schema)
- [Analysis Modules](#analysis-modules)
- [Getting Started](#getting-started)
- [Usage Examples](#usage-examples)
=======
A **comprehensive SQL-based inventory management and analytics system** that provides **data-driven insights** for retail operations.  
This system analyzes **inventory levels, demand patterns, supplier performance, and product categorization** to optimize stock management across multiple stores and regions.

---

## 📋 Table of Contents
- [Overview](#-overview)
- [System Architecture](#-system-architecture)
- [Data Flow](#-data-flow)
- [Key Features](#-key-features)
- [Database Schema](#-database-schema)
- [Analysis Modules](#-analysis-modules)
- [Getting Started](#-getting-started)
- [Usage Examples](#-usage-examples)

---
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

## 🎯 Overview

This inventory management system processes retail data to provide actionable insights for:
<<<<<<< HEAD
- **Inventory Optimization**: Calculate optimal stock levels and reorder points
- **Demand Forecasting**: Analyze forecast accuracy and trends
- **Product Classification**: Categorize products as Fast/Slow/Normal moving
- **Supplier Performance**: Monitor supplier reliability and consistency
- **Stock Analysis**: Track inventory turnover and identify low stock situations
=======

- **Inventory Optimization** – Calculate optimal stock levels and reorder points  
- **Demand Forecasting** – Analyze forecast accuracy and trends  
- **Product Classification** – Categorize products as *Fast*, *Slow*, or *Normal* moving  
- **Supplier Performance** – Monitor supplier reliability and consistency  
- **Stock Analysis** – Track inventory turnover and identify low stock situations  

---
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

## 🏗️ System Architecture

The system follows a structured data processing pipeline:

<<<<<<< HEAD
```
Raw Data → Data Cleaning → Data Correction → Analysis → Insights
```

### Core Components:
1. **Data Ingestion & Cleaning** (`data_cleaning.sql`)
2. **Data Correction & Forward Filling** (`forward_filling.sql`, `product_analysis.sql`)
3. **Inventory Analytics** (Multiple analysis modules)
4. **Reporting & Insights** (Aggregated results)
=======

### Core Components
- **Data Ingestion & Cleaning:** `data_cleaning.sql`
- **Data Correction & Forward Filling:** `forward_filling.sql`, `product_analysis.sql`
- **Inventory Analytics:** Multiple analysis modules
- **Reporting & Insights:** Aggregated results and dashboards

---
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

## 🔄 Data Flow

### 1. Data Preparation Phase
<<<<<<< HEAD
- **Input**: Raw inventory data from `inventory_forecasting` table
- **Process**: Remove duplicates, standardize formats, handle missing values
- **Output**: Clean dataset in `inventory_staging2` table

### 2. Data Correction Phase
- **Gap Analysis**: Identify missing dates in inventory records
- **Forward Filling**: Fill missing inventory data using carry-forward logic
- **Validation**: Ensure data consistency across stores and products
- **Output**: Complete dataset in `corrected_inventory_zeroed` table
=======
- **Input:** Raw inventory data from `inventory_forecasting` table  
- **Process:** Remove duplicates, standardize formats, handle missing values  
- **Output:** Clean dataset in `inventory_staging2` table  

### 2. Data Correction Phase
- **Gap Analysis:** Identify missing dates in inventory records  
- **Forward Filling:** Fill missing inventory data using carry-forward logic  
- **Validation:** Ensure data consistency across stores and products  
- **Output:** Complete dataset in `corrected_inventory_zeroed` table  
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

### 3. Analysis Phase
Multiple parallel analysis streams process the corrected data:

#### A. Reorder Point Calculation (`ROP_estimation.sql`)
<<<<<<< HEAD
- Calculate average daily usage per product/store/season
- Determine lead times based on inventory restocking patterns
- Compute Reorder Points (ROP) = Average Daily Usage × Lead Time

#### B. Inventory Classification (`fast_vs_slow.sql`)
- Analyze product consumption rates and inventory stay duration
- Rank products using cumulative percentage analysis
- Classify products as Fast (F), Slow (S), or Normal (N) moving

#### C. Performance Monitoring
- **Inventory Turnover** (`inventory_turnover.sql`): Calculate quarterly turnover ratios
- **Low Stock Detection** (`low_stock.sql`): Compare current levels against ROP
- **Supplier Analysis** (`supplier_inconsistency.sql`): Identify supply chain issues

#### D. Demand Analysis (`demand_forecast.sql`)
- Compare actual sales vs. forecasted demand
- Calculate forecast accuracy and error percentages
- Identify trends across stores, seasons, and products
=======
- Calculate average daily usage per product/store/season  
- Determine lead times based on inventory restocking patterns  
- Compute **Reorder Points (ROP)** = `Average Daily Usage × Lead Time`

#### B. Inventory Classification (`fast_vs_slow.sql`)
- Analyze product consumption rates and inventory stay duration  
- Rank products using cumulative percentage analysis  
- Classify products as **Fast (F)**, **Slow (S)**, or **Normal (N)** moving  

#### C. Performance Monitoring
- **Inventory Turnover:** `inventory_turnover.sql` – Quarterly turnover ratios  
- **Low Stock Detection:** `low_stock.sql` – Compare current levels against ROP  
- **Supplier Analysis:** `supplier_inconsistency.sql` – Identify supply chain issues  

#### D. Demand Analysis (`demand_forecast.sql`)
- Compare actual sales vs. forecasted demand  
- Calculate forecast accuracy and error percentages  
- Identify trends across stores, seasons, and products  

---
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

## 🎯 Key Features

### 📊 Inventory Analytics
<<<<<<< HEAD
- **Turnover Ratios**: Quarterly analysis of inventory efficiency
- **Stock Levels**: Real-time monitoring across multiple dimensions
- **Reorder Points**: Automated calculation based on historical data
- **Low Stock Alerts**: Proactive identification of understocked items

### 🏷️ Product Classification
- **ABC Analysis**: Fast/Slow/Normal moving product categorization
- **Seasonal Patterns**: Season-specific product performance analysis
- **Multi-dimensional Ranking**: Based on consumption rate and inventory duration

### 📈 Performance Monitoring
- **Supplier Reliability**: Track supplier performance and consistency
- **Forecast Accuracy**: Monitor demand prediction effectiveness
- **Regional Analysis**: Compare performance across different regions

### 🔍 Business Intelligence
- **Trend Analysis**: Historical patterns and seasonal variations
- **Cross-dimensional Insights**: Store, region, product, and time-based analytics
- **Decision Support**: Data-driven recommendations for inventory management

## 🗄️ Database Schema

### Primary Tables:
- `inventory_forecasting`: Raw input data
- `inventory_staging2`: Cleaned and standardized data
- `corrected_inventory_zeroed`: Complete dataset with filled gaps
- `lead_time_demand`: ROP calculations and lead time analysis
- `final_tag`: Product classification results

### Key Fields:
- **Temporal**: Date, Seasonality
- **Location**: Store ID, Region, Unique Store
- **Product**: Product ID, Category
- **Inventory**: Inventory Level, Units Sold, Units Ordered
- **Business**: Demand Forecast, Price, Discount, Weather Condition
=======
- Turnover Ratios – Quarterly efficiency tracking  
- Stock Levels – Real-time multi-dimensional monitoring  
- Reorder Points – Automated calculation from historical data  
- Low Stock Alerts – Proactive understock detection  

### 🏷️ Product Classification
- ABC Analysis – Fast/Slow/Normal categorization  
- Seasonal Patterns – Season-specific product performance  
- Multi-dimensional Ranking – Based on usage rate & stay duration  

### 📈 Performance Monitoring
- Supplier Reliability – Monitor supplier consistency  
- Forecast Accuracy – Track demand prediction quality  
- Regional Analysis – Compare performance across regions  

### 🔍 Business Intelligence
- Trend Analysis – Identify seasonal variations  
- Cross-dimensional Insights – By store, region, product, and time  
- Decision Support – Data-driven recommendations for optimization  

---

## 🗄️ Database Schema

### Primary Tables
| Table Name | Description |
|-------------|-------------|
| `inventory_forecasting` | Raw input data |
| `inventory_staging2` | Cleaned and standardized data |
| `corrected_inventory_zeroed` | Complete dataset with filled gaps |
| `lead_time_demand` | ROP calculations and lead time analysis |
| `final_tag` | Product classification results |

### Key Fields
- **Temporal:** `Date`, `Seasonality`  
- **Location:** `Store ID`, `Region`, `Unique Store`  
- **Product:** `Product ID`, `Category`  
- **Inventory:** `Inventory Level`, `Units Sold`, `Units Ordered`  
- **Business:** `Demand Forecast`, `Price`, `Discount`, `Weather Condition`  

---
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb

## 📁 Analysis Modules

| Module | Purpose | Key Outputs |
<<<<<<< HEAD
|--------|---------|-------------|
| `data_cleaning.sql` | Data preparation and validation | Clean, standardized dataset |
| `product_analysis.sql` | Gap analysis and data structure | Complete inventory timeline |
| `forward_filling.sql` | Missing data interpolation | Filled inventory records |
| `ROP_estimation.sql` | Reorder point calculation | Optimal reorder levels |
| `fast_vs_slow.sql` | Product classification | F/S/N product categories |
| `inventory_turnover.sql` | Efficiency analysis | Quarterly turnover ratios |
| `low_stock.sql` | Stock monitoring | Low stock alerts |
| `demand_forecast.sql` | Forecast accuracy | Prediction performance metrics |
| `supplier_inconsistency.sql` | Supplier performance | Supply chain reliability |
| `total_product_stock.sql` | Stock aggregation | Multi-dimensional stock views |
| `stock_adjustments.sql` | Inventory optimization | Stock adjustment recommendations |

## 🚀 Getting Started

### Prerequisites
- MySQL/MariaDB database server
- Access to inventory forecasting data
- Basic SQL knowledge for customization

### Setup Instructions
1. **Import Data**: Load your inventory data into the `inventory_forecasting` table
2. **Run Data Cleaning**: Execute `data_cleaning.sql` to prepare the dataset
3. **Perform Analysis**: Run `product_analysis.sql` and `forward_filling.sql` for data correction
4. **Execute Analytics**: Run individual analysis modules based on your requirements
5. **Generate Reports**: Query the resulting tables for insights and reports

## 💡 Usage Examples

### Calculate Reorder Points
```sql
-- Get ROP for all products in a specific store and season
SELECT * FROM lead_time_demand
WHERE `Unique Store` = 'S001 North' AND `Seasonality` = 'Winter';
```

### Identify Fast-Moving Products
```sql
-- Find fast-moving products for inventory prioritization
=======
|--------|----------|-------------|
| `data_cleaning.sql` | Data preparation and validation | Clean, standardized dataset |
| `product_analysis.sql` | Gap analysis and structure check | Complete inventory timeline |
| `forward_filling.sql` | Missing data interpolation | Filled inventory records |
| `ROP_estimation.sql` | Reorder point calculation | Optimal reorder levels |
| `fast_vs_slow.sql` | Product classification | F/S/N categories |
| `inventory_turnover.sql` | Efficiency analysis | Quarterly turnover ratios |
| `low_stock.sql` | Stock monitoring | Low stock alerts |
| `demand_forecast.sql` | Forecast accuracy check | Prediction metrics |
| `supplier_inconsistency.sql` | Supplier performance | Supply chain reliability |
| `total_product_stock.sql` | Stock aggregation | Multi-dimensional stock view |
| `stock_adjustments.sql` | Inventory optimization | Stock adjustment recommendations |

---

## 🚀 Getting Started

### Prerequisites
- MySQL / MariaDB database server  
- Access to inventory forecasting data  
- Basic SQL knowledge for customization  

### Setup Instructions
1. **Import Data:** Load inventory data into the `inventory_forecasting` table  
2. **Run Data Cleaning:** Execute `data_cleaning.sql` to prepare the dataset  
3. **Perform Data Correction:** Run `product_analysis.sql` and `forward_filling.sql`  
4. **Execute Analytics:** Run analysis modules based on requirements  
5. **Generate Reports:** Query resulting tables for insights and reports  

---

```markdown
## 💡 Usage Examples

### 🔹 Calculate Reorder Points
```sql
SELECT * FROM lead_time_demand
WHERE `Unique Store` = 'S001 North'
  AND `Seasonality` = 'Winter';
```

### 🔹 Identify Fast-Moving Products
```sql
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb
SELECT * FROM final_tag
WHERE `Final Inventory Tag` = 'F'
ORDER BY `Unique Store`, `Seasonality`;
```

<<<<<<< HEAD
### Monitor Low Stock Situations
```sql
-- Get current low stock alerts
=======
### 🔹 Monitor Low Stock Situations
```sql
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb
SELECT * FROM low_inventory
WHERE `Inventory Status` = 'Low Inventory Detected';
```

<<<<<<< HEAD
### Analyze Supplier Performance
```sql
-- Check supplier inconsistencies by store and season
SELECT `Store ID`, `Seasonality`, COUNT(*) as Issues
=======
### 🔹 Analyze Supplier Performance
```sql
SELECT `Store ID`, `Seasonality`, COUNT(*) AS Issues
>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb
FROM supplier_inconsistency
WHERE `Supplier Performance?` = 'Supplier Inconsistency'
GROUP BY `Store ID`, `Seasonality`;
```
<<<<<<< HEAD

---

This system provides a robust foundation for data-driven inventory management, enabling retailers to optimize stock levels, improve supplier relationships, and enhance overall operational efficiency.
=======
```

>>>>>>> 7558f1b33472603a979d5dd90fef9b2714d277cb
