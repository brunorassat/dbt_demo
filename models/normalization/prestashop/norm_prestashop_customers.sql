{{
  config(
    materialized='incremental',
    unique_key='customer_id',
    sort = ['customer_id']
  )
}}

with 

source as (select * from {{ source('tds_raw', 'raw_customers') }} ),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name
    from source

)

select * from renamed

{% if is_incremental() %}

-- this filter will only be applied on an incremental run
where customer_id > (select max(customer_id) from {{ this }})

{% endif %}