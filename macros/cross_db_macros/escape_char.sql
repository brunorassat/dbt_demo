{% macro escape_char() %}
  {{ adapter.dispatch('escape_char', 'dbt_utils') () }}
{% endmacro %}

{% macro default__escape_char() %}
    E'\n'
{% endmacro %}

{% macro bigquery__escape_char() %}
    '\n'
{% endmacro %}