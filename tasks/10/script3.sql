-- paragraph 1
SELECT 'Before',share_id,share_desc,current_price
FROM share_details.shares
WHERE share_id = 3;

BEGIN;
    UPDATE share_details.shares
    SET current_price = current_price * 1.1
    WHERE share_id = 3;
COMMIT;
SELECT 'After',share_id,share_desc,current_price
FROM share_details.shares
WHERE share_id = 3;

SELECT 'Before',share_id,share_desc,current_price
FROM share_details.shares
WHERE share_id <= 3;

BEGIN;
UPDATE share_details.shares
    SET current_price = current_price * 2.0
    WHERE share_id <= 3;
    SELECT 'Within the transaction',share_id,share_desc,current_price
FROM share_details.shares
WHERE share_id <= 3;


ROLLBACK;
SELECT 'After',share_id,share_desc,current_price
FROM share_details.shares
WHERE share_id <= 3;

-- paragraph 2
-- paragraph 2.1, 2.2, 2.3
BEGIN;
UPDATE t1 SET price = price + 1.00::money WHERE id = 2;
SELECT id,price FROM t1 WHERE ID = 2;

SELECT id,price FROM t1 WHERE ID = 2;

COMMIT;
SELECT id,price FROM t1 WHERE ID = 2;

SELECT id,price FROM t1 WHERE ID = 2;

BEGIN;
UPDATE t1 SET price = price + 1.00::money WHERE id = 2;
SELECT id,price FROM t1 WHERE ID = 2;

BEGIN;
UPDATE t1 SET price = price + 5.00::money WHERE id = 2;

COMMIT;
SELECT id,price FROM t1 WHERE ID = 2;

SELECT id,price FROM t1 WHERE ID = 2;

COMMIT;
SELECT id,price FROM t1 WHERE ID = 2;