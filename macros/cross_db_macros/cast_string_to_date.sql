{% macro cast_string_to_date(field, format) %}
  {{ adapter.dispatch('cast_string_to_date', 'dbt_utils') (field, format) }}
{% endmacro %}

{% macro default__cast_string_to_date(field, format) %}
    to_date({{ field }}, '{{format}}')
{% endmacro %}

{% macro bigquery__cast_string_to_date(field, format) %}
    cast({{ field }} AS DATE FORMAT '{{format}}')
{% endmacro %}