{% macro cast_timestamptz_to_date(field, timezone) %}
  {{ adapter.dispatch('cast_timestamptz_to_date', 'dbt_utils') (field, timezone) }}
{% endmacro %}

{% macro default__cast_timestamptz_to_date(field, timezone) %}
    date({{ field }} at time zone '{{timezone}}')
{% endmacro %}

{% macro bigquery__cast_timestamptz_to_date(field, timezone) %}
    date({{ field }}, '{{timezone}}')
{% endmacro %}