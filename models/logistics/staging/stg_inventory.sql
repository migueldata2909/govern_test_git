{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_inventory') }})
select
    inventory_id, warehouse_id, product_id,
    qty_on_hand::integer as qty_on_hand,
    qty_reserved::integer as qty_reserved,
    reorder_level::integer as reorder_level,
    last_counted_at::timestamp as last_counted_at,
    updated_at::timestamp as updated_at
from source where inventory_id is not null
