{{ config(materialized='view', schema='analytics') }}

select
    customer_id,
    trim(customer_name) as customer_name,
    lower(trim(email)) as email
from {{ source('raw', 'stg_customers') }}