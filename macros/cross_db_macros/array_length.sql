{% macro array_length(field) %}
  {{ adapter.dispatch('array_length', 'dbt_utils') (field) }}
{% endmacro %}

{% macro default__array_length(field) %}
    array_length({{ field }}, 1)
{% endmacro %}

{% macro bigquery__array_length(field) %}
    array_length({{ field }})
{% endmacro %}