{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_geography') }}
),

renamed as (
    select
        geo_id,
        country,
        region,
        subregion,
        timezone,
        currency_code
    from source
    where geo_id is not null
)

select * from renamed
