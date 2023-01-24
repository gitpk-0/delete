CREATE TABLE IF NOT EXISTS detailed (
    customer_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(90),
    rental_id INT,
    rental_date TIMESTAMP,
    return_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS summary (
    customer_full_name VARCHAR(91),
    email VARCHAR(90),
    rental_transactions INT
);