DROP VIEW IF EXISTS schedule_view;
DROP VIEW IF EXISTS top_10_passengers;

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
    ORDER BY s.departure_time DESC;

CREATE OR REPLACE VIEW top_10_passengers AS
    SELECT
        p.uuid,
        p.first_name,
        p.phone_number,
        COUNT(DISTINCT fp.flight_id) as total_flights
    FROM passengers p
    JOIN flight_passengers fp ON fp.passenger_uuid = p.uuid
    GROUP BY p.uuid
    HAVING COUNT(DISTINCT fp.flight_id) > 0
    ORDER BY total_flights DESC
    LIMIT 10;