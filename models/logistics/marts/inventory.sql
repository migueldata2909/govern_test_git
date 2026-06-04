{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal','tier2']) }}

with stg as (select * from {{ ref('stg_inventory') }}),
warehouses as (select warehouse_id from {{ ref('warehouses') }})

select
    i.inventory_id, i.warehouse_id, i.product_id,
    i.qty_on_hand, i.qty_reserved,
    i.qty_on_hand - i.qty_reserved          as qty_available,
    i.reorder_level,
    case when i.qty_on_hand <= i.reorder_level
         then true else false end            as needs_reorder,
    i.last_counted_at, i.updated_at
from stg i
inner join warehouses w on i.warehouse_id = w.warehouse_id
