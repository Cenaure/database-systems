-- =====================================================================
-- 1. INNER JOIN
-- Vypiste hodinove predpovede miest na Slovensku spolu s popisom pocasia
-- a s dennou minimalnou a maximalnou teplotou toho isteho dna.
-- Vysledky zoradte podla nazvu mesta a casu zaciatku predpovede.
-- =====================================================================
SELECT c.city_name,
       h.start_time,
       wt.description AS pocasie,
       h.temperature,
       d.min_temperature,
       d.max_temperature
FROM weather_forecast_hourly AS h
         INNER JOIN cities AS c ON h.city_id = c.id
         INNER JOIN weather_types AS wt ON h.weather = wt.id
         INNER JOIN weather_forecast_daily AS d
                    ON d.city_id = h.city_id
                        AND d.calendar_date = h.start_time::date
WHERE c.country = 'Slovakia'
ORDER BY c.city_name, h.start_time;


-- =====================================================================
-- 2. LEFT JOIN
-- Vypiste druhy pocasia, ktore sa nepouzivaju v ziadnej predpovedi
-- (ani dennej, ani hodinovej). Vysledky zoradte abecedne.
-- =====================================================================
SELECT wt.id, wt.description
FROM weather_types AS wt
         LEFT JOIN weather_forecast_daily AS d ON d.weather = wt.id
         LEFT JOIN weather_forecast_hourly AS h ON h.weather = wt.id
WHERE d.weather IS NULL
  AND h.weather IS NULL
ORDER BY wt.description;


-- =====================================================================
-- 3. FULL OUTER JOIN
-- Vypiste vsetky mesta a vsetky meteorologicke stanice. Pri kazdom riadku
-- uvedte stav: mesto bez stanice, stanica bez mesta alebo v poriadku.
-- Vysledky zoradte podla mesta (riadky bez mesta nakoniec) a stanice.
-- =====================================================================
SELECT c.city_name,
       s.station_name,
       s.altitude_m,
       CASE
           WHEN s.id IS NULL THEN 'mesto bez stanice'
           WHEN c.id IS NULL THEN 'stanica bez mesta'
           ELSE 'v poriadku'
           END AS stav
FROM cities AS c
         FULL OUTER JOIN weather_stations AS s ON s.city_id = c.id
ORDER BY c.city_name NULLS LAST, s.station_name;


-- =====================================================================
-- 4. SELF JOIN (spojenie tabulky so sebou samou)
-- Vypiste dvojice miest, ktore mali v ten isty den rovnake pocasie.
-- Zobrazte datum, obe mesta, druh pocasia a rozdiel maximalnych teplot.
-- Kazdu dvojicu uvedte len raz. Zoradte podla datumu a rozdielu teplot.
-- =====================================================================
SELECT d1.calendar_date AS datum,
       c1.city_name AS mesto_1,
       c2.city_name AS mesto_2,
       wt.description AS pocasie,
       ABS(d1.max_temperature - d2.max_temperature) AS rozdiel_max_teploty
FROM weather_forecast_daily AS d1
         JOIN weather_forecast_daily AS d2
              ON d1.calendar_date = d2.calendar_date
                  AND d1.weather = d2.weather
                  AND d1.city_id < d2.city_id -- bez toho by sa dvojice opakovali aj mesto s sebou
         JOIN cities AS c1 ON d1.city_id = c1.id
         JOIN cities AS c2 ON d2.city_id = c2.id
         JOIN weather_types AS wt ON d1.weather = wt.id
ORDER BY d1.calendar_date, rozdiel_max_teploty DESC;


-- =====================================================================
-- 5. CROSS JOIN (+ LEFT JOIN)
-- Pre obdobie 27.9.2026 - 29.9.2026 zistite, ktore kombinacie mesto + den
-- nemaju dennu predpoved. Vysledky zoradte podla mesta a datumu.
-- =====================================================================
SELECT c.city_name,
       dates.calendar_date
FROM cities AS c
         CROSS JOIN (SELECT DATE '2026-09-27' + n AS calendar_date
                     FROM generate_series(0, 2) AS n) AS dates
         LEFT JOIN weather_forecast_daily AS d
                   ON d.city_id = c.id
                       AND d.calendar_date = dates.calendar_date
WHERE d.city_id IS NULL
ORDER BY c.city_name, dates.calendar_date;
