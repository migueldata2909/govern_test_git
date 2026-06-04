{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_purchase_orders') }})
select
    po_id, supplier_id, product_id, warehouse_id,
    qty_ordered::integer as qty_ordered,
    unit_cost::numeric(12,2) as unit_cost,
    total_cost::numeric(12,2) as total_cost,
    status, ordered_at::timestamp as ordered_at,
    expected_date::date as expected_date,
    nullif(received_date,'')::date as received_date,
    created_at::timestamp as created_at
from source where po_id is not null
