{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','kpi','tier1','certified']) }}

with stg as (select * from {{ ref('stg_delivery_sla') }})

select
    sla_id, carrier, region, period,
    target_days, actual_days_avg,
    total_shipments, sla_met_count,
    round(sla_met_count / nullif(total_shipments, 0) * 100, 2) as sla_pct,
    case when sla_met_count / nullif(total_shipments, 0) >= 0.95 then 'GREEN'
         when sla_met_count / nullif(total_shipments, 0) >= 0.85 then 'AMBER'
         else 'RED' end                                          as sla_status,
    created_at
from stg
