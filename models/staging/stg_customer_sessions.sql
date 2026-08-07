-- Remediation dbt model to repair broken schema contract in salesforce_sync.raw_customers
-- Root Cause: Column 'user_region' was renamed upstream to 'user_geo'.
-- Fix: Select all present source columns and alias 'user_geo' as 'user_region' to restore downstream contract.

select
    customer_id,
    plan_tier,
    signup_date,
    user_geo,
    user_geo as user_region
from {{ source('salesforce_sync', 'raw_customers') }}
