{{ config(materialized='table', schema='sales', tags=['sales','internal']) }}

with stg as (
    select * from {{ ref('stg_promotions') }}
),

products as (
    select product_id from {{ ref('products') }}
)

select
    p.promo_id,
    p.product_id,
    p.promo_name,
    p.discount_pct,
    p.min_order_amount,
    p.start_date,
    p.end_date,
    p.is_active,
    p.promo_created_at
from stg p
inner join products pr on p.product_id = pr.product_id
