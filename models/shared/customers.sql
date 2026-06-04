{{ config(materialized='table', schema='shared', tags=['shared','pii','gdpr']) }}

with stg as (
    select * from {{ ref('stg_customers') }}
)

select
    customer_id,
    customer_name,
    customer_email,
    country,
    region,
    segment,
    customer_created_at,
    customer_updated_at
from stg
