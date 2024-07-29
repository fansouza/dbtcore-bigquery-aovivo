WITH

SOURCE AS (

    SELECT * FROM {{ source('ecom', 'raw_supplies') }}

),

RENAMED AS (

    SELECT

        ----------  ids
        -- Substituição manual do generate_surrogate_key
        ID AS SUPPLY_ID,
        SKU AS PRODUCT_ID,
        NAME AS SUPPLY_NAME,

        ---------- text
        PERISHABLE AS IS_PERISHABLE_SUPPLY,

        ---------- numerics
        -- Substituição manual do cents_to_dollars
        {{ dbt_utils.generate_surrogate_key(['id', 'sku']) }} AS SUPPLY_UUID,

        ---------- booleans
        {{ cents_to_dollars('cost') }} AS SUPPLY_COST

    FROM SOURCE

)

SELECT * FROM RENAMED
