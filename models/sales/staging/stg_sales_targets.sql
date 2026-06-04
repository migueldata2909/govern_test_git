{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_sales_targets') }}
),

renamed as (
    select
        target_id,
        rep_id,
        period,
        target_amount       ::numeric(12,2) as target_amount,
        achieved_amount     ::numeric(12,2) as achieved_amount,
        currency,
        created_at          ::timestamp as created_at
    from source
    where target_id is not null
)

select * from renamed
