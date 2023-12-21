
-- paragraph 4
SELECT * FROM customer_details.customers;

SELECT 
    customer_firstname "First Name", 
    customer_lastname "Last Name", 
    clear_balance
FROM 
    customer_details.customers;

-- paragraph 5
UPDATE customer_details.customers
SET customer_lastname = 'Brodie'
WHERE customer_id = 4;

DO
$$
DECLARE
    ValueToUpdate VARCHAR(30);
BEGIN
    ValueToUpdate := 'McGlynn';
    UPDATE customer_details.customers
    SET customer_lastname = ValueToUpdate,
    clear_balance = clear_balance + uncleared_balance,
    uncleared_balance = 0
    WHERE customer_lastname = 'Brodie';
END
$$;

DO
$$
DECLARE
    WrongDataType VARCHAR(20) := '4311,22';
BEGIN
    UPDATE customer_details.customers
    SET clear_balance = WrongDataType::money
    WHERE customer_id = 4;
END
$$;

-- paragraph 6
-- paragraph 6.1, 6.2
CREATE TEMPORARY TABLE IF NOT EXISTS 
    temp_customers
AS SELECT
    customer_id,
    customer_firstname,
    customer_other_initials,
    customer_lastname
FROM customer_details.customers
WITH NO DATA;
SELECT * FROM temp_customers;

-- paragraph 6.3
DELETE FROM temp_customers
WHERE customer_id = 4;

-- paragraph 6.4, 6.5
INSERT INTO temp_customers
    (
    customer_id,
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        null,
        'Dmitry',
        'J',
        'Vetrov'
    )
;
SELECT * FROM temp_customers;

-- paragraph 6.6
DELETE FROM temp_customers
WHERE customer_id IS Null;

ALTER TABLE temp_customers
ALTER COLUMN customer_id
SET NOT NULL;

ALTER TABLE temp_customers
ALTER COLUMN customer_id
ADD GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 7);

INSERT INTO temp_customers
    (
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        'Dmitry',
        'J',
        'Vetrov'
    )
;
SELECT * FROM temp_customers;

-- paragraph 6.7
DELETE FROM temp_customers;
INSERT INTO temp_customers
    (
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        'Dmitry',
        'J',
        'Vetrov'
    )
;
-- paragraph 6.8
TRUNCATE TABLE temp_customers;
INSERT INTO temp_customers
    (
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        'Dmitry',
        'J',
        'Vetrov'
    )
;
-- paragraph 6.9
TRUNCATE TABLE temp_customers RESTART IDENTITY;
INSERT INTO temp_customers
    (
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        'Dmitry',
        'J',
        'Vetrov'
    )
;
SELECT * FROM temp_customers;
-- paragraph 6.10
ALTER TABLE temp_customers
ALTER COLUMN customer_id
DROP IDENTITY;

ALTER TABLE temp_customers
ALTER COLUMN customer_id
ADD GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1);

TRUNCATE TABLE temp_customers RESTART IDENTITY;
INSERT INTO temp_customers
    (
    customer_firstname,
    customer_other_initials,
    customer_lastname
    )
VALUES
    (
        'Dmitry',
        'J',
        'Vetrov'
    )
;

-- not ok !!!!
CREATE OR REPLACE FUNCTION show_message_ok()
RETURNS TEXT
LANGUAGE SQL
RETURN 'OK';

SELECT show_message_ok();