with delete as (
   FOR row IN
      SELECT table_schema, table_name
      FROM information_schema.tables
      WHERE table_type = 'BASE TABLE'
      AND table_schema = 'cms_synthetic_patient_data_omop'
      AND table_name ILIKE ('_airbyte' || '%')
  LOOP
      EXECUTE 'DROP TABLE ' || quote_ident(row.table_schema) || '.' || quote_ident(row.table_name) || ' CASCADE';
      RAISE INFO 'Dropped tables: %', quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
  END LOOP;
) 

select * from delete