CREATE ROLE viewer;
CREATE ROLE flight_creator;
CREATE ROLE passenger_registator;
CREATE ROLE flight_scheduler;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer;
GRANT viewer TO flight_creator;
GRANT viewer TO passenger_registator;
GRANT viewer TO flight_scheduler;

GRANT EXECUTE ON PROCEDURE create_flight(
    p_departure_airport_id INT,
    p_destination_airport_id INT,
    p_aircraft_id INT,
    p_pilot_id INT
) TO flight_creator;

GRANT EXECUTE ON PROCEDURE register_passenger_on_flight(
    p_passenger_uuid UUID,
    p_flight_id INT
) TO passenger_registator;

GRANT EXECUTE ON PROCEDURE schedule_flight(
    p_flight_id INT,
    p_departure_time TIMESTAMP
) TO flight_scheduler;