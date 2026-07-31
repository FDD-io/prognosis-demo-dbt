-- Modèle dbt de remédiation généré automatiquement par Prognosis
-- Incident: Rupture du contrat de schéma sur 'salesforce_sync.raw_customers'
-- Cause racine: La colonne 'user_region' a été renommée en 'user_geo'
-- Action: Alias explicite de 'user_geo' vers 'user_region' pour rétablir la compatibilité en aval

WITH source_data AS (
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
FROM source_data