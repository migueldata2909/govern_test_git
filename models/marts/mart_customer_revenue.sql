{{ config(materialized='table', schema='analytics') }}

select
    customer_id,
    customer_name,
    count(*) as number_of_purchases,
    sum(purchase_amount) as total_revenue,
    avg(purchase_amount) as average_purchase_value
from {{ ref('fact_purchase_details') }}
group by
    customer_id,
    customer_name