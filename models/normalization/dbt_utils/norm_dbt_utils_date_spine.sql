{{
  dbt_utils.date_spine(
    datepart="day",
    start_date= date_sub('CURRENT_DATE', 25, 'YEAR'),
    end_date= date_add('CURRENT_DATE', 5, 'YEAR')
   )
}}