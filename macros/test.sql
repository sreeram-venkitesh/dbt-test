{% macro drop_tables() %}

{% set sql %}
  SET @del = (SELECT CONCAT( 'DROP TABLE ', string_agg(table_name,',') , ' CASCADE;' ) 
  into statement FROM information_schema.tables 
  WHERE table_name LIKE '_airbyte%'); 
  statement;
{% endset %}

{%- if execute -%}
  {{ run_query(run_query(sql)) }}
{% endif %}
{% endmacro %}
