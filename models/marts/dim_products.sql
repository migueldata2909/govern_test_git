{{ config(materialized='view', schema='analytics') }}

select
    product_id,
    trim(product_name) as product_name,
    trim(category) as category,
    price
from {{ source('raw', 'stg_products') }}
where price >= 0