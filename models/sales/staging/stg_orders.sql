{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date          ::date as order_date,
        status,
        channel,
        rep_id,
        promo_id,
        total_amount        ::numeric(12,2) as total_amount,
        currency,
        created_at          ::timestamp as created_at,
        updated_at          ::timestamp as updated_at
    from source
    where order_id is not null
)

select * from renamed
