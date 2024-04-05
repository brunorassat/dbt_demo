{% macro date_sub(field, value, unit) %}
  {{ adapter.dispatch('date_sub', 'dbt_utils') (field, value, unit) }}
{% endmacro %}

{% macro default__date_sub(field, value, unit) %}
    {{ field }} - interval '{{ value }} {{ unit }}'
{% endmacro %}

{% macro bigquery__date_sub(field, value, unit) %}
    date_sub({{ field }}, interval {{ value }} {{ unit }})
{% endmacro %}