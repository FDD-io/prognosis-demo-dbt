-- dbt Remediation Model: stg_raw_customers.sql
-- Incident: Breaking schema change in upstream dataset 'salesforce_sync.raw_customers'.
-- Root Cause: Column 'user_region' was renamed to 'user_geo'.
-- Fix: Select source columns and alias 'user_geo' back to 'user_region' to fulfill downstream contracts.

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo AS user_region
FROM {{ source('salesforce_sync', 'raw_customers') }}