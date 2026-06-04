{{ config(materialized='table', schema='sales', tags=['sales','pii','gdpr','internal']) }}

with stg as (
    select * from {{ ref('stg_sales_reps') }}
)

select
    rep_id,
    rep_name,
    rep_email,
    rep_phone,
    region,
    manager_id,
    hire_date,
    is_active,
    rep_created_at
from stg
