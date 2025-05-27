-- DROP INDEXES (SQL Server way)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'i_route_id')
DROP INDEX i_route_id ON vehicles_data_history;

IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'i_stop_id')
DROP INDEX i_stop_id ON vehicles_data_history;
commit
-- CREATE INDEXES
CREATE INDEX i_route_id ON vehicles_data_history(route_id);

CREATE INDEX i_stop_id ON vehicles_data_history(stop_id);
SELECT 
    r.session_id,
    r.status,
    r.command,
    t.text,
    r.blocking_session_id
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id <> @@SPID;


ROLLBACK;
kill 65

-- List all sessions accessing vehicles_data_history
SELECT r.session_id, t.text AS sql_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE t.text LIKE '%vehicles_data_history%';

SELECT * FROM sys.tables WHERE name = 'vehicles_data_history';
