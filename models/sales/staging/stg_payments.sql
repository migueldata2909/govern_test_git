{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_payments') }}
),

renamed as (
    select
        payment_id,
        invoice_id,
        method,
        amount              ::numeric(12,2) as amount,
        currency,
        status,
        processed_at        ::timestamp as processed_at,
        gateway_ref,
        created_at          ::timestamp as created_at
    from source
    where payment_id is not null
)

select * from renamed
