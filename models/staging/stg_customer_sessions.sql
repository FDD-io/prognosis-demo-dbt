-- dbt Remediation Model: stg_salesforce_raw_customers
-- Incident: The upstream source dataset 'salesforce_sync.raw_customers' renamed 'user_region' to 'user_geo'.
-- Fix: Select all current source columns and alias 'user_geo' as 'user_region' to restore downstream contract.

select
    customer_id,
    plan_tier,
    signup_date,
    user_geo as user_region
from {{ source('salesforce_sync', 'raw_customers') }}