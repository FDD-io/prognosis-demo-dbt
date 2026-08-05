-- ====================================================================
-- MODÈLE DBT DE REMÉDIATION : stg_salesforce_raw_customers.sql
-- Contexte : Correction de la rupture de contrat de schéma sur 'raw_customers'
-- Problème : La colonne 'unknown' attendue en aval est manquante ou a été supprimée.
-- Solution : Sélection de toutes les colonnes sources existantes et réhabilitation
--            explicite de la colonne 'unknown' pour réorienter les pipelines aval.
-- ====================================================================

WITH source_raw_customers AS (
    SELECT
        customer_id,
        plan_tier,
        signup_date,
        user_region
    FROM {{ source('salesforce_sync', 'raw_customers') }}
)

SELECT
    customer_id,
    plan_tier,
    signup_date,
    user_region,
    -- Ajout/Alias de secours pour rétablir le contrat de schéma rompu ('unknown')
    CAST(NULL AS VARCHAR) AS unknown
FROM source_raw_customers