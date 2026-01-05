-- 1. Create a Warehouse for dbt to use (Compute power)
CREATE WAREHOUSE IF NOT EXISTS transforming_wh
    WITH WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;

-- 2. Create the Databases
-- RAW: Where we will manually upload our messy data
CREATE DATABASE IF NOT EXISTS raw;
-- ANALYTICS: Where dbt will build clean tables
CREATE DATABASE IF NOT EXISTS analytics;

-- 3. Create a specific Role for dbt (Security best practice)
CREATE ROLE IF NOT EXISTS dbt_role;

-- 4. Give the Role permission to use the Warehouse and Databases
GRANT USAGE ON WAREHOUSE transforming_wh TO ROLE dbt_role;
GRANT OPERATE ON WAREHOUSE transforming_wh TO ROLE dbt_role;
GRANT ALL PRIVILEGES ON DATABASE analytics TO ROLE dbt_role;
GRANT ALL PRIVILEGES ON DATABASE raw TO ROLE dbt_role;

-- 5. Create your User (Optional but recommended)
-- Replace "bunyod_dbt" with a username you like
-- Replace "Password123!" with a strong password
CREATE USER IF NOT EXISTS bunyod_dbt
    PASSWORD = 'Password123!'
    DEFAULT_ROLE = dbt_role
    DEFAULT_WAREHOUSE = transforming_wh
    MUST_CHANGE_PASSWORD = FALSE;

GRANT ROLE dbt_role TO USER bunyod_dbt;

-- 6. Important: Allow this role to create schemas
GRANT CREATE SCHEMA ON DATABASE analytics TO ROLE dbt_role;

-- Reset the password to ensure it matches exactly
ALTER USER bunyod_dbt SET PASSWORD = 'Password123456789';


-- Check if your view exists and verify the column rename worked
SELECT * FROM analytics.dbt_bunyod.stg_customers;