{% macro cast_string_to_timestamp(field, format) %}
  {{ adapter.dispatch('cast_string_to_timestamp', 'dbt_utils') (field, format) }}
{% endmacro %}

{% macro default__cast_string_to_timestamp(field, format) %}
    to_timestamp({{ field }}, '{{format}}')
{% endmacro %}

{% macro bigquery__cast_string_to_timestamp(field, format) %}
    cast({{ field }} AS TIMESTAMP FORMAT '{{format}}')
{% endmacro %}