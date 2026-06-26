TRUNCATE TABLE passengers RESTART IDENTITY CASCADE;
TRUNCATE TABLE aircraft_models RESTART IDENTITY CASCADE;
TRUNCATE TABLE pilots RESTART IDENTITY CASCADE;
TRUNCATE TABLE locations RESTART IDENTITY CASCADE;
TRUNCATE TABLE airports RESTART IDENTITY CASCADE;
TRUNCATE TABLE aircrafts RESTART IDENTITY CASCADE;
TRUNCATE TABLE flight_passengers RESTART IDENTITY CASCADE;
TRUNCATE TABLE flights RESTART IDENTITY CASCADE;
TRUNCATE TABLE schedule RESTART IDENTITY CASCADE;

INSERT INTO aircraft_models (model, manufacturer, max_passengers) VALUES
('737-800', 'Boeing', 189),
('A320neo', 'Airbus', 180),
('E195', 'Embraer', 124);

INSERT INTO pilots (first_name, last_name, email, phone_number, salary) VALUES
('John', 'Doe', 'john.doe@airline.com', '+1-555-0199', 120000),
('Jane', 'Smith', 'jane.smith@airline.com', '+1-555-0145', 135000),
('Alex', 'Jones', 'alex.jones@airline.com', '+1-555-0172', 95000);

INSERT INTO locations (lattitude, longitude) VALUES
(40.6413, -73.7781),
(33.6407, -84.4277),
(51.4700, -0.4543);

INSERT INTO airports (code, location_id) VALUES
('JFK', 1),
('ATL', 2),
('LHR', 3);

INSERT INTO aircrafts (model_id, tail_number, location_airport_id) VALUES
(1, 'N123AA', 1),
(2, 'N456DL', 2),
(1, 'G-ABCD', 3),
(3, 'N789UA', 1);

INSERT INTO passengers (uuid, first_name, last_name, phone_number)
SELECT
    gen_random_uuid(),
    'John',
    'Doe #' || i,
    '+1-555-' || i
FROM generate_series(1, 1000000) as i;