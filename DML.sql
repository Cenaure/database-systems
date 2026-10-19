TRUNCATE weather_forecast_hourly, weather_forecast_daily,
    weather_stations, cities, weather_types
    RESTART IDENTITY CASCADE;

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
       ('Kyiv', 'Ukraine'),
       ('Astana', 'Kazakhstan');

INSERT INTO weather_stations (station_name, city_id, altitude_m)
VALUES ('Kosice - Airport', 1, 230),
       ('Kosice - Hlavna', 1, 208),
       ('Bratislava - Koliba', 2, 287),
       ('Kyiv - Zhuliany', 4, 180),
       ('Mobilna stanica Tatry', NULL, 1500);

INSERT INTO weather_forecast_daily
(city_id, calendar_date, weather, min_temperature,
 max_temperature, humidity_percent)
VALUES (1, '2026-09-27', 1, 12.0, 23.0, 45),
       (2, '2026-09-27', 1, 14.0, 25.0, 42),
       (3, '2026-09-27', 2, 11.0, 22.0, 50),
       (4, '2026-09-27', 3, 13.0, 20.0, 65),
       (5, '2026-09-27', 2, 8.0, 18.0, 58),
       (1, '2026-09-28', 2, 10.0, 19.0, 55),
       (2, '2026-09-28', 6, 13.0, 21.0, 48),
       (4, '2026-09-28', 2, 12.0, 17.0, 80),
       (1, '2026-09-29', 3, 9.0, 15.0, 72);

INSERT INTO weather_forecast_hourly
(city_id, start_time, end_time, weather, temperature,
 humidity_percent, wind_speed, wind_direction)
VALUES (1, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 22.0, 36, 2, 'SouthEast'),
       (2, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 1, 23.5, 40, 3, 'East'),
       (3, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 2, 21.0, 48, 4, 'West'),
       (4, '2026-09-27 14:00:00', '2026-09-27 16:00:00', 3, 19.0, 65, 5, 'SouthWest'),
       (4, '2026-09-27 13:00:00', '2026-09-27 14:00:00', 3, 20.0, 70, 6, 'SouthWest'),
       (5, '2026-09-27 15:00:00', '2026-09-27 16:00:00', 2, 17.0, 58, 5, 'North'),
       (1, '2026-09-28 09:00:00', '2026-09-28 10:00:00', 2, 12.5, 60, 3, 'North'),
       (2, '2026-09-28 12:00:00', '2026-09-28 13:00:00', 6, 19.0, 50, 18, 'West');
