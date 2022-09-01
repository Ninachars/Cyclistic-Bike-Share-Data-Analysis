-- DATA PREPROCESSING
-- there are key attributes we need to calculate or extract from the data given
-- These include: day_of_week, month, year, ride_duration and ride_route
ALTER TABLE dbo.divvy_tripdata_merged
ADD hour_of_day INT,
    day_of_week VARCHAR(50),
    month VARCHAR(50),
    year VARCHAR(50),
    ride_duration_mins INT,
    ride_route VARCHAR(MAX);

-- Extracting day of the week, month and year from the started_at column, calculating 
-- the ride_duration and ride_route and update to the table
UPDATE dbo.divvy_tripdata_merged
SET hour_of_day = DATEPART(HOUR, started_at),
    day_of_week = DATENAME(WEEKDAY, started_at),
    month = DATENAME(MONTH, started_at),
    year = DATENAME(YEAR, started_at),
    ride_duration_mins = DATEDIFF(MINUTE, started_at, ended_at),
    ride_route = CONCAT(start_station_name, ' to ', end_station_name);

-- which trip had the longest duration?
SELECT TOP(1)
    ride_id,
    rideable_type,
    member_casual,
    ride_duration_mins,
    DATEDIFF(DAY, started_at, ended_at) AS ride_duration_days
    --ride_duration_mins/(1440) AS ride_duration_days
FROM dbo.divvy_tripdata_merged
ORDER BY ride_duration_mins DESC

-- checking top 20 longest rides
SELECT TOP(20)
    ride_id,
    rideable_type,
    member_casual,
    ride_duration_mins,
    DATEDIFF(DAY, started_at, ended_at) AS ride_duration_days
FROM dbo.divvy_tripdata_merged
ORDER BY ride_duration_mins DESC

-- checking rides that lasted more than 24hours which is equal to 1440 minutes
SELECT
    COUNT(*) AS more_than_a_day
FROM dbo.divvy_tripdata_merged
WHERE ride_duration_mins > 1440

-- Groupby by user and rideable_type to determine the dorminant 
-- customers having ride durations more than 24hours
SELECT
    rideable_type,
    member_casual,
    COUNT(*) AS more_than_24hrs_riders
FROM dbo.divvy_tripdata_merged
WHERE ride_duration_mins > 1440
GROUP BY rideable_type, member_casual
ORDER BY more_than_24hrs_riders DESC

-- Calculating average trip duration for the user types
SELECT
    member_casual,
    AVG(ride_duration_mins) AS average_duration_mins
FROM dbo.divvy_tripdata_merged
GROUP BY member_casual

-- since average trip duration is 18mins, we will drop rows having over 24hours == 1440mins
DELETE FROM dbo.divvy_tripdata_merged
WHERE ride_duration_mins > 1440

-- how many rides by rideable_type and the user type over the last year?
SELECT
    rideable_type,
    member_casual,
    COUNT(*) AS rides_per_type
FROM dbo.divvy_tripdata_merged
GROUP BY rideable_type, member_casual
ORDER BY rides_per_type DESC;

-- proportion of the total casual and member users
SELECT 
    member_casual,
    COUNT(*) AS users
FROM dbo.divvy_tripdata_merged
GROUP BY member_casual
ORDER BY users

-- calculate number of member and casual users for each day of the week
SELECT
    day_of_week,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS member_users,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS casual_users,
    COUNT(*) AS total_users
FROM dbo.divvy_tripdata_merged
GROUP BY day_of_week
ORDER BY member_users DESC;

-- using date column. This is similar to the above query but using the date column
SELECT
    started_at AS date,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS member_users,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS casual_users,
    COUNT(*) AS total_users
FROM dbo.divvy_tripdata_merged
GROUP BY started_at
ORDER BY date DESC;

-- calculate number of member and casual users for each month
SELECT
    month,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS member_users,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS casual_users,
    COUNT(*) AS total_users
FROM dbo.divvy_tripdata_merged
GROUP BY month

-- Calculating user traffic by hour
SELECT
    hour_of_day,
    COUNT(CASE WHEN member_casual = 'member' THEN 1 ELSE NULL END) AS member_users,
    COUNT(CASE WHEN member_casual = 'casual' THEN 1 ELSE NULL END) AS casual_users,
    COUNT(*) AS total_users
FROM dbo.divvy_tripdata_merged
GROUP BY hour_of_day
ORDER BY hour_of_day

-- Most Popular station; start station
SELECT
    start_station_name,
    member_casual,
    COUNT(start_station_name) AS num_of_start_station
FROM dbo.divvy_tripdata_merged
GROUP BY start_station_name, member_casual
ORDER BY num_of_start_station DESC

-- Most Popular station; end station
SELECT
    end_station_name,
    member_casual,
    COUNT(end_station_name) AS num_of_end_station
FROM dbo.divvy_tripdata_merged
GROUP BY end_station_name, member_casual
ORDER BY num_of_end_station DESC

-- Most Popular route. This can be done using the "group by" statement
SELECT
    start_station_name,
    end_station_name,
    COUNT(end_station_name) AS popular_route,
    member_casual
FROM dbo.divvy_tripdata_merged
GROUP BY start_station_name, end_station_name, member_casual
ORDER BY popular_route DESC;

-- focusing on popular route where the start station is not same as the end station
SELECT
    start_station_name,
    end_station_name,
    COUNT(end_station_name) AS popular_route,
    member_casual
FROM dbo.divvy_tripdata_merged
WHERE start_station_name != end_station_name
GROUP BY start_station_name, end_station_name, member_casual
ORDER BY popular_route DESC
