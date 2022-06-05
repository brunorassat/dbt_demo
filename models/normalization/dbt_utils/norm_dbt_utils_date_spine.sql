{{
  dbt_utils.date_spine(
    datepart="day",
    start_date="NOW() - INTERVAL '5 YEAR'",
    end_date="NOW() + INTERVAL '5 YEAR'"
   )
}}
