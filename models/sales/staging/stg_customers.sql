{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_customers') }}
),

renamed as (
    select
        customer_id,
        name                as customer_name,
        email               as customer_email,
        country,
        region,
        segment,
        created_at          as customer_created_at,
        updated_at          as customer_updated_at
    from source
    where customer_id is not null
)

select * from renamed
