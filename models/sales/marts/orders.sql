{{ config(materialized='table', schema='sales', tags=['sales','internal','tier2']) }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select customer_id from {{ ref('customers') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.channel,
    o.rep_id,
    o.promo_id,
    o.total_amount,
    o.currency,
    o.created_at,
    o.updated_at
from orders o
inner join customers c on o.customer_id = c.customer_id
