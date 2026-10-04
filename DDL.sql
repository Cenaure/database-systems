DROP TABLE IF EXISTS weather_forecast_hourly CASCADE;
DROP TABLE IF EXISTS weather_forecast_daily CASCADE;
DROP TABLE IF EXISTS weather_types CASCADE;
DROP TABLE IF EXISTS cities CASCADE;

DROP TYPE IF EXISTS wind_direction_type CASCADE;

CREATE TABLE IF NOT EXISTS cities
(
    id        SERIAL PRIMARY KEY,
    city_name VARCHAR(75) NOT NULL,
    country   VARCHAR(75)
);

CREATE TABLE IF NOT EXISTS weather_types
(
    id          SERIAL PRIMARY KEY,
    description VARCHAR(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS weather_forecast_daily
(
    city_id          INT           NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id),
    calendar_date    DATE          NOT NULL,

    PRIMARY KEY (city_id, calendar_date),

    weather          INT           NOT NULL,
    FOREIGN KEY (weather) REFERENCES weather_types (id),
    min_temperature  DECIMAL(4, 1) NOT NULL,
    max_temperature  DECIMAL(4, 1) NOT NULL,
    humidity_percent SMALLINT      NOT NULL
);

CREATE TYPE wind_direction_type AS ENUM (
    'North','NorthEast','NorthWest',
    'East','South',
    'SouthEast','SouthWest','West'
    );

CREATE TABLE IF NOT EXISTS weather_forecast_hourly
(
    city_id          INT           NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id),
    start_time       TIMESTAMP     NOT NULL,
    end_time         TIMESTAMP     NOT NULL,

    PRIMARY KEY (city_id, start_time),

    weather          INT           NOT NULL,
    FOREIGN KEY (weather) REFERENCES weather_types (id),
    temperature      DECIMAL(4, 1) NOT NULL,
    humidity_percent SMALLINT      NOT NULL,
    wind_speed       SMALLINT,
    wind_direction   wind_direction_type
);