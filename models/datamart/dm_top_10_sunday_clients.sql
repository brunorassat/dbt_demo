with 

dim_customers as (select * from {{ ref('dim_customers') }}),
dim_date as (select * from {{ ref('dim_date') }}),
fct_orders as (select * from {{ ref('fct_orders') }}),

customer_sunday_payments as (

    select
        customer_key,
        sum(amount) as total_customer_paid,
        count(order_id) as total_orders_placed
    from fct_orders
    left join dim_date on fct_orders.order_date = dim_date.date
    where weekday_name = 'sunday'
    group by 1

),

final as (

    select
        concat(dim_customers.first_name, ' ',dim_customers.last_name) as customer_name,
        total_customer_paid,
        total_orders_placed,
        rank() over(order by total_customer_paid desc, total_orders_placed desc) as customer_ranking
    from customer_sunday_payments left join dim_customers on customer_sunday_payments.customer_key = dim_customers.customer_key

)

select * from final
where customer_ranking <= 10
