{{ config(materialized="view", schema="analytics") }}

select purchase_id, customer_id, product_id, purchase_date, quantity
from {{ source("raw", "stg_purchases") }}
where quantity > 0
