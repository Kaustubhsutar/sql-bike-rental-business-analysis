# Bike Rental Analytics Project – Google BigQuery

Welcome to the Bike Rental Analytics Project repository! 🚀
This project showcases a real-world SQL analytics solution built using Google BigQuery, focusing on extracting actionable insights from bike rental data.

---
## 📊 Project Overview
This project analyzes bike rental data to answer key business questions such as:
1. 📈 What are the **monthly** and **yearly** revenue trends?
2. 🚴 How does rental demand vary by season?
3. 👥 How do **casual** and **registered** users differ?
4. 💰 What factors influence revenue growth?
The analysis was performed entirely using Standard SQL in Google BigQuery.

---

## 🛠️ Important Links & Tools

Everything used in this project is cloud-based and beginner-friendly 🚀
- **[Datasets](datasets/)**: Access to the project dataset (csv files).
- **[Google BigQuery](https://cloud.google.com/bigquery)**: Fully managed, serverless data warehouse used for performing SQL-based analytics.
- **[GitHub](https://github.com/)**: Version control and project hosting platform.

---

## 📂 Repository Structure
```
bike-rental-sql-analytics/
│
├── datasets/                     
│   ├── rides.csv                         # Transactional ride-level data (fact table)
│   ├── users.csv                         # User/customer information (dimension table)
│   ├── stations.csv                      # Station location and metadata (dimension table)
│
├── scripts/
│   ├── bike_rental_analysis_script.sql   # Main SQL script containing all analytical queries,
│                                         # aggregations, CTEs, window functions, and insights
│
├── docs/
│   ├── data_catalog.md                   # Detailed data dictionary describing tables and columns
│   ├── business_questions.md             # List of business problems solved through SQL analysis
│
├── README.md                             # Project overview, executive summary, and key findings
└── LICENSE                               # MIT License for open-source usage
```

---

# 📊 Key Findings

## 👁 Overall Platform Performance
- The system processed **15,000** total rides across **25 stations** with **1,000 registered users**.
- Data quality checks confirmed zero null values in critical ride fields (ride_id, user_id, timestamps), ensuring high dataset reliability.

---

## 📏 Ride Behavior & Usage Patterns
- The average ride duration was **28.75 minutes**, with rides ranging from **0 to 96 minutes**.
- The **average ride distance** was **5.85 km**, with a maximum recorded distance of **19.37 km**.
- Only **106** rides were short-duration trips, and just **1 ride** had zero distance, indicating minimal data anomalies.
- Most rides fall into:
  I. **Medium category**: 7,092 rides
  II. **Long category**: 6,480 rides
This highlights strong overall user engagement.

---

## 👥 Customer Segmentation Insights
- Casual users dominate usage, accounting for:
  - **10,676 rides (71%)**
  - Compared to **4,324 rides (29%)** by Subscribers.

- Casual riders:
  - **34.52 minutes average duration**
  - **7.00 km average distance**
   
- Subscribers:
  - **14.48 minutes average duration**
  - **2.99 km average distance**

### Interpretation
- Casual users likely use bikes for leisure and longer trips.
- Subscribers primarily use bikes for short, routine commuting.

---

## ⏰ Peak Demand Analysis
Ride activity peaks during:
- **3 PM (1,617 rides)** — highest demand hour
- **4 PM (1,500 rides)**
- **7 AM (1,213 rides)** — strong morning commute trend

Lowest activity occurs between **midnight and 4 AM**, indicating predictable off-peak hours.

This clearly shows **commuter-driven demand patterns** with strong morning and afternoon spikes.

---

## 📍 Station Performance & Flow Analysis

### 🔝 Top Start Stations

- Jennifer Land St – **648 rides**
- King Harbors St – **634 rides**
- Megan Manors St – **634 rides**

### 🔄 Net Flow Imbalance
- Amy Park St **(+66 net inflow)** receives significantly more bikes than it sends.
- Jennifer Land St **(-66 net outflow)** sends significantly more bikes than it receives.

### Operational Opportunities
- Bike redistribution optimization
- Operational balancing strategies
- Demand-based station stocking

## 📈 User Growth Trends
- Highest monthly signups occurred in **May 2024 (97 new users)**.
- **February 2024** recorded **219% month-over-month growth**, indicating a strong early growth phase.
- Growth stabilized toward late 2024, with moderate fluctuations.

### Interpretation
- Initial expansion phase early in the year
- Market stabilization in later months

--- 

# 🎯 Business Implications

The analysis reveals:
- Strong commuter usage patterns
- Heavy reliance on casual riders for engagement
- Clear hourly demand cycles
- Station-level redistribution opportunities
- Early rapid user growth followed by stabilization

**These insights support:**
- Demand forecasting
- Staffing optimization
- Bike redistribution strategies
- Customer targeting campaigns
- Subscription marketing opportunities

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

## 🌟 About Me

Hi there! I'm **Kaustubh Sutar**. I’m a data enthusiast and aspiring data analyst skilled in Power BI, Excel, SQL, and Python, exploring Machine Learning & AI to turn data into actionable insights.

Let's stay in touch! Feel free to connect with me on the following platforms:

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kaustubh-sutar-814134340/)

