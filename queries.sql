-- Cyclistic Bike Share Analysis
-- Google Data Analytics Certificate — Case Study 1
-- All queries run in Google BigQuery

-- ============================================
-- STEP 1: Combine all 12 monthly tables
-- ============================================
CREATE TABLE cyclistic_data.all_trips AS
SELECT * FROM cyclistic_data.trips_202504
UNION ALL
SELECT * FROM cyclistic_data.trips_202505
UNION ALL
SELECT * FROM cyclistic_data.trips_202506
UNION ALL
SELECT * FROM cyclistic_data.trips_202507
UNION ALL
SELECT * FROM cyclistic_data.trips_202508
UNION ALL
SELECT * FROM cyclistic_data.trips_202509
UNION ALL
SELECT * FROM cyclistic_data.trips_202510
UNION ALL
SELECT * FROM cyclistic_data.trips_202511
UNION ALL
SELECT * FROM cyclistic_data.trips_202512
UNION ALL
SELECT * FROM cyclistic_data.trips_202602
UNION ALL
SELECT * FROM cyclistic_data.trips_202603
UNION ALL
SELECT * FROM cyclistic_data.trips_202604;

-- ============================================
-- STEP 2: Add ride_length and day_of_week columns
-- ============================================
CREATE TABLE cyclistic_data.all_trips_cleaned AS
SELECT *,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
FROM cyclistic_data.all_trips;

-- ============================================
-- STEP 3: Clean the data
-- ============================================
CREATE TABLE cyclistic_data.all_trips_final AS
SELECT *
FROM cyclistic_data.all_trips_cleaned
WHERE 
  ride_length > 0
  AND ride_length < 86400
  AND member_casual IS NOT NULL;

-- ============================================
-- STEP 4: Remove incomplete months
-- ============================================
CREATE OR REPLACE TABLE cyclistic_data.all_trips_final AS
SELECT *
FROM cyclistic_data.all_trips_final
WHERE NOT (EXTRACT(YEAR FROM started_at) = 2025 AND EXTRACT(MONTH FROM started_at) = 3)
AND NOT (EXTRACT(YEAR FROM started_at) = 2026 AND EXTRACT(MONTH FROM started_at) = 1);

-- ============================================
-- STEP 5: Verify total row count
-- ============================================
SELECT COUNT(*) as total_rows
FROM cyclistic_data.all_trips_final;

-- ============================================
-- STEP 6: Overall rides and avg ride length
-- ============================================
SELECT 
  member_casual,
  COUNT(*) as number_of_rides,
  ROUND(AVG(ride_length)/60, 2) as avg_ride_length_minutes
FROM cyclistic_data.all_trips_final
GROUP BY member_casual;

-- ============================================
-- STEP 7: Rides and avg ride length by day of week
-- ============================================
SELECT 
  member_casual,
  day_of_week,
  COUNT(*) as number_of_rides,
  ROUND(AVG(ride_length)/60, 2) as avg_ride_length_minutes
FROM cyclistic_data.all_trips_final
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;

-- ============================================
-- STEP 8: Rides and avg ride length by month
-- ============================================
SELECT 
  member_casual,
  FORMAT_DATE('%Y-%m', DATE(started_at)) as year_month,
  COUNT(*) as number_of_rides,
  ROUND(AVG(ride_length)/60, 2) as avg_ride_length_minutes
FROM cyclistic_data.all_trips_final
GROUP BY member_casual, year_month
ORDER BY year_month, member_casual;

-- ============================================
-- STEP 9: Rides by bike type
-- ============================================
SELECT 
  member_casual,
  rideable_type,
  COUNT(*) as number_of_rides
FROM cyclistic_data.all_trips_final
GROUP BY member_casual, rideable_type
ORDER BY member_casual, rideable_type;
