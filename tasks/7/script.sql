-- paragraph 1
-- paragraph 1.9
ALTER TABLE IF EXISTS customer_details.customers
    ALTER COLUMN customer_id
    DROP IDENTITY IF EXISTS;

ALTER SEQUENCE IF EXISTS customer_details.customers_customer_id_seq RESTART WITH 0;


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
    );

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
        12,
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

INSERT INTO 
    customer_details.customers
    (
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

ALTER SEQUENCE customer_details.customers_customer_id_seq RESTART WITH 0;

INSERT INTO 
    customer_details.customers
    (
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