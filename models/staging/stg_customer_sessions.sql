-- dbt Remediation Model: Fix broken schema contract for salesforce_sync.raw_customers
-- Root cause: The upstream column 'user_region' was renamed to 'user_geo'.
-- Remediation: Select all present source columns and alias 'user_geo' back to 'user_region' to preserve downstream compatibility.

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo AS user_region
FROM {{ source('salesforce_sync', 'raw_customers') }}