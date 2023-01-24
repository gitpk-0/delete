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