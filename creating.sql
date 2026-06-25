DROP TABLE IF EXISTS passengers CASCADE;
DROP TABLE IF EXISTS aircraft_models CASCADE;
DROP TABLE IF EXISTS pilots CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS airports CASCADE;
DROP TABLE IF EXISTS aircrafts CASCADE;
DROP TABLE IF EXISTS flight_passengers CASCADE;
DROP TABLE IF EXISTS flights CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;

CREATE TABLE IF NOT EXISTS passengers (
    uuid UUID PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS aircraft_models (
    id SERIAL PRIMARY KEY,
    model VARCHAR(50),
    manufacturer VARCHAR(50),
    max_passengers INT
);

CREATE TABLE IF NOT EXISTS pilots (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(50),
    salary INT
);

CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    lattitude FLOAT,
    longitude FLOAT
);

CREATE TABLE IF NOT EXISTS airports (
    id SERIAL PRIMARY KEY,
    code VARCHAR,
    location_id INT REFERENCES locations(id)
);

CREATE TABLE IF NOT EXISTS aircrafts (
    id SERIAL PRIMARY KEY,
    model_id INT REFERENCES aircraft_models(id),
    tail_number VARCHAR,
    location_airport_id INT REFERENCES airports(id)
);

CREATE TABLE IF NOT EXISTS flights (
    id SERIAL PRIMARY KEY,
    departure_airport_id INT REFERENCES airports(id),
    destination_airport_id INT REFERENCES airports(id),
    aircraft_id INT REFERENCES aircrafts(id),
    pilot_id INT REFERENCES pilots(id),
    passenger_count INT
);

CREATE TABLE IF NOT EXISTS flight_passengers (
    id SERIAL PRIMARY KEY,
    flight_id INT REFERENCES flights(id),
    passenger_uuid UUID REFERENCES passengers(uuid)
);

CREATE TABLE IF NOT EXISTS schedule (
    id SERIAL PRIMARY KEY,
    departure_time TIMESTAMP,
    flight_id INT REFERENCES flights(id)
);