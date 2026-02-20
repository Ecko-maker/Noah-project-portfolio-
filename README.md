
# 📘 Nashville Housing Data Cleaning (SQL / SSMS)

A streamlined SQL data‑cleaning project completed in **SQL Server Management Studio (SSMS)**. The goal was to transform the raw Nashville Housing dataset into a clean, structured, analysis‑ready table using practical SQL techniques.

## 🔧 Tools
- SQL Server Management Studio (SSMS)  
- T‑SQL  
- Window functions & CTEs  
- String manipulation functions  

## 🧹 Cleaning Steps
- Standardized date formats  
- Split `PropertyAddress` into street and city  
- Split `OwnerAddress` into address, city, and state using `PARSENAME`  
- Standardized `SoldAsVacant` values (Y/N → Yes/No)  
- Identified and removed duplicates using `ROW_NUMBER()` in a CTE  
- Added new columns and updated values for cleaner structure  

## 🎯 Purpose
This project demonstrates real‑world SQL data‑cleaning skills, including string parsing, data standardization, duplicate handling, and table updates—core tasks for analytics and business intelligence roles.

