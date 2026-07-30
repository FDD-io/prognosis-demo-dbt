-- Prognosis Data Observability - Auto-Generated Remediation Model
-- Root Cause: Column 'user_region' renamed/removed in favor of 'user_geo' in 'salesforce_sync.raw_customers'.
-- Remediation: Map 'user_geo' to 'user_region' to restore schema contract for downstream models.

WITH raw_source AS (
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
FROM raw_source