{% macro to_array(field, delimiter) %}
  {{ adapter.dispatch('to_array', 'dbt_utils') (field, delimiter) }}
{% endmacro %}

{% macro default__to_array(field, delimiter) %}
    string_to_array({{ field }}, {{ delimiter }})
{% endmacro %}

{% macro bigquery__to_array(field, delimiter) %}
    split({{ field }}, {{ delimiter }})
{% endmacro %}