/* =========================================================
BIKE RENTAL ANALYTICS — DATA EXPLORATION & KPI QUERIES
------------------------------------------------------

Purpose:

* Validate dataset completeness
* Generate descriptive statistics
* Identify behavioral patterns
* Produce operational insights

Notes:

* Uses BigQuery Standard SQL
* Fully-qualified table references retained
  ========================================================= */

/* =========================================================
1️⃣ Row counts across core tables
---------------------------------

Single-row snapshot using scalar subqueries to quickly
verify dataset loading completeness.
========================================================= */

SELECT
  (SELECT COUNT(*) FROM `bike_rental_analysis.rides`)     AS total_rides,
  (SELECT COUNT(*) FROM `bike_rental_analysis.stations`)  AS total_stations,
  (SELECT COUNT(*) FROM `bike_rental_analysis.users`)     AS total_users;

/* =========================================================
2️⃣ Missing value audit — rides table
-------------------------------------

COUNTIF used for column-level null diagnostics.
Helps assess ETL or ingestion quality.
========================================================= */

SELECT

  COUNTIF(ride_id IS NULL)     AS null_ride_ids,
  COUNTIF(user_id IS NULL)     AS null_user_ids,
  COUNTIF(start_time IS NULL)  AS null_start_time,
  COUNTIF(end_time IS NULL)    AS null_end_time

FROM `bike_rental_analysis.rides`;

/* =========================================================
3️⃣ Summary statistics — distance & duration
--------------------------------------------

Duration derived on-the-fly instead of materialized.
========================================================= */

SELECT

  ROUND(MIN(distance_km), 2) AS min_dist,
  ROUND(MAX(distance_km), 2) AS max_dist,
  ROUND(AVG(distance_km), 2) AS avg_dist,

  ROUND(MIN(TIMESTAMP_DIFF(end_time, start_time, MINUTE)), 2) AS min_duration_mins,
  ROUND(MAX(TIMESTAMP_DIFF(end_time, start_time, MINUTE)), 2) AS max_duration_mins,
  ROUND(AVG(TIMESTAMP_DIFF(end_time, start_time, MINUTE)), 2) AS avg_duration_mins

FROM `bike_rental_analysis.rides`;

/* =========================================================
4️⃣ Detect anomalous / false-start rides
----------------------------------------

Identifies rides likely representing unlock failures,
user cancellations, or telemetry issues.
========================================================= */

SELECT

  COUNTIF(TIMESTAMP_DIFF(end_time, start_time, MINUTE) < 2) AS short_duration_trips,
  COUNTIF(distance_km = 0)                                  AS zero_distance_trips
  
FROM `bike_rental_analysis.rides`;

/* =========================================================
5️⃣ Membership-level ride behavior
----------------------------------

LEFT JOIN ensures rides without user matches remain
visible under NULL membership bucket for auditing if present.
========================================================= */

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

/* =========================================================
6️⃣ Hourly demand distribution
------------------------------

Supports fleet rebalancing and staffing decisions.
========================================================= */

SELECT

  EXTRACT(HOUR FROM start_time) AS hour_of_day,
  COUNT(*) AS ride_count

FROM `bike_rental_analysis.rides`
GROUP BY hour_of_day
ORDER BY hour_of_day;

/* =========================================================
7️⃣ Most popular start stations
-------------------------------

INNER JOIN intentionally filters rides with invalid
station references.
========================================================= */

SELECT

  s.station_name,
  COUNT(r.ride_id) AS total_starts

FROM `bike_rental_analysis.rides` r
JOIN `bike_rental_analysis.stations` s
  ON r.start_station_id = s.station_id
GROUP BY s.station_name
ORDER BY total_starts DESC
LIMIT 10;

/* =========================================================
8️⃣ Ride duration categorization
--------------------------------

CASE boundaries mutually exclusive for clarity.
Enables segmentation-style analytics.
========================================================= */

SELECT

  CASE
  WHEN TIMESTAMP_DIFF(end_time, start_time, MINUTE) <= 10 THEN 'Short'
  WHEN TIMESTAMP_DIFF(end_time, start_time, MINUTE) BETWEEN 11 AND 30 THEN 'Medium'
  ELSE 'Long'
  END AS ride_category,
  COUNT(*) AS ride_count

FROM `bike_rental_analysis.rides`
GROUP BY ride_category
ORDER BY ride_count DESC;

/* =========================================================
9️⃣ Net station flow (arrivals - departures)
--------------------------------------------

CTE separation improves readability and reuse.
========================================================= */

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

/* =========================================================
🔟 Month-over-Month user growth
-------------------------------

Step 1 — Aggregate monthly signups
Step 2 — Derive previous month counts (separate CTE)
Step 3 — Compute growth percentage
========================================================= */

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
