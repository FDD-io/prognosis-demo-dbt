-- Modèle dbt de remédiation - Prognosis Data Observability
-- Cause racine : Renommage amont de 'user_region' en 'user_geo' dans salesforce_sync.raw_customers
-- Impact : Restauration de la colonne 'user_region' requise par 'staging.stg_customer_sessions' et le modèle ML 'recommendation_v3'

with raw_source as (
    select * from {{ source('salesforce_sync', 'raw_customers') }}
),

remediated as (
    select
        customer_id,
        plan_tier,
        signup_date,
        user_geo as user_region
    from raw_source
)

select * from remediated
