{{ config(materialized='view') }}

with source as (
    select * from {{ ref('seed_sales_reps') }}
),

renamed as (
    select
        rep_id,
        name                as rep_name,
        email               as rep_email,
        phone               as rep_phone,
        region,
        manager_id,
        hire_date,
        is_active,
        created_at          as rep_created_at
    from source
    where rep_id is not null
)

select * from renamed
