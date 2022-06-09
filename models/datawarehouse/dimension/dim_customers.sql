with 

norm_prestashop_customers as (select * from {{ ref('norm_prestashop_customers') }}),

final as (

    select
        {{dbt_utils.surrogate_key(["norm_prestashop_customers.customer_id"])}} as customer_key,
        norm_prestashop_customers.customer_id,
        norm_prestashop_customers.first_name,
        norm_prestashop_customers.last_name
    from norm_prestashop_customers

)

select * from final
