-- Test remediation patch (Prognosis)
SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo AS user_region
FROM {{ source('salesforce_sync', 'raw_customers') }}
