{{ config(materialized='table', schema='sales', tags=['sales','financial','pci','restricted']) }}

with payments as (
    select * from {{ ref('stg_payments') }}
),

invoices as (
    select invoice_id from {{ ref('invoices') }}
)

select
    p.payment_id,
    p.invoice_id,
    p.method,
    p.amount,
    p.currency,
    p.status,
    p.processed_at,
    p.gateway_ref,
    p.created_at
from payments p
inner join invoices i on p.invoice_id = i.invoice_id
