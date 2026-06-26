TRUNCATE TABLE flights RESTART IDENTITY CASCADE;
TRUNCATE TABLE flight_passengers RESTART IDENTITY CASCADE;
TRUNCATE TABLE schedule RESTART IDENTITY CASCADE;

CALL create_flight(1, 2, 3, 1);
CALL create_flight(3, 1, 1, 2); 
CALL create_flight(2, 3, 2, 1); 

CALL register_passenger_on_flight(get_random_passenger_uuid(), 1);
CALL register_passenger_on_flight(get_random_passenger_uuid(), 2);
CALL register_passenger_on_flight(get_random_passenger_uuid(), 1);

CALL schedule_flight(1, '2026-06-27 12:40:00');
CALL schedule_flight(2, '2026-06-28 03:20:00');
CALL schedule_flight(1, '2026-06-29 13:45:00');

SELECT * FROM schedule_view;

EXPLAIN ANALYZE
SELECT * FROM top_10_passengers;