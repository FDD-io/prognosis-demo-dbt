-- Staging Remediation Model for Salesforce Raw Customers
-- Purpose: Resolve downstream pipeline failure by restoring the expected 'user_region' column contract.
-- Root Cause: Upstream dataset 'salesforce_sync.raw_customers' renamed 'user_region' to 'user_geo'.
-- Solution: Select all present source columns and alias 'user_geo' as 'user_region'.

select
    customer_id,
    plan_tier,
    signup_date,
    user_geo as user_region
from {{ source('salesforce_sync', 'raw_customers') }}