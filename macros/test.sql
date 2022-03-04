{% macro drop_tables(
  tables = []
) %}

{% set sql %}
  drop table 
  {% for table in tables %}
    'cms_synthetic_patient_data_omop'.{{ table }}
    {% if not loop.last %},{% endif %}
  {% endfor %}
  cascade
{% endset %}

{%- if execute -%}
  {{ run_query(sql) }}
{% endif %}
{% endmacro %}
