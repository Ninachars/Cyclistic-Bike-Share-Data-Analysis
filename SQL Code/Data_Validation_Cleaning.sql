-- count number of rows in the data
SELECT COUNT(*) AS total_rides
FROM dbo.divvy_tripdata_merged;

-- checking for duplicates in the ride_id which is the primary key of the data
SELECT 
    COUNT(ride_id) as total_rides,
    COUNT(DISTINCT ride_id) as unique_rides
FROM dbo.divvy_tripdata_merged

-- finding the distinct rideable_type offered by Cyclistic.
SELECT DISTINCT rideable_type
FROM dbo.divvy_tripdata_merged;

-- querying the number of distinct bike stations
SELECT COUNT(DISTINCT start_station_name) AS stations
FROM dbo.divvy_tripdata_merged;

-- querying for null values in the start and end time/date
SELECT COUNT(*) AS no_recorded_time
FROM dbo.divvy_tripdata_merged
WHERE started_at IS NULL 
    OR ended_at IS NULL;

-- finding entries where the datetime diff is less than or equal to zero. This signifies 
-- a wrong data point as time duration should not be less than or equal to zero.
SELECT
    COUNT(*) AS invalid_datetime
FROM dbo.divvy_tripdata_merged
WHERE DATEDIFF(MINUTE, started_at, ended_at) <= 0

-- investigating more on the rides that have ride_duration less than zero, 
-- we add another condition to check if the start station is same as end station.
SELECT 
    COUNT(*) AS same_start_end_station
FROM dbo.divvy_tripdata_merged
WHERE DATEDIFF(MINUTE, started_at, ended_at) <= 0
    AND start_station_name = end_station_name;

-- we add another condition to check if any of the station names is NULL.
SELECT 
    COUNT(*) AS same_start_end_station
FROM dbo.divvy_tripdata_merged
WHERE DATEDIFF(MINUTE, started_at, ended_at) <= 0
    AND (start_station_name = end_station_name
    OR start_station_name IS NULL
    OR end_station_name IS NULL);

-- determining number of rows where no start or end station name is indicated
SELECT COUNT(*) AS no_station_name
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NULL
    OR end_station_name IS NULL;

SELECT *
FROM dbo.divvy_tripdata_merged
WHERE 
start_station_name IS NULL
    OR end_station_name IS NULL;



-- counting the number of rides by member_casual column
SELECT
    member_casual,
    COUNT(*) AS rides
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
GROUP BY member_casual;

-- counting the number of rides per start station
SELECT
    start_station_name,
    COUNT(start_station_name) AS rides
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY rides DESC;

-- counting the number of rides per end station
SELECT
    end_station_name,
    COUNT(end_station_name) AS rides
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY rides DESC;

-- counting number of rides with ride_duration greater than 1440 minutes which is more than 24hrs
SELECT COUNT(*) AS ride_duration
FROM dbo.divvy_tripdata_merged
WHERE DATEDIFF(MINUTE, started_at, ended_at) > 1440
ORDER BY ride_duration DESC

-- querying the data where start and end station names are not null
SELECT COUNT(*)
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NOT NULL
    OR end_station_name IS NOT NULL;

-- checking customer status where either start station or end station name is missing
SELECT 
    member_casual,
    COUNT(*)
FROM dbo.divvy_tripdata_merged
WHERE start_station_name IS NULL
    OR end_station_name IS NULL
GROUP BY member_casual;
