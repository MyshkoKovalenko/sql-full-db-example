DROP VIEW IF EXISTS schedule_view;

CREATE OR REPLACE VIEW schedule_view AS
    SELECT
        s.departure_time,
        adpt.code as departure,
        adst.code as destinaiton,
        f.passenger_count
    FROM schedule s
    JOIN flights f ON s.flight_id = f.id
    JOIN airports adpt ON f.departure_airport_id = adpt.id
    JOIN airports adst ON f.destination_airport_id = adst.id
    GROUP BY f.id, s.departure_time, adpt.code, adst.code, f.passenger_count
    ORDER BY s.departure_time DESC