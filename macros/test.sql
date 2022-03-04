{% macro drop_tables() %}

{% set fetch_items_query %}
  SELECT CONCAT( 'DROP TABLE ', string_agg('cms_synthetic_patient_data_omop.' || table_name, ',') , ' CASCADE;' ) AS statement FROM information_schema.tables WHERE table_schema = 'cms_synthetic_patient_data_omop' AND table_name LIKE '_airbyte%';
{% endset %}

{% set results = run_query(fetch_items_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{{ run_query(results_list[0]) }}
{% endif %}

{% endmacro %}
