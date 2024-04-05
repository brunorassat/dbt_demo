{% macro array_agg(field) %}
  {{ adapter.dispatch('array_agg', 'dbt_utils') (field) }}
{% endmacro %}

{% macro default__array_agg(field) %}
    array_agg({{ field }})
{% endmacro %}

{% macro bigquery__array_agg(field) %}
    array_agg({{ field }} IGNORE NULLS)
{% endmacro %}