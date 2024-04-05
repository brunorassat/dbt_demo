{% macro bool_or(field) %}
  {{ adapter.dispatch('bool_or', 'dbt_utils') (field) }}
{% endmacro %}

{% macro default__bool_or(field) %}
    bool_or({{ field }})
{% endmacro %}

{% macro bigquery__bool_or(field) %}
    logical_or({{ field }})
{% endmacro %}