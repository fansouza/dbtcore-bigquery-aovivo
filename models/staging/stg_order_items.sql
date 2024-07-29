WITH

SOURCE AS (

    SELECT * FROM {{ source('ecom', 'raw_items') }}

),

RENAMED AS (

    SELECT

        ----------  ids
        ID AS ORDER_ITEM_ID,
        ORDER_ID,
        SKU AS PRODUCT_ID

    FROM SOURCE

)

SELECT * FROM RENAMED
