WITH

SOURCE AS (

    SELECT * FROM {{ source('ecom', 'raw_products') }}

),

RENAMED AS (

    SELECT

        ----------  ids
        SKU AS PRODUCT_ID,

        ---------- text
        NAME AS PRODUCT_NAME,
        TYPE AS PRODUCT_TYPE,
        DESCRIPTION AS PRODUCT_DESCRIPTION,

        ---------- numerics
        -- Substituição manual do cents_to_dollars
        {{ cents_to_dollars('price') }} AS PRODUCT_PRICE,

        ---------- booleans
        coalesce(TYPE = 'jaffle', FALSE) AS IS_FOOD_ITEM,
        coalesce(TYPE = 'beverage', FALSE) AS IS_DRINK_ITEM

    FROM SOURCE

)

SELECT * FROM RENAMED
