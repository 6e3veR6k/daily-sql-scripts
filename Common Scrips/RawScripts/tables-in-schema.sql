-- Query below lists all tables in specific schema in SQL Server database.

select schema_name(t.schema_id) as schema_name,
       t.name as table_name,
       t.create_date,
       t.modify_date
from sys.tables t
where schema_name(t.schema_id) = 'Stage' -- put schema name here
order by table_name;