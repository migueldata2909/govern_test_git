{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal','cross-domain']) }}

-- Cross-domain: order_id → sales.orders (PostgreSQL)
with stg as (select * from {{ ref('stg_returns') }}),
shipments as (select shipment_id from {{ ref('shipments') }})

select
    r.return_id,
    r.order_id,         -- Cross-domain FK → sales.orders.order_id
    r.product_id,       -- Cross-domain FK → shared.products.product_id
    r.shipment_id, r.reason, r.condition,
    r.qty_returned, r.received_at, r.processed_at,
    r.refund_issued, r.created_at
from stg r
inner join shipments s on r.shipment_id = s.shipment_id
