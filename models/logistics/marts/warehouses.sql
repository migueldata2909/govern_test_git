{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal']) }}
with stg as (select * from {{ ref('stg_warehouses') }})
select warehouse_id, warehouse_name, geo_id, address,
       capacity_units, type, is_active, warehouse_created_at
from stg
