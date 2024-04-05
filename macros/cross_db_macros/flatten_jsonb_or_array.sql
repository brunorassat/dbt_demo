{% macro flatten_jsonb_or_array(field) %}
  {{ adapter.dispatch('flatten_jsonb_or_array', 'dbt_utils') (field) }}
{% endmacro %}

{% macro default__flatten_jsonb_or_array(field) %}
    jsonb_array_elements({{ field }})
{% endmacro %}

{% macro bigquery__flatten_jsonb_or_array(field) %}
    unnest({{ field }})
{% endmacro %}