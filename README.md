# 🏙️ Real Estate Market & Transaction Analysis

## 📌 Executive Summary
This project analyzes a comprehensive real estate dataset to uncover critical market dynamics, pricing fluctuations, and investment risks. By leveraging advanced SQL, the analysis transitions raw property transaction data into actionable insights regarding housing supply, affordability constraints, and buyer behavior. 

This repository demonstrates a complete data pipeline approach: from initial quality assessment and anomaly detection to advanced analytical modeling.

## 🛠️ Tech Stack & Skills Highlighted
* **Database Management System:** MySQL
* **Advanced SQL Techniques:** Common Table Expressions (CTEs), Window Functions (`LAG`, `ROW_NUMBER`, `PERCENT_RANK`), Aggregate Functions, Data Imputation.
* **Analytical Focus:** Exploratory Data Analysis (EDA), Data Integrity Management, Time-Series Pricing Trends, Cohort Segmentation.

---

## 📊 Core Business Problems Solved

### 1. Data Integrity & Cleaning
* **Challenge:** Raw transaction data contained missing values, extreme pricing outliers, and duplicate entries.
* **Solution:** Engineered SQL scripts to handle null values via median/mean imputation partitioned by property type and city. Applied row-ranking to remove duplicates and  pricing anomalies to ensure reliable downstream financial modeling.

### 2. Market Trends & Pricing Volatility
* **Challenge:** Stakeholders needed to understand historical price growth and regional disparities.
* **Solution:** Calculated year-over-year percentage changes in listing prices across major metropolitan areas, revealing that Chicago experienced a massive -42.69% price shift between 2020 and 2021, and Miami had a 66% increase between 2021 and 2022

### 3. Supply Dynamics & Investor Activity
* **Challenge:** Tracking how new construction impacts market stability and speculative investment.
* **Solution:** Identified 2020 as the peak year for new developments with 21844 properties built. Mapped this supply against investor activity scores, highlighting Los Angeles as the most volatile market for investor entry and exit.

### 4. Buyer Segmentation & Affordability Stress
* **Challenge:** Assessing homeownership accessibility as market prices rise.
* **Solution:** Computed Price-to-Income ratios across distinct income brackets. Segmented buyers to prove that the $100k-$150k demographic currently faces "Severely Unaffordable" market conditions, severely restricting first-time homebuyer access.

---

## 💡 Key Insights
* **Investor Activity:** Data indicates that as investor activity change is the highest in Los Angeles at 5.13%.
* **Property Type Preferences:** Apartment type dominates the market in terms of volume, but Townhouse commands the highest average premium at $1057499.29.
* **High-Demand Hotspots:** Seattle exhibits the strongest housing demand index, creating a significant gap between average home prices $566786.64  and rental yields $3638.35.

---

## 📂 Repository Navigation
All queries are modularized and heavily commented for readability. 
* Navigate to the `sql_scripts/` folder to view the logic used for data extraction and transformation.
* Review the `docs/` folder for the original business case requirements.
