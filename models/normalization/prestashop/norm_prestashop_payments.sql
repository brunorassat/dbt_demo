{{
  config(
    materialized='incremental',
    unique_key='payment_id',
    sort = ['payment_id']
  )
}}

with 

source as (select * from {{ source('tds_raw', 'raw_payments') }} ),

renamed as (

    select
        id as payment_id,
        order_id,
        payment_method,
        
        -- `amount` is currently stored in cents, so we convert it to dollars
        amount / 100 as amount
    from source

)

select * from renamed

{% if is_incremental() %}

-- this filter will only be applied on an incremental run
where payment_id > (select max(payment_id) from {{ this }})

{% endif %}