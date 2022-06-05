with 

norm_prestashop_customers as (select * from {{ ref('norm_prestashop_customers') }}),
orders as (select * from {{ ref('norm_prestashop_orders') }}),
payments as (select * from {{ ref('norm_prestashop_payments') }}),

customer_orders as (

        select
        customer_id,

        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders
    from orders

    group by customer_id

),

customer_payments as (

    select
        orders.customer_id,
        sum(amount) as total_amount

    from payments

    left join orders on
         payments.order_id = orders.order_id

    group by orders.customer_id

),

final as (

    select
        norm_prestashop_customers.customer_id,
        norm_prestashop_customers.first_name,
        norm_prestashop_customers.last_name,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        customer_orders.number_of_orders,
        customer_payments.total_amount as customer_lifetime_value

    from norm_prestashop_customers

    left join customer_orders
        on norm_prestashop_customers.customer_id = customer_orders.customer_id

    left join customer_payments
        on  norm_prestashop_customers.customer_id = customer_payments.customer_id

)

select * from final
