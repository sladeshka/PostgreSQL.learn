DROP SCHEMA customer_details CASCADE;
CREATE SCHEMA customer_details AUTHORIZATION learn;
-- paragraph 1
-- paragraph 1.1, 1.2, 1.3
DROP TABLE IF EXISTS customer_details.сustomers;
CREATE TABLE IF NOT EXISTS customer_details.сustomers (
    customer_id BIGINT NOT NULL PRIMARY KEY,
    customer_title_id INTEGER NOT NULL,
    customer_firstname VARCHAR(50) NOT NULL,
    customer_other_initials VARCHAR(10) NULL,
    customer_lastname VARCHAR(50) NOT NULL,
    address_id BIGINT NOT NULL,
    account_number CHAR(15) NOT NULL,
    account_type_id INTEGER NOT NULL,
    clear_balance MONEY NOT NULL,
    uncleared_balance MONEY NOT NULL,
    date_added DATE NOT NULL
);

-- paragraph 1.4
DROP SEQUENCE IF EXISTS customer_details.сustomers_serial;
CREATE SEQUENCE customer_details.сustomers_serial
    AS BIGINT 
    START 1
    OWNED BY
    customer_details.сustomers.customer_id;

-- paragraph 1.5
ALTER TABLE customer_details.сustomers
    ALTER date_added SET DEFAULT CURRENT_DATE;

-- paragraph 2
-- paragraph 2.1, 2.2, 2.3, 2.4
DROP TABLE IF EXISTS transaction_details.transactions;
CREATE TABLE transaction_details.transactions (
    transaction_id BIGINT GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1) PRIMARY KEY NOT NULL,
    customer_id BIGINT NOT NULL,
    transaction_type INTEGER NOT NULL,
    date_entered TIMESTAMP(0) NOT NULL,
    amount NUMERIC(18,5) NOT NULL,
    reference_details VARCHAR(50) NULL,
    notes VARCHAR NULL,
    related_share_id BIGINT NULL,
    related_product_id BIGINT NOT NULL
);

SELECT * FROM transaction_details.transactions;

-- paragraph 2.5
DROP TABLE IF EXISTS transaction_details.transaction_types;
CREATE TABLE transaction_details.transaction_types (
    transaction_types_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
    transaction_description varchar(30) NOT NULL,
    credit_type boolean NOT NULL
);

SELECT * FROM transaction_details.transaction_types;

-- paragraph 3
-- paragraph 3.1
ALTER TABLE transaction_details.transaction_types
    ADD affect_cash_balance BOOLEAN NULL;

SELECT * FROM transaction_details.transaction_types;

-- paragraph 3.2
ALTER TABLE transaction_details.transaction_types
    ALTER affect_cash_balance SET NOT NULL;

-- paragraph 3.3, 3.4
ALTER TABLE transaction_details.transaction_types
    ADD CONSTRAINT pk_transaction_types PRIMARY KEY (transaction_types_id);

SELECT * FROM transaction_details.transaction_types;

-- paragraph 4
DROP TABLE IF EXISTS customer_details.customers_products;
CREATE TABLE customer_details.customers_products (
    customer_financial_product_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
    customer_id BIGINT NOT NULL,
    financial_product_id BIGINT NOT NULL,
    amount_to_collect MONEY NOT NULL,
    frequency INT NOT NULL,
    lastcollected TIMESTAMP(0) NOT NULL,
    last_collection TIMESTAMP(0) NOT NULL,
    renewable BOOLEAN NOT NULL
);

SELECT * FROM customer_details.customers_products;

DROP TABLE IF EXISTS customer_details.financial_products;
CREATE TABLE customer_details.financial_products (
    productid BIGINT NOT NULL,
    product_name VARCHAR(50) NOT NULL
);

DROP SCHEMA share_details CASCADE;
CREATE SCHEMA share_details AUTHORIZATION learn;

DROP TABLE IF EXISTS share_details.share_prices;
CREATE TABLE share_details.share_prices (
    share_price_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
    share_id BIGINT NOT NULL,
    price NUMERIC(18,5) NOT NULL,
    price_date TIMESTAMP(0) NOT NULL
);

SELECT * FROM share_details.share_prices;

DROP TABLE IF EXISTS share_details.shares;
CREATE TABLE share_details.shares (
    share_id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    share_desc VARCHAR(50) NOT NULL,
    share_ticker_id VARCHAR(50) NULL,
    current_price NUMERIC(18,5) NOT NULL
);

SELECT * FROM share_details.shares;

-- paragraph 5
ALTER TABLE transaction_details.transactions
    ADD CONSTRAINT fk_customers_transactions FOREIGN KEY (customer_id)
    REFERENCES customer_details.сustomers(customer_id);

-- paragraph 6
ALTER TABLE transaction_details.transactions
    ADD CONSTRAINT fk_transactions_shares FOREIGN KEY (related_share_id)
    REFERENCES share_details.shares(share_id);


-- if all ok return OK
DROP FUNCTION show_message_ok;
CREATE FUNCTION show_message_ok()
RETURNS text
LANGUAGE 'sql'
AS $$ 
select 'OK';
$$;

select show_message_ok();