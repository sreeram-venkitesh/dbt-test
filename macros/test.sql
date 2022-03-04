{% macro delete_tables() %}
{% set sql %}
    CREATE OR REPLACE FUNCTION wild_func(IN _schema TEXT, IN _wildcard TEXT)
    RETURNS void
    LANGUAGE plpgsql
    AS
    $$
    DECLARE
      row record;
    BEGIN
      FOR row IN
          SELECT table_schema, table_name
          FROM information_schema.tables
          WHERE table_type = 'BASE TABLE'
          AND table_schema = _schema
          AND table_name ILIKE (_wildcard || '%')
      LOOP
          EXECUTE 'DROP TABLE ' || quote_ident(row.table_schema) || '.' || quote_ident(row.table_name) || ' CASCADE';
          RAISE INFO 'Dropped tables: %', quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
      END LOOP;
    END;
    $$;

    SELECT wild_func('cms_synthetic_patient_data_omop', '_airbyte');
{% endset %}

{% do run_query(sql) %}
{% endmacro %}


