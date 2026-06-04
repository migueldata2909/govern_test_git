{{ config(materialized='table', schema='sales', tags=['sales','internal','kpi']) }}

with stg as (
    select * from {{ ref('stg_sales_targets') }}
),

reps as (
    select rep_id from {{ ref('sales_reps') }}
)

select
    t.target_id,
    t.rep_id,
    t.period,
    t.target_amount,
    t.achieved_amount,
    round(
        case when t.target_amount > 0
        then t.achieved_amount / t.target_amount * 100
        else 0 end, 2
    ) as achievement_pct,
    t.currency,
    t.created_at
from stg t
inner join reps r on t.rep_id = r.rep_id
