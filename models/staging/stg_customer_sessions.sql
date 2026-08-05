-- Remediation dbt Model: stg_salesforce_raw_customers.sql
-- Prognosis Data Observability Remediation
-- Purpose: Fix upstream schema drift where 'user_region' was renamed to 'user_geo'.
-- This model aliases 'user_geo' back to 'user_region' to restore schema contract for downstream models.

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