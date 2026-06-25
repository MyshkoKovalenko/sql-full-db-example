DROP PROCEDURE IF EXISTS create_flight;

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
        p_departure_airport_id IN (SELECT a.id FROM airports a),
        p_destination_airport_id IN (SELECT a.id FROM airports a),
        p_aircraft_id IN (SELECT a.id FROM aircrafts a),
        p_pilot_id IN (SELECT p.id FROM pilots p),
        p_departure_airport_id != p_destination_airport_id
$$;

CREATE OR REPLACE PROCEDURE register_passenger_on_flight(
    p_passenger_uuid,
    p_flight_id
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
        p_flight_id IN (SELECT f.id FROM flights f),
        p_passenger_uuid IN (SELECT p.uuid FROM passengers p)
$$;