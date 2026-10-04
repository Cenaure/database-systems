INSERT INTO weather_types (description)
VALUES ('sunny'),
       ('cloudy'),
       ('rainy'),
       ('heavy rain'),
       ('snowy'),
       ('windy'),
       ('stormy'),
       ('foggy');

INSERT INTO cities (city_name, country)
VALUES ('Kosice', 'Slovakia'),
       ('Bratislava', 'Slovakia'),
       ('Presov', 'Slovakia'),
       ('Kyiv', 'Ukraine');

INSERT INTO weather_forecast_hourly
(city_id, start_time, end_time, weather, temperature,
 humidity_percent, wind_speed, wind_direction)
VALUES (1, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 22.0, 36, 2, 'SouthEast'),
       (2, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 23.5, 40, 3, 'East'),
       (3, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 2, 21.0, 48, 4, 'West'),
       (4, '2026-09-27 14:00:00', '2026-09-27 16:00:00', 3, 19.0, 65, 5, 'SouthWest'),
       (4, '2026-09-27 13:00:00', '2026-09-27 14:00:00', 3, 20.0, 70, 6, 'SouthWest');

INSERT INTO weather_forecast_daily
(city_id, calendar_date, weather, min_temperature,
 max_temperature, humidity_percent)
VALUES (1, '2026-09-27', 1, 12.0, 23.0, 45),
       (2, '2026-09-27', 1, 14.0, 25.0, 42),
       (3, '2026-09-27', 2, 11.0, 22.0, 50),
       (4, '2026-09-27', 3, 13.0, 20.0, 65);
