DROP PROCEDURE IF EXISTS create_flight;
DROP PROCEDURE IF EXISTS register_passenger_on_flight;
DROP PROCEDURE IF EXISTS schedule_flight;

CREATE OR REPLACE PROCEDURE create_flight(
    p_departure_airport_id INT,
    p_destination_airport_id INT,
    p_aircraft_id INT,
    p_pilot_id INT
)
LANGUAGE SQL
AS $$
    INSERT INTO flights (
        departure_airport_id,
        destination_airport_id,
        aircraft_id,
        pilot_id,
        passenger_count
    )
    SELECT
        p_departure_airport_id,
        p_destination_airport_id,
        p_aircraft_id,
        p_pilot_id,
        0
    WHERE
        p_departure_airport_id IN (SELECT a.id FROM airports a) AND
        p_destination_airport_id IN (SELECT a.id FROM airports a) AND
        p_aircraft_id IN (SELECT a.id FROM aircrafts a) AND
        p_pilot_id IN (SELECT p.id FROM pilots p) AND
        p_departure_airport_id != p_destination_airport_id;
$$;

CREATE OR REPLACE PROCEDURE register_passenger_on_flight(
    p_passenger_uuid UUID,
    p_flight_id INT
)
LANGUAGE SQL
AS $$
    INSERT INTO flight_passengers (
        flight_id,
        passenger_uuid
    )
    SELECT
        p_flight_id,
        p_passenger_uuid
    WHERE
        p_flight_id IN (SELECT f.id FROM flights f) AND
        p_passenger_uuid IN (SELECT p.uuid FROM passengers p) AND
        p_passenger_uuid NOT IN (SELECT fp.passenger_uuid FROM flight_passengers fp WHERE fp.flight_id = p_flight_id) AND
        (
            SELECT
                f.passenger_count
            FROM flights f
            WHERE f.id = p_flight_id
            LIMIT 1
        ) < (
                SELECT
                    am.max_passengers
                FROM flights f
                JOIN aircrafts a ON a.id = f.aircraft_id
                JOIN aircraft_models am ON am.id = a.model_id
                WHERE f.id = p_flight_id
                LIMIT 1
        )
$$;

CREATE OR REPLACE PROCEDURE schedule_flight (
    p_flight_id INT,
    p_departure_time TIMESTAMP
)
LANGUAGE SQL
AS $$
    DELETE FROM schedule s WHERE s.flight_id = p_flight_id;

    INSERT INTO schedule (
        departure_time,
        flight_id
    )
    SELECT
        p_departure_time,
        p_flight_id
    WHERE
        p_flight_id IN (SELECT f.id FROM flights f)
$$;