-- Modèle de remédiation dbt - Prognosis Observability System
-- Incident : Renommage de la colonne 'user_region' en 'user_geo' dans la source 'salesforce_sync.raw_customers'.
-- Impact : Rupture du contrat de schéma pour stg_customer_sessions, engagement_features et dégradation du modèle ML recommendation_v3.
-- Correctif : Re-projection de toutes les colonnes sources et alias explicite 'user_geo AS user_region' pour réinstaller la rétrocompatibilité.

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_geo,
    user_geo AS user_region
FROM {{ source('salesforce_sync', 'raw_customers') }}