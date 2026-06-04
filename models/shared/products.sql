{{ config(materialized='table', schema='shared', tags=['shared','public']) }}

with stg as (
    select * from {{ ref('stg_products') }}
)

select
    product_id,
    sku,
    product_name,
    category,
    subcategory,
    unit_price,
    currency,
    is_active,
    product_created_at
from stg
