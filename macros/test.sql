{% macro drop_tables() %}

{{ log("testing") }}

{% set sql %}
  FOR tmp IN SELECT CONCAT( 'DROP TABLE ', string_agg(table_name,',') , ' CASCADE;' ) 
  AS statement FROM information_schema.tables 
  WHERE table_name LIKE '_airbyte%'
  LOOP
    EXECUTE tmp;
  END LOOP; 
{% endset %}

{{ log(sql) }}

{%- if execute -%}
  {{ run_query(sql) }}
{% endif %}
{% endmacro %}
