-- 1. Grant the role to your current user
GRANT ROLE dbt_role TO USER BUNYODYOKUBOV;

USE ROLE dbt_role;
USE WAREHOUSE transforming_wh;
USE DATABASE raw;

-- 1. Create a Schema to hold our raw data
CREATE SCHEMA IF NOT EXISTS jaffle_shop;

-- 2. Create the CUSTOMERS table and insert dummy data
CREATE OR REPLACE TABLE jaffle_shop.customers (
    id integer,
    first_name varchar,
    last_name varchar
);

INSERT INTO jaffle_shop.customers (id, first_name, last_name) VALUES
    (1, 'Michael', 'P.'),
    (2, 'Shawn', 'M.'),
    (3, 'Kathleen', 'P.'),
    (4, 'Jimmy', 'C.'),
    (5, 'Katherine', 'R.'),
    (6, 'Sarah', 'R.');

-- 3. Create the ORDERS table and insert dummy data
CREATE OR REPLACE TABLE jaffle_shop.orders (
    id integer,
    user_id integer,
    order_date date,
    status varchar
);

INSERT INTO jaffle_shop.orders (id, user_id, order_date, status) VALUES
    (1, 1, '2018-01-01', 'returned'),
    (2, 3, '2018-01-02', 'completed'),
    (3, 94, '2018-01-04', 'completed'),
    (4, 1, '2018-01-05', 'completed'),
    (5, 6, '2018-01-10', 'placed');

-- Sanity Check: See if data exists
SELECT * FROM jaffle_shop.customers;

