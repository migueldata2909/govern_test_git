{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal','cross-domain']) }}

-- Cross-domain: order_id → sales.orders (PostgreSQL)
-- Cross-domain: customer_id → shared.customers (PostgreSQL)
with stg as (select * from {{ ref('stg_shipments') }}),
warehouses as (select warehouse_id from {{ ref('warehouses') }})

select
    s.shipment_id,
    s.order_id,         -- Cross-domain FK → sales.orders.order_id
    s.customer_id,      -- Cross-domain FK → shared.customers.customer_id
    s.carrier, s.tracking_number,
    s.origin_warehouse_id, s.destination_geo_id,
    s.shipped_at, s.estimated_delivery, s.actual_delivery,
    datediff('day', s.shipped_at, s.actual_delivery) as transit_days,
    s.status, s.created_at, s.updated_at
from stg s
inner join warehouses w on s.origin_warehouse_id = w.warehouse_id
