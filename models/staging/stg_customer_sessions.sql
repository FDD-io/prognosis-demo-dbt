-- Remediation Model: stg_customers
-- Fixes schema contract break where 'user_region' was renamed to 'user_geo' in salesforce_sync.raw_customers.
-- Re-exposes 'user_region' via SQL alias to maintain compatibility with downstream models.

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo AS user_region
FROM {{ source('salesforce_sync', 'raw_customers') }}