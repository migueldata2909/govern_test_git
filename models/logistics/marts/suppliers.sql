{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal']) }}
with stg as (select * from {{ ref('stg_suppliers') }})
select supplier_id, supplier_name, country, contact_email,
       lead_time_days, rating, is_active, supplier_created_at
from stg
