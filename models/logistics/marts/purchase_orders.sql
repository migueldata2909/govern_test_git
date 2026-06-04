{{ config(materialized='table', schema='LOGISTICS', tags=['logistics','internal']) }}

with stg as (select * from {{ ref('stg_purchase_orders') }}),
suppliers as (select supplier_id from {{ ref('suppliers') }})

select
    po.po_id,
    po.supplier_id,
    po.product_id,
    po.warehouse_id,
    po.qty_ordered,
    po.unit_cost,
    po.total_cost,
    po.status,
    po.ordered_at,
    po.expected_date,
    po.received_date,
    po.created_at
from stg po
inner join suppliers s on po.supplier_id = s.supplier_id
