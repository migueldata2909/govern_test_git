{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_suppliers') }})
select
    supplier_id, name as supplier_name, country,
    contact_email, lead_time_days,
    rating::numeric(3,1) as rating,
    is_active, created_at as supplier_created_at
from source where supplier_id is not null
