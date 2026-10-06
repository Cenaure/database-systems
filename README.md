# SkyCast

 SkyCast je DB na sledovanie aktuálneho počasia. Ukladá údaje o mestách, počasí, teplote, zrážkach a čase merania. Používateľ si môže vybrať mesto a zobraziť počasie. Cieľom je vytvoriť jednoduchú a prehľadnú aplikáciu, ktorá umožní pracovať s meteorologickými údajmi.

```mermaid
erDiagram
    cities {
        serial id PK
        varchar city_name "NOT NULL"
        varchar country
    }

    weather_types {
        serial id PK
        varchar description "NOT NULL"
    }

    weather_forecast_daily {
        int city_id PK, FK
        date calendar_date PK
        int weather FK
        decimal min_temperature "NOT NULL"
        decimal max_temperature "NOT NULL"
        smallint humidity_percent "NOT NULL"
    }

    weather_forecast_hourly {
        int city_id PK, FK
        timestamp start_time PK
        timestamp end_time "NOT NULL"
        int weather FK
        decimal temperature "NOT NULL"
        smallint humidity_percent "NOT NULL"
        smallint wind_speed
        wind_direction_type wind_direction
    }

    cities ||--o{ weather_forecast_daily : "has"
    cities ||--o{ weather_forecast_hourly : "has"
    weather_types ||--o{ weather_forecast_daily : "describes"
    weather_types ||--o{ weather_forecast_hourly : "describes"
```

## Úlohy

### 1. Slnečné mestá
Vypíšte všetky mestá, ktoré majú v denných predpovediach **slnečné počasie**.

**Zobrazte:**
- názov mesta
- typ počasia
- dátum

2. Vypíšte hodinové predpovede v čase od 14:00 do 19:00.
   Zobrazte názov mesta, dátum, časový interval, počasie, teplotu,
   vlhkosť a rýchlosť vetra (v km/h). Výsledky zoraďte podľa času začiatku.

### 2. Hodinové predpovede popoludní
Vypíšte hodinové predpovede v čase **od 14:00 do 19:00**.

**Zobrazte:**
- názov mesta
- dátum
- časový interval
- počasie
- teplotu
- vlhkosť
- rýchlosť vetra (v km/h)

**Zoradenie:** podľa času začiatku.

### 3. Priemerná teplota
Vypíšte priemernú teplotu pre jednotlivé mestá. 

**Zobrazte:**
- mesto
- dátum
- počasie
- priemernú
- teplotu 
- vlhkosť

**Zoradenie:** podľa priemernej teploty zostupne.

### 4. Hodinové predpovede vyššie ako 20 °C
Vypíšte hodinové predpovede, pri ktorých je teplota vyššia ako 20 °C.

**Zobrazte:**
- mesto
- dátum
- počasie
- teplotu

**Zoradenie:** podľa teploty zostupne.

### 5. Slnečné počasie
Vypíšte všetky mestá, ktoré majú v denných predpovediach slnečné počasie.
**Zobrazte:**
- názov mesta
- typ počasia 
- dátum

**Zoradenie:** podľa názvu mesta.
