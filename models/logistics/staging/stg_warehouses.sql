{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_warehouses') }})
select
    warehouse_id, name as warehouse_name, geo_id,
    address, capacity_units, type, is_active,
    created_at as warehouse_created_at
from source where warehouse_id is not null
