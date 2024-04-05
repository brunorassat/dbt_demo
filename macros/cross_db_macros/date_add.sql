{% macro date_add(field, value, unit) %}
  {{ adapter.dispatch('date_add', 'dbt_utils') (field, value, unit) }}
{% endmacro %}

{% macro default__date_add(field, value, unit) %}
    {{ field }} + interval '{{ value }} {{ unit }}'
{% endmacro %}

{% macro bigquery__date_add(field, value, unit) %}
    date_add({{ field }}, interval {{ value }} {{ unit }})
{% endmacro %}