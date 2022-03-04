{% macro drop_tables() %}

{{ log ("testing") }}

{% set sql %}
  SELECT CONCAT( 'DROP TABLE ', string_agg(table_name,',') , ' CASCADE;' ) 
  AS statement FROM information_schema.tables 
  WHERE table_name LIKE '_airbyte%'; 
{% endset %}

{{ log(sql) }}

{%- if execute -%}
  {{ run_query(run_query(sql)) }}
{% endif %}
{% endmacro %}
