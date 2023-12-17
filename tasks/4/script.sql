DROP DATABASE IF EXISTS my_bd;
-- paragraph 2 
CREATE DATABASE my_bd
WITH
OWNER learn -- postgres
ENCODING = 'UTF8'
-- LC_COLLATE = 'Russian_Russia.1251'
-- LC_CTYPE = 'Russian_Russia.1251'
TABLESPACE = pg_default
CONNECTION LIMIT = 10
IS_TEMPLATE = False;

-- paragraph 1
CREATE TABLESPACE my_tablespace1
OWNER  learn
LOCATION '/var/lib/postgresql/data';

-- paragraph 3
CREATE TABLE IF NOT EXISTS my_table1 (
    column1 int, 
    column2 bigint
)
TABLESPACE my_tablespace1;

-- paragraph 4
CREATE TABLE IF NOT EXISTS my_table2 (column1 int, column2 bigint)
TABLESPACE pg_default;

-- paragraph 5
ALTER TABLE my_table1
SET TABLESPACE pg_default;