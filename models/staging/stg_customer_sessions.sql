-- Remediation dbt Model: stg_raw_customers.sql
-- Context: Repair schema contract breakage for salesforce_sync.raw_customers.
-- Root Cause: Upstream column 'user_region' was renamed to 'user_geo'.
-- Fix: Select all present source columns and explicitly alias 'user_geo' as 'user_region' to satisfy downstream contract dependencies.

WITH source_data AS (
    SELECT
        customer_id,
        plan_tier,
        signup_date,
        user_geo AS user_region
    FROM {{ source('salesforce_sync', 'raw_customers') }}
)

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_region
FROM source_data