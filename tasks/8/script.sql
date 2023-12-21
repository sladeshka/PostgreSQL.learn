-- paragraph 1
-- paragraph 1.1, 1.2, 1.3, 1.4, 1.5
CREATE OR REPLACE VIEW share_details.v_current_shares
 AS
SELECT
    share_id, -- paragraph 2.1
    share_desc, 
    share_ticker_id, 
    current_price AS "Last Price"
FROM share_details.shares
WHERE current_price > 0::numeric -- paragraph 2.1
ORDER BY share_desc;

ALTER TABLE share_details.v_current_shares
    OWNER TO learn;

-- paragraph 2
-- paragraph 2.2
CREATE OR REPLACE VIEW share_details.v_share_prices
 AS
SELECT 
    sp.share_id, 
    sp.price, 
    sp.price_date,
    vcs.share_desc
FROM share_details.share_prices AS sp
INNER JOIN share_details.v_current_shares AS vcs
    ON sp.share_id = vcs.share_id
ORDER BY vcs.share_desc, sp.price_date DESC;

ALTER TABLE share_details.v_current_shares
    OWNER TO learn;

-- paragraph 2.3
-- INSERT INTO share_details.share_prices
-- (
--     share_id, 
--     price, 
--     price_date
-- )
-- OVERRIDING SYSTEM VALUE
-- VALUES
--     (1, 2.155,'2023-08-01 10:10:00'),
--     (1, 2.2125, '2023-08-01 10:12:00'),
--     (1, 2.4175, '2023-08-01 10:16:00'),
--     (1, 2.21, '2023-08-01 11:22:00'),
--     (1, 2.17, '2023-08-01 14:54:00'),
--     (1, 2.34125, '2023-08-01 16:10:00'),
--     (2, 41.10, '2023-08-01 10:10:00'),
--     (2, 43.22, '2023-08-02 10:10:00'),
--     (2, 45.20, '2023-08-03 10:10:00')
-- ;

INSERT INTO share_details.shares
(
    share_desc, 
    share_ticker_id, 
    current_price
)
VALUES 
(
    'FAT-BELLY.COM', 
    'FBC', 
    45.2000
);

-- paragraph 2.4
SELECT * FROM share_details.v_share_prices;

-- paragraph 3
CREATE OR REPLACE VIEW customer_details.v_custtrans
    AS
SELECT
    c.account_number,
    c.customer_firstname,
    c.customer_other_initials,
    tt.transaction_description,
    t.date_entered,
    t.amount,
    t.reference_details
FROM customer_details.customers AS c
JOIN transaction_details.transactions AS t
    ON t.customer_id = c.customer_id
JOIN transaction_details.transaction_types AS tt
    ON tt.transaction_types_id = t.transaction_type
ORDER BY c.account_number ASC, t.date_entered DESC;

-- paragraph 4
-- paragraph 4.1
INSERT INTO customer_details.financial_products
    (
        productid,
        product_name
    )
VALUES
    (1, 'Regular Savings'),
    (2, 'Bonds Account'),
    (3, 'Share Account'),
    (4, 'Life Insurance')
;

-- INSERT INTO customer_details.customers_products
--     (
--         customer_id,
--         financial_product_id,
--         amount_to_collect,
--         frequency, 
--         last_collected, 
--         last_collection, 
--         renewable
--     )
-- VALUES
--     (1, 1, 200, 1, '31.08.2021', '31.08.2035', false),
--     (1, 2, 50, 1, '24.08.2023', '24 March 2025', false),
--     (2, 4, 150, 3, '20.08.2023', '20.08.2025', true),
--     (3, 3, 500, 0, '24.08.2023', '24.08.2025', true);

-- paragraph 4.2, 4.3
DROP VIEW IF EXISTS customer_details.v_cust_fin_products;
CREATE VIEW customer_details.v_cust_fin_products
    AS 
SELECT
    c.customer_firstname || ' ' || c.customer_lastname AS customer_name,
    c.account_number,
    fp.product_name, 
    cp.amount_to_collect,
    cp.frequency, 
    cp.last_collected
FROM customer_details.customers AS c
JOIN customer_details.customers_products AS cp
    ON cp.customer_id = c.customer_id
JOIN customer_details.financial_products AS fp
    ON fp.productid = cp.financial_product_id;

SELECT * FROM customer_details.v_cust_fin_products;

-- paragraph 4.4
ALTER TABLE customer_details.customers
    ALTER COLUMN customer_firstname TYPE varchar(100);

-- paragraph 5
-- paragraph 5.1, 5.2
DROP VIEW IF EXISTS customer_details.v_cust_fin_products;
CREATE MATERIALIZED VIEW customer_details.v_cust_fin_products
    AS 
SELECT
    c.customer_firstname || ' ' || c.customer_lastname AS customer_name,
    c.account_number,
    fp.product_name, 
    cp.amount_to_collect,
    cp.frequency, 
    cp.last_collected
FROM customer_details.customers AS c
JOIN customer_details.customers_products AS cp
    ON cp.customer_id = c.customer_id
JOIN customer_details.financial_products AS fp
    ON fp.productid = cp.financial_product_id;

-- paragraph 5.3
UPDATE customer_details.customers
SET customer_lastname = 'Brusten'
WHERE customer_lastname = 'Brust';
SELECT * FROM customer_details.customers;

SELECT * FROM customer_details.v_cust_fin_products;

REFRESH MATERIALIZED VIEW customer_details.v_cust_fin_products;
SELECT * FROM customer_details.v_cust_fin_products;