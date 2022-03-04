{% macro drop_tables() %}

{% set fetch_items_query %}
  SELECT CONCAT( 'DROP TABLE ', string_agg('cms_synthetic_patient_data_omop.' || table_name, ',') , ' CASCADE;' ) AS statement FROM information_schema.tables WHERE table_schema = 'cms_synthetic_patient_data_omop' AND table_name LIKE '_airbyte%';
{% endset %}

-- {% set results_list = run_query(fetch_items_query).columns[0].values()[0] | string() %}
-- {{ log("results list", info=True)}}
-- {{ log(results_list, info=True)}}

{% if execute %}
{{ run_query(run_query(fetch_items_query).columns[0].values()[0]) }}
{% endif %}

{% endmacro %}
