DROP TABLE IF EXISTS weather_forecast_hourly;
DROP TABLE IF EXISTS weather_forecast_daily;
DROP TABLE IF EXISTS weather_types;
DROP TABLE IF EXISTS cities;

DROP TYPE IF EXISTS wind_direction_type;

CREATE TABLE IF NOT EXISTS cities(
  id SERIAL PRIMARY KEY,
  city_name VARCHAR(75) NOT NULL,
  country VARCHAR(75)
);

CREATE TABLE IF NOT EXISTS weather_types(
  id SERIAL PRIMARY KEY,
  description VARCHAR(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS weather_forecast_daily(
  city_id INT NOT NULL, 
  FOREIGN KEY (city_id) REFERENCES cities(id),
  calendar_date DATE NOT NULL,

  PRIMARY KEY (city_id, calendar_date),

  weather INT NOT NULL,
  FOREIGN KEY (weather) REFERENCES weather_types(id),
  min_temperature DECIMAL(4,1) NOT NULL,
  max_temperature DECIMAL(4,1) NOT NULL,
  humidity_percent SMALLINT NOT NULL
);

CREATE TYPE wind_direction_type AS ENUM (
    'North','NorthEast','NorthWest',
    'East','South',
    'SouthEast','SouthWest','West'
  );

CREATE TABLE IF NOT EXISTS weather_forecast_hourly(
  city_id INT NOT NULL, 
  FOREIGN KEY (city_id) REFERENCES cities(id),
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,

  PRIMARY KEY (city_id, start_time),

  weather INT NOT NULL,
  FOREIGN KEY (weather) REFERENCES weather_types(id),
  temperature DECIMAL(4,1) NOT NULL,
  humidity_percent SMALLINT NOT NULL,
  wind_speed SMALLINT,
  wind_direction wind_direction_type
);

-- insert some data in tables
INSERT INTO weather_types (description) VALUES
  ('sunny'),
  ('cloudy'),
  ('rainy'),
  ('heawy rain'),
  ('snowy'),
  ('windy'),
  ('stormy'),
  ('foggy');
  
INSERT INTo cities (city_name, country) VALUES
  ('Kosice', 'Slovakia'),
  ('Bratislava', 'Slovakia'),
  ('Presov', 'Slovakia'),
  ('Kiyiv', 'Ukraine');
  
INSERT INTO weather_forecast_hourly 
  (city_id, start_time, end_time, weather, temperature,
     humidity_percent, wind_speed, wind_direction)
VALUES
    (1, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 22.0, 36, 2, 'SouthEast'),
    (2, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 23.5, 40, 3, 'East'),
    (3, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 2, 21.0, 48, 4, 'West'),
    (4, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 3, 19.0, 65, 5, 'SouthWest');

INSERT INTO weather_forecast_daily 
  (city_id, calendar_date, weather, min_temperature,
     max_temperature, humidity_percent)
VALUEs
    (1, '2026-09-27', 1, 12.0, 23.0, 45),
  (2, '2026-09-27', 1, 14.0, 25.0, 42),
    (3, '2026-09-27', 2, 11.0, 22.0, 50),
    (4, '2026-09-27', 3, 13.0, 20.0, 65);

-- a few queries to test the database
SELECT * FROM cities;

SELECT
    cities.city_name,
    weather_types.description,
    h.start_time,
    h.temperature
FROM weather_forecast_hourly h
JOIN cities  ON h.city_id = cities.id
JOIN weather_types  ON h.weather = weather_types.id
WHERE h.temperature > 20;

SELECT * FROM weather_forecast_daily
  WHERE humidity_percent<50;

SELECT 
  cities.city_name,
  calendar_date,
  weather_types.description AS weather,
  ROUND((min_temperature+max_temperature)/2,1) AS average_temperarure,
  humidity_percent
FROM weather_forecast_daily
JOIN cities ON weather_forecast_daily.city_id = cities.id
JOIN weather_types ON weather_forecast_daily.weather = weather_types.id;

SELECT 
  cities.city_name,
  start_time::date AS date,
  CONCAT(start_time::time, ' - ', end_time::time) AS time,
  weather_types.description AS weather,
  temperature,
  humidity_percent,
  CONCAT(wind_speed, ' km/h') AS wind_speed,
  wind_direction
FROM weather_forecast_hourly
JOIN cities ON weather_forecast_hourly.city_id = cities.id
JOIN weather_types ON weather_forecast_hourly.weather = weather_types.id;
