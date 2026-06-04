{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_products') }}
),

renamed as (
    select
        product_id,
        sku,
        name                as product_name,
        category,
        subcategory,
        unit_price,
        currency,
        is_active,
        created_at          as product_created_at
    from source
    where product_id is not null
)

select * from renamed
