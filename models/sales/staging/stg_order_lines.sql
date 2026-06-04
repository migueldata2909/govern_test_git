{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_order_lines') }}
),

renamed as (
    select
        line_id,
        order_id,
        product_id,
        quantity            ::integer as quantity,
        unit_price          ::numeric(12,2) as unit_price,
        discount_pct        ::numeric(5,2) as discount_pct,
        round(
            quantity::numeric * unit_price::numeric
            * (1 - discount_pct::numeric / 100), 2
        )                   as line_total,
        created_at          ::timestamp as created_at
    from source
    where line_id is not null
)

select * from renamed
