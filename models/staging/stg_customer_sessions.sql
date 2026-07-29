{{ config(materialized='view') }}

with source as (
    select * from {{ source('salesforce_sync', 'raw_customers') }}
),

renamed as (
    select
        customer_id,
        -- Explicit reference to user_region column required by downstream feature transformations.
        -- BREAKING CHANGE RISK: If upstream source renames user_region -> user_geo, this model breaks.
        user_region,
        signup_date,
        plan_tier,
        current_timestamp() as staged_at
    from source
)

select * from renamed
