{% macro cast_date_to_string(field, format) %}
  {{ adapter.dispatch('cast_date_to_string', 'dbt_utils') (field, format) }}
{% endmacro %}

{% macro default__cast_date_to_string(field, format) %}
    to_char({{ field }}, '{{format}}')
{% endmacro %}

{% macro bigquery__cast_date_to_string(field, format) %}
    cast({{ field }} AS STRING FORMAT '{{format}}')
{% endmacro %}