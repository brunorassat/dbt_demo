{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with 

norm_prestashop_orders as (select * from {{ ref('norm_prestashop_orders') }}),
norm_prestashop_payments as (select * from {{ ref('norm_prestashop_payments') }}),

order_payments as (

    select
        order_id,

        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
        {% endfor -%}

        sum(amount) as total_amount
    from norm_prestashop_payments
    group by order_id

),

final as (

    select
        {{dbt_utils.generate_surrogate_key(["norm_prestashop_orders.customer_id"])}} as customer_key,
        norm_prestashop_orders.order_date,
        norm_prestashop_orders.order_id,
        norm_prestashop_orders.status,

        {% for payment_method in payment_methods -%}
        order_payments.{{ payment_method }}_amount,
        {% endfor -%}

        order_payments.total_amount as amount
    from norm_prestashop_orders
    left join order_payments on norm_prestashop_orders.order_id = order_payments.order_id

)

select * from final