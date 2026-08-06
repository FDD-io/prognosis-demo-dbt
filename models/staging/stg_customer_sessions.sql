-- Remediation dbt model for salesforce_sync.raw_customers
-- Incident: Upstream schema contract broken due to column rename from 'user_region' to 'user_geo'.
-- Fix: Select all active source columns and alias 'user_geo' back to 'user_region' to unblock downstream feature extraction pipelines.

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