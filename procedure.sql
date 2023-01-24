-- creating the refresh_tables procedure
CREATE PROCEDURE refresh_tables()
LANGUAGE plpgsql
AS $$
BEGIN

-- clearing all data from detailed table (and summary)
DELETE FROM detailed;

-- adding new data back into detailed table
INSERT INTO detailed (
    customer_id,
    first_name,
    last_name,
    email,
    rental_id,
    rental_date,
    return_date
)
SELECT
c.customer_id,
c.first_name,
c.last_name,
c.email,
r.rental_id
r.rental_date
r.return_date
FROM customer as c
INNER JOIN rental as r ON
c.customer_id = r.customer_id;

END;$$

-- calling the stored procedure
CALL refresh_tables();

-- viewing the results of the stored procedure call
SELECT *
FROM detailed;
SELECT *
FROM summary;