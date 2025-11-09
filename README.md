# Retail Orders Analysis Using Python and SQL

## 📘 Project Overview
This project analyzes retail order data (9,994 rows, 16 columns) from Kaggle to uncover insights on sales, profit, customer segments, and regional performance.
The analysis demonstrates the end-to-end data analytics process — from data cleaning and transformation in Python to advanced SQL queries for business insights.

## 🧰 Tools & Technologies Used
- **Python:** Pandas, NumPy, SQLAlchemy
- **Database:** MySQL
- **Libraries:** Matplotlib, Seaborn
- **IDE:** Jupyter Notebook


## 📂 Dataset Information
- **Source:** Kaggle Retail Orders Dataset
- **Shape:** 9,994 rows × 16 columns
- **Period Covered:** 2022–2023
- **Key Columns:**
  - Order ID, Order Date, Ship Mode, Segment, Country, City, State, Postal Code, Region, Category, Sub-Category, Product ID, Cost Price, List Price, Quantity, Discount Percent


## 🧹 Data Preparation Steps
- Imported CSV data using pandas.read_csv().
- Cleaned missing values ("Not Available", "unknown" → NaN).
- Created calculated columns:
  - Unit Selling Price = List Price − (List Price × Discount %)
  - Unit Profit = Unit Selling Price − Cost Price
  - Total Sale = Unit Selling Price × Quantity
  - Total Profit = Unit Profit × Quantity
- Converted Order Date to datetime format.
- Removed unnecessary columns (Cost Price, List Price, Discount Percent).
- Exported cleaned data to MySQL using SQLAlchemy.


## 🔍 Exploratory Data Analysis (EDA)
**Performed in Python**
- Top 10 highest profit-generating products
- Total unique cities with shipments (531)
- Average order value (₹1,108.60)
- Region-wise and category-wise sales analysis
- Month-over-month sales growth (2022 vs 2023)
- Top products by region (quantity & total sales)
- Sub-category with highest profit growth (Machines, +₹22,334 in 2023)

**Replicated in MySQL**
- Aggregate calculations using GROUP BY
- Ranking with DENSE_RANK() and ROW_NUMBER()
- CTEs for monthly & yearly growth comparisons
- Quarter-based and category-based performance queries


## 📊 Key Insights
- ✅ Top category: Technology
- ✅ Top region by sales: West
- ✅ Most profitable sub-category: Machines
- ✅ Highest sales month: October (Festive Season)
- ✅ Average Order Value: ₹1,108
- ✅ Unique Cities: 531


## 💡 Business Recommendations
- Increase stock & marketing in West and East regions.
- Focus on Technology and Office Supplies during festive months.
- Improve underperforming categories like Fasteners and Furnishings.
- Target top-performing cities with loyalty programs.
- Optimize shipping efficiency for Second Class and Same Day modes.

