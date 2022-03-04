{% macro drop_tables() %}



{% if execute %}
  {% set fetch_items_query %}
  SELECT CONCAT( 'DROP TABLE ', string_agg('cms_synthetic_patient_data_omop.' || table_name, ',') , ' CASCADE;' ) AS statement FROM information_schema.tables WHERE table_schema = 'cms_synthetic_patient_data_omop' AND table_name LIKE '_airbyte%';
  {% endset %}

  {% set result = run_query(fetch_items_query) %}
  {{ log("result", info=True)}}
  {{log(result, info=True)}}
  {% set results_list = result.columns[0].values()[0] %}
  {{ run_query(results_list) }}
{% endif %}

{% endmacro %}
