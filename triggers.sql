DROP FUNCTION IF EXISTS update_passenger_count CASCADE;
DROP TRIGGER IF EXISTS t_update_passenger_count ON passenger_count;

CREATE OR REPLACE FUNCTION update_passenger_count()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
    BEGIN

    UPDATE flights f SET passenger_count = (
        SELECT
            COALESCE(COUNT(DISTINCT fp.passenger_uuid), 0) as passengers_count
        FROM flights f
        LEFT JOIN flight_passengers fp ON f.id = fp.flight_id
        GROUP BY f.id
        HAVING f.id = NEW.flight_id
        LIMIT 1
    )
        WHERE f.id = NEW.flight_id;
    RETURN NEW;

    COMMIT;
    END;
$$;

CREATE OR REPLACE TRIGGER t_update_passenger_count AFTER
    INSERT OR
    UPDATE OR
    DELETE
ON flight_passengers FOR EACH ROW
EXECUTE FUNCTION update_passenger_count();