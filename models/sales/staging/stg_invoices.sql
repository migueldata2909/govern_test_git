{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_invoices') }}
),

renamed as (
    select
        invoice_id,
        order_id,
        amount              ::numeric(12,2) as amount,
        tax_amount          ::numeric(12,2) as tax_amount,
        currency,
        issued_date         ::date as issued_date,
        due_date            ::date as due_date,
        paid_date           ::date as paid_date,
        status,
        created_at          ::timestamp as created_at
    from source
    where invoice_id is not null
)

select * from renamed
