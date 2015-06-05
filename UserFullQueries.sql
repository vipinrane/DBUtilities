/*find all tables containing column with specified name*/
SELECT t.name AS table_name, SCHEMA_NAME(schema_id) AS schema_name,
 c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%EmployeeID%'
ORDER BY schema_name, table_name;

/*To find out the dependancy of object*/
SELECT OBJECT_SCHEMA_NAME ( referencing_id ) AS referencing_schema_name,
    OBJECT_NAME(referencing_id) AS referencing_entity_name, 
    o.type_desc AS referencing_desciption, 
    COALESCE(COL_NAME(referencing_id, referencing_minor_id), '(n/a)') AS referencing_minor_id, 
    referencing_class_desc, referenced_class_desc,
    referenced_server_name, referenced_database_name, referenced_schema_name,
    referenced_entity_name, 
    COALESCE(COL_NAME(referenced_id, referenced_minor_id), '(n/a)') AS referenced_column_name,
    is_caller_dependent, is_ambiguous
FROM sys.sql_expression_dependencies AS sed
INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id
WHERE referenced_id = OBJECT_ID(N'Client');


SELECT COLUMN_NAME, TABLE_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%emailTestRecipient%'


SELECT Table_Name, Column_Name

FROM information_schema.columns
ORDER BYTable_Name, Ordinal_Position

/* to get all field names in a table using sql query*/
sp_columns [table name]
sp_columns site

/*to find all the Stored Procedures having a given text in it*/
SELECT ROUTINE_NAME, ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%SearchString%'
AND ROUTINE_TYPE='PROCEDURE'

/* Change 7 to any other day value.*/
SELECT name
FROM sys.objects
WHERE type = 'P'
AND DATEDIFF(D,create_date, GETDATE()) < 7

/*identify most recently modified stored procedures in SQL Server*/
select name,create_date,modify_date
from sys.procedures
order by modify_date desc

/*last time the table was updated in terms of its structured has changed (new column added, column changed etc.)*/
SELECT name, [modify_date] FROM sys.tables

SELECT OBJECT_NAME(OBJECT_ID) AS DatabaseName, last_user_update,*
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'RVFilter')
-- AND OBJECT_ID=OBJECT_ID('test')


/*sql query to get row count for all tables*/

USE GanttTest
GO

SELECT      SCHEMA_NAME(A.schema_id) + '.' +
        A.Name, SUM(B.rows) AS 'RowCount'
FROM        sys.objects A
INNER JOIN sys.partitions B ON A.object_id = B.object_id
WHERE       A.type = 'U'
GROUP BY    A.schema_id, A.Name
GO


/* To get row count of each table from all database instances of DB server */
CREATE TABLE #x(db SYSNAME, o SYSNAME, rc SYSNAME);

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 'INSERT #x(db,o,rc)
  SELECT db = N''' + name + '''
    ,o.name [Name]
    ,ddps.row_count [Row Count]
  FROM ' + QUOTENAME(name) + '.sys.indexes AS i
    INNER JOIN ' + QUOTENAME(name) + '.sys.objects AS o 
      ON i.OBJECT_ID = o.OBJECT_ID
    INNER JOIN ' + QUOTENAME(name) + '.sys.dm_db_partition_stats AS ddps 
      ON i.OBJECT_ID = ddps.OBJECT_ID AND i.index_id = ddps.index_id 
    WHERE i.index_id < 2  AND o.is_ms_shipped = 0 
    ORDER BY o.NAME;'
FROM sys.databases 
WHERE database_id > 4;

PRINT @sql 

EXEC sp_executesql @sql;

SELECT db DatabaseName, o TableName, rc [RowCount] FROM #x ORDER BY db, o;

DROP TABLE #x