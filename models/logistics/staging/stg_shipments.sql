{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_shipments') }})
select
    shipment_id, order_id, customer_id, carrier,
    tracking_number, origin_warehouse_id, destination_geo_id,
    shipped_at::timestamp as shipped_at,
    estimated_delivery::timestamp as estimated_delivery,
    actual_delivery::timestamp as actual_delivery,
    status, created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from source where shipment_id is not null
