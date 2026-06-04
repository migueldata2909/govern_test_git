{{ config(materialized='table', schema='sales', tags=['sales','internal']) }}

with lines as (
    select * from {{ ref('stg_order_lines') }}
),

orders as (
    select order_id from {{ ref('orders') }}
),

products as (
    select product_id, unit_price as list_price from {{ ref('products') }}
)

select
    l.line_id,
    l.order_id,
    l.product_id,
    l.quantity,
    l.unit_price,
    l.discount_pct,
    l.line_total,
    p.list_price,
    l.created_at
from lines l
inner join orders o on l.order_id = o.order_id
inner join products p on l.product_id = p.product_id
