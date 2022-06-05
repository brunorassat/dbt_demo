with

norm_dbt_utils_date_spine as (select * from {{ref('norm_dbt_utils_date_spine')}}),

final as (

    select
        date_day::date as date,
        date_day as date_ts,
        to_char(date_day, 'dd. mm. yyyy') AS formatted_date,
        date_part('year', date_day) as year,
        'q' || to_char(date_day, 'q') as quartal,
        date_part('month', date_day) as month,
        to_char(date_day, 'tmmonth') as month_name, -- Localized month name
        date_part('week', date_day) as calendar_week, -- ISO calendar week
        date_part('day', date_day) as day,
        date_part('doy', date_day) as day_of_year,
        to_char(date_day, 'tmday') as weekday_name, -- Localized weekday

        to_char(date_day, 'yyyy/"q"q') as year_quartal,
        to_char(date_day, 'yyyy/mm') as year_month,
        to_char(date_day, 'iyyy/iw') as year_calendar_week, -- ISO calendar year and week

        case when extract(isodow from date_day) in (6, 7) then 'weekend' else 'weekday' end as weekend, -- Weekend
        case 
            when to_char(date_day, 'mmdd') between '0701' and '0831' then 'summer break'
            when to_char(date_day, 'mmdd') between '1115' and '1225' then 'christmas season'
            when to_char(date_day, 'mmdd') > '1225' or to_char(date_day, 'mmdd') <= '0106' then 'winter break'
            else 'normal' 
        end as period,
        date_day::date + (1 - extract(isodow from date_day))::integer as cw_start, -- ISO start and end of the week of this date
        date_day::date + (7 - extract(isodow from date_day))::integer as cw_end,
        date_day::date + (1 - extract(day from date_day))::integer as month_start, -- Start and end of the month of this date
        (date_day::date + (1 - extract(day from date_day))::integer + '1 month'::interval - '1 day'::interval)::date as month_end

    from norm_dbt_utils_date_spine

)

select * from final