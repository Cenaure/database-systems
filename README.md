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
