{{ config(materialized='view') }}
with source as (select * from {{ ref('seed_shipment_events') }})
select
    event_id, shipment_id, status, location,
    carrier_note, event_time::timestamp as event_time,
    created_at::timestamp as created_at
from source where event_id is not null
