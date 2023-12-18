-- paragraph 1
-- paragraph 1.1, 1.2, 1.3, 1.4, 1.5, 
CREATE UNIQUE INDEX IF NOT EXISTS ix_customers_customer_id
    ON customer_details.customers 
    USING btree 
    ( 
        customer_id
        ASC 
        NULLS LAST
    );

-- paragraph 1.6 
SELECT *
FROM pg_indexes
WHERE indexname = 'ix_customers_customer_id';

-- paragraph 2
-- paragraph 2.1
CREATE INDEX IF NOT EXISTS ix_customers_products_id
    ON customer_details.customers_products (
        customer_id
    );

-- paragraph 2.2
SELECT *
FROM pg_indexes
WHERE indexname = 'ix_customers_products_id';

-- paragraph 2.3
CREATE UNIQUE INDEX IF NOT EXISTS ix_transaction_types_id
    ON transaction_details.transaction_types
    USING btree
    (
        transaction_types_id 
        ASC
    );

CREATE INDEX IF NOT EXISTS ix_transactions_types
    ON transaction_details.transactions
    USING btree
    (
        transaction_type 
        ASC
    );

-- paragraph 3
DROP INDEX IF EXISTS transaction_details.ix_transactions_types CASCADE;

SELECT *
FROM pg_indexes
WHERE indexname not like 'pg%';

CREATE INDEX IF NOT EXISTS ix_transactions_types
    ON transaction_details.transactions
    USING btree
    (
        transaction_type 
        ASC
    );

-- paragraph 4
-- paragraph 4.1
CREATE UNIQUE INDEX IF NOT EXISTS ix_share_prices
    ON share_details.share_prices
    (
        share_id
        ASC,
        price_date
        ASC
    );
DROP INDEX IF EXISTS share_details.ix_share_prices CASCADE;

-- paragraph 4.2, 4.3
CREATE UNIQUE INDEX 
    --IF EXISTS 
    ix_share_prices
    ON share_details.share_prices
    (
        share_id
        ASC,
        price_date
        DESC,
        price
    );

-- if all ok return OK
DROP FUNCTION show_message_ok;
CREATE FUNCTION show_message_ok()
RETURNS text
LANGUAGE 'sql'
AS $$ 
select 'OK';
$$;

select show_message_ok();