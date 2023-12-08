CREATE DATABASE apress_financial
WITH
OWNER = learn
ENCODING = 'UTF8'
TABLESPACE = pg_default
CONNECTION LIMIT = 1
IS_TEMPLATE = False;

CREATE SCHEMA IF NOT EXISTS transaction_details
AUTHORIZATION apress_financial;