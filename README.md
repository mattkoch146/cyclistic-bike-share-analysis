Google Data Analytics Certificate Case Study 1 - Cyclistic Bike Share Analysis

---

## Business Task

Analyze how annual members and casual riders use Cyclistic bikes differently in order to design a marketing strategy that converts casual riders into annual members.

---

## Data Sources

- **Source:** Cyclistic historical trip data provided by Motivate International Inc.
- **License:** Public data available under [this license](https://divvybikes.com/data-license-agreement)
- **Date Range:** April 2025 – April 2026 (12 months)
- **Total Records:** 5,923,154 rides after cleaning
- **Tool Used:** Google BigQuery for data storage, cleaning, and analysis. Tableau Public for visualizations.

> Note: Data privacy rules prohibit the use of personally identifiable information. Rider pass purchases cannot be connected to credit card numbers or personal details.

---

## Data Cleaning & Processing

All 12 monthly CSV files were uploaded to Google BigQuery and combined into a single table using `UNION ALL`. The following cleaning steps were applied:

- Removed rides with a ride length of 0 or negative seconds (bad data)
- Removed rides longer than 86,400 seconds / 24 hours (likely unreturned bikes)
- Removed rows with null `member_casual` values
- Removed two months (March 2025 and January 2026) that contained only 24 combined rows due to incomplete uploads
- Added `ride_length` column calculated as the difference between `ended_at` and `started_at` in seconds
- Added `day_of_week` column extracted from `started_at` where 1 = Sunday and 7 = Saturday

**Rows removed during cleaning:** ~8,000 (less than 1% of total data)

---

## Analysis Summary

### 1. Ride Frequency and Duration
| Metric | Members | Casual Riders |
|---|---|---|
| Number of Rides | 3,806,676 | 2,116,454 |
| Avg Ride Length | 11.97 minutes | 18.98 minutes |

Members take significantly more rides but for shorter durations. Casual riders take fewer rides but stay on the bikes nearly twice as long on average. This suggests members use bikes for commuting while casual riders use them for leisure.

### 2. Day of Week Patterns
Casual riders peak on Fridays, Saturdays, and Sundays. Members peak on weekdays. This further supports the commuter vs leisure rider distinction.

### 3. Seasonal Trends
Both groups peak in summer and drop in winter, which is expected in Chicago. However, casual riders drop off far more dramatically in winter while members remain relatively consistent year round — reinforcing that members depend on the bikes for commuting regardless of season.

### 4. Bike Type Preference
Both groups prefer electric bikes over classic bikes at roughly a 2:1 ratio. Bike type is not a meaningful differentiator between the two groups.

---

## Visualizations

View the full interactive dashboard on Tableau Public:
[Cyclistic Bike Share Analysis Dashboard](https://public.tableau.com/app/profile/matthew.koch/viz/CyclisticBikeShareAnalysis_17791377433500/Dashboard1)

---

## Top 3 Recommendations

**1. Target casual riders with weekend promotions**
Since casual riders are most active on weekends, a targeted marketing campaign offering discounted weekend trials or a "weekend membership" tier could be an effective entry point to convert them into full annual members.

**2. Launch marketing campaigns in spring**
Casual ridership begins picking up in April and May before the summer peak. This is the optimal window to reach casual riders before they settle into their habits for the season. Digital ads and in-app promotions during this period could have the highest conversion impact.

**3. Highlight cost savings of membership**
Casual riders average nearly 19 minutes per ride compared to 12 minutes for members. Since casual riders are already getting high value from the bikes, a targeted message showing how much they would save with an annual membership versus paying per ride could be a compelling motivator to convert.

---

## Tools Used
- Google BigQuery — data storage, cleaning, and analysis
- Google Cloud Storage — hosting large CSV files for BigQuery import
- Tableau Public — data visualization
- GitHub — portfolio documentation

---

## SQL Queries

All SQL queries used in this project are available in the [`queries.sql`](queries.sql) file in this repository.
