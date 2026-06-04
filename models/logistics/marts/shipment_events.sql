{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal']) }}

with stg as (select * from {{ ref('stg_shipment_events') }}),
shipments as (select shipment_id from {{ ref('shipments') }})

select e.event_id, e.shipment_id, e.status, e.location,
       e.carrier_note, e.event_time, e.created_at
from stg e
inner join shipments s on e.shipment_id = s.shipment_id
