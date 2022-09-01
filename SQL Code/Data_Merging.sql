-- creating a table to marged all 12 datasets for better usability
CREATE TABLE divvy_tripdata_merged
    (ride_id VARCHAR(50),
    rideable_type VARCHAR(50),
    started_at DATETIME2(7),
    ended_at DATETIME2(7),
    start_station_name VARCHAR(MAX),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(MAX),
    end_station_id VARCHAR(50),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(50))

-- Insert the subquery that first combines the 12 datasets using UNION ALL into the created table
INSERT INTO divvy_tripdata_merged (
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
)
    SELECT * FROM test.dbo.[202108-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202109-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202110-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202111-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202112-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202201-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202202-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202203-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202204-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202205-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202206-divvy-tripdata]

    UNION ALL

    SELECT * FROM test.dbo.[202207-divvy-tripdata]