{% macro drop_tables() %}

{% set fetch_items_query %}
  SELECT CONCAT( 'DROP TABLE ', string_agg('cms_synthetic_patient_data_omop.' || table_name, ',') , ' CASCADE;' ) AS statement FROM information_schema.tables WHERE table_schema = 'cms_synthetic_patient_data_omop' AND table_name LIKE '_airbyte%';
{% endset %}

{% set results = run_query(fetch_items_query) %}

{% if execute %}
{{ log("results", info=True)}}
{{ log(results, info=True)}}
{% set results_list = results.columns[0].values() %}
{{ log("results list", info=True)}}
{{ log(results_list, info=True)}}
{{ run_query(results_list[0]) }}
{% endif %}

{% endmacro %}
