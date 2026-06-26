DROP FUNCTION IF EXISTS get_random_passenger_uuid;

CREATE OR REPLACE FUNCTION get_random_passenger_uuid()
RETURNS UUID
LANGUAGE SQL
AS $$
    SELECT
        p.uuid
    FROM passengers p
    ORDER BY RANDOM()
    LIMIT 1
$$;