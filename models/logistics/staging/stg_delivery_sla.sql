{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_delivery_sla') }})
select
    sla_id, carrier, region, period,
    target_days::integer as target_days,
    actual_days_avg::numeric(5,2) as actual_days_avg,
    total_shipments::integer as total_shipments,
    sla_met_count::integer as sla_met_count,
    created_at::timestamp as created_at
from source where sla_id is not null
