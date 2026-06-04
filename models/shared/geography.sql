{{ config(materialized='table', schema='shared', tags=['shared','public']) }}

with stg as (
    select * from {{ ref('stg_geography') }}
)

select
    geo_id,
    country,
    region,
    subregion,
    timezone,
    currency_code
from stg
