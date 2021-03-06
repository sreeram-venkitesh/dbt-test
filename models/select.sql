-- with delete as (
--   for row in
--       select table_schema, table_name
--       from information_schema.tables
--       where table_type = 'BASE TABLE'
--       and table_schema = 'cms_synthetic_patient_data_omop'
--       and table_name ILIKE ('_airbyte' || '%')
--   loop
--       execute 'DROP TABLE ' || quote_ident(row.table_schema) || '.' || quote_ident(row.table_name) || ' CASCADE';
--       raise info 'Dropped tables: %', quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
--   end loop;
-- ) 
with tables as (
  select table_name
  from information_schema.tables
  where table_name like '_airbyte%'
  and table_schema not in ('information_schema', 'pg_catalog')
  and table_type = 'BASE TABLE' 
)

select * from tables