with

norm_dbt_utils_date_spine as (select * from {{ref('norm_dbt_utils_date_spine')}}),

pre_final as (

    select
        cast(date_day as date) as date,
        extract(year from date_day) as year,
        'q' || extract(quarter from date_day) as quartal,
        extract(month from date_day) as month,
        {{ dbt_date.month_name('date_day', short=false) }} as month_name,
        {{ dbt_date.iso_week_of_year('date_day') }} as iso_week_of_year,
        {{ dbt_date.day_of_month('date_day') }} as day_of_month,
        {{ cast_date_to_string('date_day', 'MM/YYYY') }} as year_month,
        {{ cast_date_to_string('date_day', 'DD/MM') }} as day_month,
        {{ cast_date_to_string('date_day', 'DD/MM/YY') }} as day_month_year,
        {{ dbt_date.day_of_year('date_day') }} as day_of_year,
        {{ dbt_date.day_name('date_day', short=false) }} as day_name,
        current_date as today_date,
        current_timestamp() as now_timestamp,
        case when cast(date_day as date) <= current_date then true else false end as has_passed
        -- to_char(date_day, 'yyyy/"q"q') as year_quartal,
        -- to_char(date_day, 'iyyy/iw') as year_calendar_week -- ISO calendar year and week
    from norm_dbt_utils_date_spine

),

final as (

    select
        *,
        {{ cast_timestamptz_to_date(dbt.date_trunc('month', 'date'), 'Asia/Ho_Chi_Minh') }} as month_date,
        case when
        {{ cast_timestamptz_to_date(dbt.date_trunc('month', 'date'), 'Asia/Ho_Chi_Minh') }} > {{ cast_timestamptz_to_date(dbt.date_trunc('month', date_sub('current_date', 1, 'YEAR')), 'Asia/Ho_Chi_Minh') }}
        and 
        {{ cast_timestamptz_to_date(dbt.date_trunc('month', 'date'), 'Asia/Ho_Chi_Minh') }} <= {{ cast_timestamptz_to_date(dbt.date_trunc('month', 'current_date'), 'Asia/Ho_Chi_Minh') }}
        then true else false end as is_last_12_full_months
    from pre_final


)

select * from final