{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_promotions') }}
),

renamed as (
    select
        promo_id,
        product_id,
        name                as promo_name,
        discount_pct,
        min_order_amount,
        start_date,
        end_date,
        is_active,
        created_at          as promo_created_at
    from source
    where promo_id is not null
)

select * from renamed
