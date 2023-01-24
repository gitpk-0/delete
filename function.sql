CREATE FUNCTION refresh_summary_function()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $REFRESH_SUMMARY_FUNCTION$
BEGIN


DELETE FROM summary;


INSERT INTO summary (
SELECT
   CONCAT(first_name, ' ', last_name) AS customer_full_name,
   email,
   COUNT(customer_id)
FROM detailed
GROUP BY customer_id, customer_full_name, email
HAVING COUNT(customer_id) > 5
ORDER BY COUNT(customer_id) DESC
LIMIT 250
);


RETURN NEW;


END; $REFRESH_SUMMARY_FUNCTION$