{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_returns') }})
select
    return_id, order_id, product_id, shipment_id,
    reason, condition,
    qty_returned::integer as qty_returned,
    received_at::date as received_at,
    processed_at::date as processed_at,
    refund_issued::boolean as refund_issued,
    created_at::timestamp as created_at
from source where return_id is not null
