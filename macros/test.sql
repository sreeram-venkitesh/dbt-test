{% macro drop_tables() %}

{% set sql %}
  SELECT CONCAT( 'DROP TABLE ', string_agg(table_name,',') , ' CASCADE;' ) 
  AS statement FROM information_schema.tables 
  WHERE table_name LIKE '_airbyte%'; 
{% endset %}

{%- if execute -%}
  {{ run_query(run_query(sql)) }}
{% endif %}
{% endmacro %}
