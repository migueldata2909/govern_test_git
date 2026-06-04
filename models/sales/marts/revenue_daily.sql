{{ config(materialized='table', schema='sales', tags=['sales','kpi','mart','certified']) }}

-- KPI mart: daily revenue aggregation — no PII
-- Lineage: seed_orders → stg_orders → orders → revenue_daily
--          seed_customers → stg_customers → customers → revenue_daily

with orders as (
    select
        o.order_id,
        o.order_date,
        o.channel,
        o.total_amount,
        o.currency,
        c.country,
        c.segment
    from {{ ref('orders') }} o
    left join {{ ref('customers') }} c on o.customer_id = c.customer_id
    where o.status != 'cancelled'
)

select
    order_date                          as date,
    channel,
    country,
    segment,
    currency,
    count(order_id)                     as order_count,
    sum(total_amount)                   as total_revenue,
    round(avg(total_amount), 2)         as avg_order_value,
    current_timestamp                   as refreshed_at
from orders
group by 1, 2, 3, 4, 5
