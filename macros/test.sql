{% macro drop_tables(
  schema,
  tables = []
) %}

{% set sql %}
  drop table 
  {% for table in tables %}
    {{ schema }}.{{ table }}
    {% if not loop.last %},{% endif %}
  {% endfor %}
  cascade
{% endset %}

{%- if execute -%}
  {{ run_query(sql) }}
{% endif %}
{% endmacro %}
