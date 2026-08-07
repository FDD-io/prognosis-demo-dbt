-- Remediation Model: stg_customers.sql
-- Purpose: Fix broken schema contract due to upstream column rename in salesforce_sync.raw_customers.
-- Issue: 'user_region' was renamed to 'user_geo' upstream, breaking downstream models (stg_customer_sessions, engagement_features).
-- Fix: Select all present source columns and alias 'user_geo' back to 'user_region'.

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