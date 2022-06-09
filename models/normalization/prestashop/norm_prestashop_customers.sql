with 

source as (select * from {{ source('tds_staging', 'raw_customers') }} ),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name
    from source

)

select * from renamed
