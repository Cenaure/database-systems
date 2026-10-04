-- Returns all cities
SELECT *
FROM cities;

-- Returns hourly forecasts where temperature is above 20
SELECT
    c.city_name,
    wt.description,
    h.start_time,
    h.temperature
FROM
    weather_forecast_hourly AS h
        JOIN cities AS c ON h.city_id = c.id
        JOIN weather_types AS wt ON h.weather = wt.id
WHERE
    h.temperature > 20;

-- Returns daily forecasts where humidity is below 50%
SELECT *
FROM
    weather_forecast_daily
WHERE
    humidity_percent < 50;

-- Returns daily forecasts for each city with the weather type, humidity and average temperature
SELECT
    c.city_name,
    calendar_date,
    wt.description                         AS weather,
    ROUND((min_temperature + max_temperature) / 2, 1) AS average_temperature,
    humidity_percent
FROM
    weather_forecast_daily AS d
        JOIN cities  AS c ON d.city_id = c.id
        JOIN weather_types AS wt ON d.weather = wt.id;

-- Returns hourly forecasts by cities
SELECT
    c.city_name,
    start_time::date                                AS date,
    CONCAT(start_time::time, ' - ', end_time::time) AS time,
    wt.description                       AS weather,
    temperature,
    humidity_percent,
    CONCAT(wind_speed, ' km/h')                     AS wind_speed,
    wind_direction
FROM
    weather_forecast_hourly AS h
    JOIN cities AS c ON h.city_id = c.id
    JOIN weather_types AS wt ON h.weather = wt.id;