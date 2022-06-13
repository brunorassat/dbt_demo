{{
  config(
    materialized='incremental',
    unique_key='order_id',
    sort = ['order_id']
  )
}}

with 

source as (select * from {{ source('tds_raw', 'raw_orders') }} ),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from source

)

select * from renamed

{% if is_incremental() %}

-- this filter will only be applied on an incremental run
where order_date > (select max(order_date) from {{ this }})

{% endif %}