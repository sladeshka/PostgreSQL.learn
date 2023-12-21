-- paragraph 1
-- paragraph 1.9
ALTER TABLE IF EXISTS customer_details.customers
    ALTER COLUMN customer_id
    DROP IDENTITY IF EXISTS;
CREATE SEQUENCE IF NOT EXISTS customer_details.customers_customer_id_seq START 1;
ALTER SEQUENCE IF EXISTS customer_details.customers_customer_id_seq RESTART WITH 1;


-- paragraph 1.1, 1.2, 
INSERT INTO 
    share_details.shares
    (
        share_desc,
        share_ticker_id,
        current_price
    )
VALUES
    (
        'ACME''S HOMEBAKE COOKIES INC',
        'AHCI',
        2.34125
    )
;

-- paragraph 1.3
SELECT * 
FROM 
    share_details.shares
;

-- paragraph 1.4, 1.5, 1.6, 1.7
INSERT INTO 
    customer_details.customers
    (
        customer_id,
        customer_title_id,
        customer_firstname,
        customer_other_initials,
        customer_lastname,
        address_id,
        account_number,
        account_type_id,
        clear_balance,
        uncleared_balance --, date_added
    )
VALUES
    (
        (SELECT coalesce(max(customer_id)+1, 1) FROM customer_details.customers),
        123,
        'Dmitry',
        NULL,
        'Vetrov',
        '123',
        123,
        123,
        123.10,
        123.10
    );

SELECT * 
FROM 
    customer_details.customers
;

-- paragraph 1.8
INSERT INTO 
    customer_details.customers
    (
        customer_id,
        customer_title_id,
        customer_lastname,
        customer_firstname,
        customer_other_initials,
        address_id,
        account_number,
        account_type_id,
        clear_balance,
        uncleared_balance
    )
VALUES
    (
        (SELECT coalesce(max(customer_id)+1, 1) FROM customer_details.customers),
        3,
        'Lobel',
        'Leonard',
        NULL,
        145,
        53431993,
        1,
        437.97,
        -10.56
    )
;

TRUNCATE TABLE customer_details.customers CASCADE;

DELETE FROM  customer_details.customers
WHERE customer_id = 5;

ALTER TABLE IF EXISTS customer_details.customers
    ALTER COLUMN customer_firstname TYPE VARCHAR(50),
    ALTER COLUMN customer_other_initials TYPE VARCHAR(10),
    ALTER COLUMN customer_lastname TYPE VARCHAR(50),
    ALTER COLUMN account_number TYPE CHAR(15);

INSERT INTO 
    customer_details.customers
    (
        customer_id,
        customer_title_id,
        customer_lastname,
        customer_firstname,
        customer_other_initials,
        address_id,
        account_number,
        account_type_id,
        clear_balance,
        uncleared_balance
    )
VALUES
    (
        (SELECT coalesce(max(customer_id)+1, 1) FROM customer_details.customers),
        3,
        'Lobel',
        'Leonard',
        NULL,
        145,
        53431993,
        1,
        437.97,
        -10.56
    );

-- paragraph 1.8, 1.9
SELECT * 
FROM 
    customer_details.customers
;

ALTER TABLE IF EXISTS customer_details.customers
    ALTER COLUMN customer_id
    DROP IDENTITY IF EXISTS;

UPDATE customer_details.customers
SET customer_id = 1;

SELECT * 
FROM 
    customer_details.customers
;

ALTER TABLE IF EXISTS customer_details.customers
    ALTER COLUMN customer_id
    ADD GENERATED ALWAYS AS IDENTITY;

-- GOOD
INSERT INTO 
    customer_details.customers
    (
        customer_id, -- has error without
        customer_title_id,
        customer_lastname,
        customer_firstname,
        customer_other_initials,
        address_id,
        account_number,
        account_type_id,
        clear_balance,
        uncleared_balance
    )
OVERRIDING SYSTEM VALUE
VALUES
    (
        (SELECT coalesce(max(customer_id)+1, 1) FROM customer_details.customers), -- has error without
        1,
        'Brust',
        'Andrew',
        'J.',
        133,
        18176111,
        1,
        200.00,
        2.00
    ),
    (
        (SELECT coalesce(max(customer_id)+2, 1) FROM customer_details.customers), -- has error without
        3,
        'Lobel',
        'Leonard',
        NULL,
        145,
        53431993,
        1,
        437.97,
        -10.56
    )
;

SELECT * 
FROM 
    customer_details.customers
;

ALTER SEQUENCE IF EXISTS customer_details.customers_customer_id_seq RESTART WITH 1;

INSERT INTO 
    customer_details.customers
    (
        customer_id, -- has error without
        customer_title_id,
        customer_lastname,
        customer_firstname,
        customer_other_initials,
        address_id,
        account_number,
        account_type_id,
        clear_balance,
        uncleared_balance
    )
OVERRIDING SYSTEM VALUE
VALUES
    (
        (SELECT coalesce(max(customer_id)+1, 1) FROM customer_details.customers), -- has error without
        1,
        'Brust',
        'Andrew',
        'J.',
        133,
        18176111,
        1,
        200.00,
        2.00
    ), (
        (SELECT coalesce(max(customer_id)+2, 1) FROM customer_details.customers), -- has error without
        3,
        'Lobel',
        'Leonard',
        NULL,
        145,
        53431993,
        1,
        437.97,
        -10.56
    )
;

SELECT * 
FROM 
    customer_details.customers
;

-- paragraph 2
-- paragraph 2.1, 2.2
ALTER TABLE customer_details.customers_products 
    DROP CONSTRAINT IF EXISTS pk_customers_products;

ALTER TABLE customer_details.customers_products
ADD CONSTRAINT pk_customers_products
PRIMARY KEY (customer_financial_product_id);

ALTER TABLE customer_details.customers_products 
    DROP CONSTRAINT IF EXISTS ck_custprods_amtcheck;

ALTER TABLE customer_details.customers_products
ADD CONSTRAINT ck_custprods_amtcheck
CHECK (amount_to_collect > 0::money);

ALTER TABLE customer_details.customers_products
ALTER COLUMN renewable
SET DEFAULT false;

-- paragraph 2.3
ALTER TABLE customer_details.customers_products
    DROP CONSTRAINT IF EXISTS pk_customers_products;

ALTER TABLE customer_details.customers_products
ADD CONSTRAINT pk_customers_products
CHECK (last_collection >= last_collected);

-- paragraph 2.4
INSERT INTO 
    customer_details.customers_products
    (
    customer_id,
    financial_product_id,
    amount_to_collect,
    frequency,
    last_collected,
    last_collection,
    renewable
    )
VALUES 
    (
        1, 
        1, 
        100, -- -100
        0, 
        '2023-08-24', 
        '2023-08-24', 
        false
    ), (
        2, 
        1, 
        100, 
        0, 
        '2023-08-24', 
        '2023-08-24', 
        false
    )
;
ALTER TABLE customer_details.customers
    ALTER COLUMN customer_id
    ADD GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 8);

-- paragraph 3
INSERT INTO 
    customer_details.customers
    (
        customer_title_id, 
        customer_firstname, 
        customer_other_initials,
        customer_lastname, 
        address_id, 
        account_number,
        account_type_id, 
        clear_balance, 
        uncleared_balance
    )
VALUES 
    (
        3, 
        'Bernie', 
        'I', 
        'McGee', 
        314, 
        65368765, 
        1, 
        6653.11, 
        0.00
    ), (
        2, 
        'Julie', 
        'A',
        'Dawson', 
        2134, 
        81625422, 
        1, 
        53.32, 
        -12.21
    ), (
        1, 
        'Kirsty', 
        NULL,
        'Null', 
        4312, 
        96565334, 
        1, 
        1266.00, 
        10.32
    )
;

INSERT INTO 
    share_details.shares
    (
        share_desc, 
        share_ticker_id,
        current_price
    )
VALUES 
    (
        'FAT-BELLY.COM ',
        'FBC',
        45.20
    ),
    (
        'NetRadio Inc',
        'NRI',
        29.79
    ),
    (
        'Texas Oil Industries',
        'TAI',
        0.455
    ),
    (
        'London Bridge Club',
        'LBC',
        1.46
    )
;

-- after exeprion!!!!

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