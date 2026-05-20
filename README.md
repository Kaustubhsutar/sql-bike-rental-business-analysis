<div align="center">

# 🚲 Bike Rental Analytics & Operational Intelligence
### SQL Case Study | Demand Analytics | User Segmentation | Revenue Insights

<p align="center">

  <!-- Language & Platform -->

  <img src="https://img.shields.io/badge/SQL-Google_BigQuery-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white"/>

  <br>

  <!-- Analytics -->

  <img src="https://img.shields.io/badge/Analytics-Demand_Analysis-7B61FF?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Analytics-User_Segmentation-5B5EA6?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Analytics-Revenue_Insights-FF8C00?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Analytics-Station_Performance-00A86B?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Analytics-Time_Series_Analysis-008080?style=for-the-badge"/>

  <br>

  <!-- Domain -->

  <img src="https://img.shields.io/badge/Domain-Bike_Rental-success?style=for-the-badge"/>

  <br>

  <!-- Status -->

  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge"/>

</p>

### Transforming Bike Rental Data into Operational & Business Intelligence

An end-to-end mobility analytics project focused on uncovering commuter demand patterns, rider segmentation insights, operational bottlenecks, and growth opportunities using advanced SQL analytics.

⭐ **If you found this project valuable, consider starring the repository!**

</div>

---

## 📖 Executive Summary

This project analyzes **15,000 bike rental transactions** using **Google BigQuery (Standard SQL)** to uncover:

- Rider behavior patterns
- Demand fluctuations
- Revenue-driving trends
- User segmentation insights
- Station-level operational opportunities

**Using advanced SQL techniques such as:**
- Common Table Expressions (CTEs)
- Aggregations
- Window Functions
- Time-Series Analysis
- Segmentation Logic

the project simulates a real-world business intelligence workflow commonly used in mobility and transportation analytics.

**The analysis reveals:**

- Strong commuter-driven demand patterns
- Heavy reliance on casual riders
- Peak-hour operational pressure
- Station redistribution opportunities
- Seasonal and temporal usage trends

---

## 🎯 Business Problem

Bike rental businesses often face challenges such as:

- Uneven station utilization
- Demand forecasting difficulties
- Poor fleet distribution
- Limited visibility into rider behavior
- Operational inefficiencies during peak hours

Without structured analytics, businesses risk:

- Poor customer experience
- Inefficient resource allocation
- Revenue leakage
- Increased operational costs

This project addresses these challenges through SQL-driven operational intelligence.

---

## 🚀 Objectives

| Business Question | Objective |
|---|---|
| When does rental demand peak? | Optimize operational planning |
| Which users drive engagement? | Improve customer targeting |
| Which stations require balancing? | Reduce operational inefficiencies |
| How do riders behave over time? | Improve demand forecasting |
| What factors influence growth? | Support business expansion decisions |

---

## 🗂 Dataset Overview

📄 **Dataset Documentation:** [Click Here](docs/data_catalog.md)

---

## 🛠️ Important Links & Tools

Everything used in this project is cloud-based and beginner-friendly 🚀

- **[Datasets](datasets/)** — Access to project datasets
- **[Google BigQuery](https://cloud.google.com/bigquery)** — Cloud-based SQL analytics platform
- **[GitHub](https://github.com/)** — Version control and collaboration platform
- **Markdown** — Documentation & project presentation

---

## 🏗 Architecture / Workflow

```text
Raw Bike Rental Transaction Data
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Centralized SQL Analytics Layer
        │
        ├── Demand Trend Analysis
        ├── User Segmentation
        ├── Ride Behavior Analysis
        ├── Station Performance Analysis
        └── Growth & Revenue Insights
        │
        ▼
Business Insights & Operational Recommendations
```

---

## 📂 Repository Structure

```bash
bike-rental-sql-analytics/
│
├── datasets/                     
│   ├── rides.csv
│   ├── users.csv
│   └── stations.csv
│
├── scripts/
│   └── bike_rental_analysis_script.sql
│
├── docs/
│   ├── data_catalog.md
│   ├── business_questions.md
│   └── how_to_run.md
│
├── README.md
└── LICENSE
```

---

## SQL Analysis Performed

### Analytical Areas Covered

✅ Demand trend analysis  
✅ Ride duration analysis  
✅ Distance analytics  
✅ User segmentation  
✅ Peak-hour demand analysis  
✅ Monthly growth analysis  
✅ Station performance tracking  
✅ Net station flow analysis  
✅ Customer behavior analysis  
✅ Operational optimization insights  

---

## Key SQL Queries

### 1️⃣ Membership-Level Ride Behavior Analysis

```sql
SELECT
  COALESCE(u.membership_level,'Unknown') AS membership_level ,
  COUNT(r.ride_id) AS total_rides,
  ROUND(AVG(r.distance_km), 2) AS avg_dist,
  ROUND(
  AVG(TIMESTAMP_DIFF(r.end_time, r.start_time, MINUTE)),
  2
  ) AS avg_duration_mins
FROM `bike_rental_analysis.rides` r
LEFT JOIN `bike_rental_analysis.users` u
  ON r.user_id = u.user_id
GROUP BY u.membership_level
ORDER BY total_rides DESC;
```

### 📌 Insight

This analysis segments rider behavior by membership type, revealing that casual riders generate significantly longer and more frequent rides compared to subscribers.

---

### 2️⃣ Hourly Demand Distribution

```sql
SELECT
  EXTRACT(HOUR FROM start_time) AS hour_of_day,
  COUNT(*) AS ride_count
FROM `bike_rental_analysis.rides`
GROUP BY hour_of_day
ORDER BY hour_of_day;
```

### 📌 Insight

Identifies commuter-driven peak demand periods to support operational planning, staffing allocation, and bike redistribution strategies.

---

### 3️⃣ Net Station Flow Analysis

```sql
WITH departures AS (
  SELECT
    start_station_id,
    COUNT(*) AS total_departures
  FROM `bike_rental_analysis.rides`
  GROUP BY start_station_id
),
arrivals AS (
  SELECT
    end_station_id,
    COUNT(*) AS total_arrivals
  FROM `bike_rental_analysis.rides`
  GROUP BY end_station_id
)

SELECT
  s.station_name,
  d.total_departures,
  a.total_arrivals,
  (a.total_arrivals - d.total_departures) AS net_flow
FROM `bike_rental_analysis.stations` s
JOIN departures d
  ON s.station_id = d.start_station_id
JOIN arrivals a
  ON s.station_id = a.end_station_id
ORDER BY net_flow;
```

### 📌 Insight

Highlights stations with major inflow/outflow imbalance, enabling smarter bike redistribution and operational optimization.

---

### 4️⃣ Month-over-Month User Growth

```sql
WITH monthly_signups AS (
  SELECT
    DATE_TRUNC(created_at, MONTH) AS signup_month,
    COUNT(user_id) AS new_user_count
  FROM `bike_rental_analysis.users`
  GROUP BY signup_month
)
, previous_month_signups AS (
SELECT
signup_month,
new_user_count,
LAG(new_user_count) OVER (ORDER BY signup_month) AS prev_month_count
FROM monthly_signups
)

SELECT
  signup_month,
  new_user_count,
  prev_month_count,
  CONCAT(
      ROUND(
          (new_user_count - prev_month_count)
          / NULLIF(prev_month_count, 0)
          * 100,
          2
      ),
      ' %'
  ) AS mom_growth
FROM previous_month_signups
ORDER BY signup_month;
```

### 📌 Insight

Uses window functions to evaluate platform growth trends and identify periods of accelerated customer acquisition.

---

## 📊 Demand & Ride Analysis

| KPI | Value |
|---|---:|
| Total Rides | 15,000 |
| Total Stations | 25 |
| Registered Users | 1,000 |
| Avg Ride Duration | 28.75 Minutes |
| Avg Ride Distance | 5.85 KM |

## Key Observations

- Ride demand is highly commuter-driven
- Most rides fall into medium and long-duration categories
- Minimal data anomalies detected
- Strong overall platform engagement observed

---

## 👥 Customer Segmentation Insights

| User Type | Total Rides | Avg Duration | Avg Distance |
|---|---:|---:|---:|
| Casual Riders | 10,676 | 34.52 Min | 7.00 KM |
| Subscribers | 4,324 | 14.48 Min | 2.99 KM |

### Casual Riders

- Higher engagement duration
- Longer trip distances
- Likely leisure-oriented usage

### Subscribers

- Shorter rides
- Frequent commuter usage
- Predictable demand behavior

---

## ⏰ Peak Demand Analysis

### Peak Usage Hours

| Hour | Total Rides |
|---|---:|
| 3 PM | 1,617 |
| 4 PM | 1,500 |
| 7 AM | 1,213 |

## Business Interpretation

The platform experiences strong:

- Morning commute demand
- Afternoon/evening return traffic
- Predictable urban mobility patterns

This enables:

✅ Better workforce planning  
✅ Dynamic bike allocation  
✅ Peak-hour optimization  

---

## 📍 Station Performance Analysis

### Top Performing Stations

| Station | Total Rides |
|---|---:|
| Jennifer Land St | 648 |
| King Harbors St | 634 |
| Megan Manors St | 634 |

### Net Flow Imbalance

| Station | Net Flow |
|---|---:|
| Amy Park St | +66 |
| Jennifer Land St | -66 |

### Operational Opportunity

The analysis identifies opportunities for:

- Bike redistribution optimization
- Inventory balancing
- Demand-aware station stocking

---

## 📈 Growth Trends

### User Acquisition Insights

- Highest signup month: **May 2024**
- Strongest growth phase: **February 2024**
- Growth stabilized toward late 2024

### Strategic Interpretation

The platform experienced:

- Rapid early adoption
- Strong market penetration
- Gradual stabilization phase

This suggests growing market maturity.

---

## 💡 Strategic Recommendations

### 1️⃣ Optimize Peak-Hour Operations

Increase:

- Fleet availability
- Staffing efficiency
- Redistribution frequency

during commuter peak periods.


### 2️⃣ Improve Station Balancing

Use net flow insights to:

- Prevent station shortages
- Reduce congestion
- Improve ride availability


### 3️⃣ Target Casual Riders for Conversion

Casual riders represent:

```text
71% of total rides
```

Introduce:

- Membership discounts
- Loyalty programs
- Subscription incentives

to improve retention.


### 4️⃣ Build Demand Forecasting Models

Leverage historical patterns for:

- Predictive operations
- Resource planning
- Dynamic pricing opportunities

---

## 📈 Business Impact

## Value Delivered Through This Analysis

### Operational Optimization

Identified station-level balancing opportunities and peak-hour demand patterns.

### Customer Intelligence

Uncovered behavioral differences between rider segments.

### Growth Visibility

Analyzed user acquisition and platform expansion trends.

### Decision Support

Delivered actionable insights for:

- Operations teams
- Growth stakeholders
- Business analysts
- Mobility planners

---

## 📚 Key Learnings

### Technical Learnings

- Advanced SQL querying
- Time-series analytics
- Window functions
- User segmentation
- Operational KPI analysis

### Business Learnings

- Mobility demand follows predictable commuter cycles
- Casual riders dominate engagement
- Operational efficiency strongly impacts customer experience

---

## ▶️ How to Run This Project : [Click here to know](docs/how_to_run.md)

---

## 🚀 Future Improvements

Planned enhancements include:

- Interactive Power BI dashboards
- Real-time operational tracking
- Demand forecasting models
- Geospatial station analysis
- Predictive maintenance analytics
- Customer churn analysis

---

## 🌟 About Me

Hi there! I'm **Kaustubh Sutar**. I’m a data enthusiast and aspiring data analyst skilled in Power BI, Excel, SQL, and Python, exploring Machine Learning & AI to turn data into actionable insights.

Let's stay in touch! Feel free to connect with me on the following platforms:

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/kaustubh-sutar-814134340/)

---

## ⭐ Support This Project

If you found this project insightful:

- ⭐ Star the repository
- 🍴 Fork the project
- 📢 Share it with others
- 💼 Connect for analytics collaborations

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

---
