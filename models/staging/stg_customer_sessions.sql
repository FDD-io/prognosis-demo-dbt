-- Modèle de remédiation dbt - Prognosis Data Observability
-- Incident: Rupture de contrat de schéma sur salesforce_sync.raw_customers
-- Cause racine: La colonne 'user_region' a été renommée en 'user_geo'
-- Solution: Sélection de l'ensemble des colonnes sources avec aliasage explicite 'user_geo AS user_region' pour rétablir la compatibilité avec les pipelines aval

WITH source_customers AS (
    SELECT
        customer_id,
        plan_tier,
        signup_date,
        user_geo,
        user_geo AS user_region
    FROM {{ source('salesforce_sync', 'raw_customers') }}
)

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo,
    user_region
FROM source_customers