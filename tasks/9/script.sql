-- paragraph 1
CREATE OR REPLACE FUNCTION 
    transaction_details.fn_int_calc
    (
        amount DECIMAL(18,5),
        fromDate DATE,
        toDate DATE,
        itnterestRate DECIMAL(6,3)=10
    )
RETURNS DECIMAL(18,5)
SECURITY INVOKER
AS 
$$
    DECLARE
        intCalculated DECIMAL(18,5);
    BEGIN
        IntCalculated := amount * (itnterestRate / 100.00) * (EXTRACT(DAY FROM toDate::TIMESTAMP-fromDate::TIMESTAMP)/365.00);
        RETURN COALESCE(IntCalculated, 0);
    END;
$$ LANGUAGE plpgsql;

SELECT transaction_details.fn_int_calc(2000, '2023-03-01', '2023-03-10',10);

-- paragraph 2
CREATE OR REPLACE FUNCTION 
    transaction_details.fn_return_transactions 
    (
        custID BIGINT
    )
RETURNS TABLE 
    (
        transaction_id BIGINT,
        customer_id BIGINT,
        transaction_description VARCHAR(30),
        date_entered TIMESTAMP(0),
        amount MONEY
    )
SECURITY INVOKER
AS 
$$
SELECT
    t.transaction_id as transaction_id,
    t.customer_id as customer_id,
    tt.transaction_description as transactiondescription,
    t.date_entered as date_entered,
    t.amount as amount
FROM transaction_details.transactions t
JOIN transaction_details.transaction_types tt
    ON tt.transaction_types_id = t.transaction_type
WHERE t.customer_id = custID;
$$ LANGUAGE sql;

INSERT INTO transaction_details.transactions
    (
        customer_id, 
        transaction_type, 
        date_entered, 
        amount,
        related_product_id
    )
VALUES
    (1, 1, '2023-08-01', 100.00, 1),
    (1, 1, '2023-08-03', 75.67, 1),
    (1, 2, '2023-08-05', 35.20, 1),
    (1, 2, '2023-08-06', 20.00, 1);

INSERT INTO transaction_details.transaction_types
    (
        transaction_description, 
        credit_type, 
        affect_cash_balance
    )
VALUES
    ('proc+', true, true),
    ('proc-', false, true);

SELECT transaction_details.fn_return_transactions(1);

SELECT
    c.customer_firstname,
    c.customer_lastname,
    trans.transaction_id,
    trans.transaction_description,
    trans.date_entered,
    trans.amount
FROM customer_details.customers AS c
JOIN transaction_details.fn_return_transactions(c.customer_id) AS trans
    on c.customer_id = trans.customer_id;

-- paragraph 3
CREATE PROCEDURE 
    customer_details.spy_inc_customer
    (
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        CustTitle INT,
        CustInitials VARCHAR(10),
        AddressId INT,
        AccountNumber VARCHAR(15),
        AccountTypeId INT
    )
LANGUAGE plpgsql
AS 
$$
BEGIN
INSERT INTO customer_details.customers 
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
    CustTitle,
    FirstName,
    CustInitials,
    LastName,
    AddressId,
    AccountNumber,
    AccountTypeId,
    0,
    0) ;
END;
$$;

CALL customer_details.spy_inc_customer
    (
    'Henry','Williams',1,NULL,431,'22067531',1
    );
CALL customer_details.spy_inc_customer
    (
    CustTitle := 1,
    FirstName := 'Julia',
    CustInitials := 'A',
    LastName := 'Dawson',
    AddressId := 643,
    AccountNumber := 'SS865',
    AccountTypeId := 7
    );

-- paragraph 4
-- paragraph 4.1
CREATE OR REPLACE FUNCTION customer_details.fn_ins_transactions()
RETURNS TRIGGER
AS 
$$
BEGIN
    UPDATE customer_details.customers
    SET clear_balance = c.clear_balance +
    (
        SELECT
            CASE
                WHEN tt.credit_type = false THEN (i.amount * -1)::money
                ELSE (i.amount)::money
            END
        FROM NEW AS i
        JOIN transaction_details.transaction_types AS tt
            ON tt.transaction_types_id = i.transaction_type
        WHERE tt.affect_cash_balance = true 
    )
    FROM customer_details.customers AS c
    JOIN NEW AS i
        ON i.customer_id = c.customer_id;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- paragraph 4.2
CREATE OR REPLACE TRIGGER tg_instransactions
    AFTER INSERT ON transaction_details.transactions
    REFERENCING NEW TABLE AS NEW
    FOR EACH ROW EXECUTE FUNCTION customer_details.fn_ins_transactions();

-- paragraph 4.3
SELECT clear_balance FROM customer_details.customers WHERE customer_id=1;
INSERT INTO transaction_details.transactions
    (
        customer_id,
        transaction_type,
        amount,
        related_product_id,
        date_entered
    )
VALUES 
    (
        1, 
        2, 
        200, 
        1, 
        current_date
    )
;

SELECT clear_balance FROM customer_details.customers WHERE customer_id=1;

-- paragraph 4.4
INSERT INTO transaction_details.transactions
    (
        customer_id,
        transaction_type,
        amount,
        related_product_id,
        date_entered
    )
VALUES 
    (
        1, 
        3, 
        200, 
        1, 
        current_date
    )
;

-- paragraph 5
CREATE OR REPLACE FUNCTION customer_details.fn_ins_transactions()
RETURNS TRIGGER
AS 
$$
BEGIN
    UPDATE customer_details.customers
    SET clear_balance = c.clear_balance + 
    COALESCE(
        (
            SELECT
                CASE
                    WHEN tt.credit_type = false THEN (i.amount * -1)::money
                    ELSE (i.amount)::money
                END
            FROM NEW AS i
            JOIN transaction_details.transaction_types AS tt
                ON tt.transaction_types_id = i.transaction_type
            WHERE tt.affect_cash_balance = true 
        )
        , 0::money
    )
    FROM customer_details.customers AS c
    JOIN NEW AS i
        ON i.customer_id = c.customer_id;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

SELECT clear_balance FROM customer_details.customers WHERE customer_id=1;

INSERT INTO transaction_details.transactions
    (
        customer_id,
        transaction_type,
        amount,
        related_product_id,
        date_entered
    )
VALUES 
    (
        1, 
        3, 
        200, 
        1, 
        current_date
    )
;

SELECT clear_balance FROM customer_details.customers WHERE customer_id=1;