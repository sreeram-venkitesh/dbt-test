{% macro drop_tables() %}

{% set tables %}
  select table_name
  from information_schema.tables
  where table_name like '_airbyte%'
  and table_type = 'BASE TABLE' 
{% endset %}

{% set sql %}
  drop table 
  {% for table in tables %}
    {{ table }}
    {% if not loop.last %},{% endif %}
  {% endfor %}
  cascade
{% endset %}

{%- if execute -%}
  {{ run_query(sql) }}
{% endif %}
{% endmacro %}
