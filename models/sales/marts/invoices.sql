{{ config(materialized='table', schema='sales', tags=['sales','financial','restricted']) }}

with invoices as (
    select * from {{ ref('stg_invoices') }}
),

orders as (
    select order_id, customer_id from {{ ref('orders') }}
)

select
    i.invoice_id,
    i.order_id,
    o.customer_id,
    i.amount,
    i.tax_amount,
    i.currency,
    i.issued_date,
    i.due_date,
    i.paid_date,
    i.status,
    i.created_at
from invoices i
inner join orders o on i.order_id = o.order_id
