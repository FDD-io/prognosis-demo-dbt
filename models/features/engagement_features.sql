{{ config(materialized='table') }}

with staging as (
    select * from {{ ref('stg_customer_sessions') }}
),

feature_engineering as (
    select
        customer_id,
        user_region,
        plan_tier,
        signup_date,
        case
            when plan_tier = 'Enterprise' then 95.0
            when plan_tier = 'Pro' then 75.0
            else 30.0
        end as engagement_score,
        datediff('day', signup_date, current_date()) as account_age_days
    from staging
)

select * from feature_engineering
