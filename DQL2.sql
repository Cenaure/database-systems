-- 1. Zobrazte nazvy miest velkymi pismenami,
-- krajinu a pocet znakov v nazve mesta.
-- Vysledky zoradte abecedne podla nazvu mesta.

SELECT
    UPPER(city_name) AS mesto,
    country AS krajina,
    LENGTH(city_name) AS pocet_znakov
FROM cities
ORDER BY LOWER(city_name) ASC;


-- 2. Zobrazte predpoved pocasia pre jednotlive mesta,
-- kde maximalna teplota dosahuje aspon 25 stupnov.
-- Vypocitajte priemernu teplotu dna.
-- Vysledky zoradte od najvyssiej maximalnej teploty.

SELECT
    c.city_name AS mesto,
    d.calendar_date AS datum,
    wt.description AS pocasie,
    ROUND(((d.min_temperature + d.max_temperature) / 2)::numeric, 1)
        AS priemerna_teplota
FROM weather_forecast_daily d
         JOIN cities c ON d.city_id = c.id
         JOIN weather_types wt ON d.weather = wt.id
WHERE d.max_temperature >= 25
ORDER BY d.max_temperature DESC;


-- 3. Zobrazte hodinovu predpoved pre cas medzi 12:00 a 18:00.
-- Zobrazte nazov mesta, cas, teplotu a hodinu dna.
-- Vysledky zoradte podla datumu a teploty.

SELECT
    c.city_name AS mesto,
    h.start_time AS zaciatok_predpovede,
    h.temperature AS teplota,
    EXTRACT(HOUR FROM h.start_time) AS hodina
FROM weather_forecast_hourly h
         JOIN cities c ON h.city_id = c.id
WHERE EXTRACT(HOUR FROM h.start_time) BETWEEN 12 AND 18
ORDER BY DATE(h.start_time) ASC, h.temperature DESC;


-- 4. Zobrazte druhy pocasia, ktorych nazov obsahuje
-- pismeno "s", bez ohladu na velkost pismen.
-- Zobrazte nazov velkymi pismenami a jeho dlzku.
-- Vysledky zoradte podla dlzky nazvu.

SELECT
    UPPER(description) AS druh_pocasia,
    LENGTH(description) AS dlzka_nazvu
FROM weather_types
WHERE LOWER(description) LIKE '%s%'
ORDER BY LENGTH(description) ASC, description ASC;


-- 5. Zobrazte hodinove predpovede s uvedenou rychlostou vetra.
-- Vypocitajte dlzku predpovede v hodinach.
-- Zobrazte iba predpovede s rychlostou vetra aspon 15 km/h.
-- Vysledky zoradte podla rychlosti vetra zostupne.

SELECT
    c.city_name AS mesto,
    h.start_time AS zaciatok,
    h.wind_speed AS rychlost_vetra,
    ROUND(
            (EXTRACT(EPOCH FROM (h.end_time - h.start_time)) / 3600)::numeric,
            2
    ) AS dlzka_predpovede_hodiny
FROM weather_forecast_hourly h
         JOIN cities c ON h.city_id = c.id
WHERE h.wind_speed >= 15
  AND h.end_time > h.start_time
ORDER BY h.wind_speed DESC, h.start_time ASC;

