CREATE OR ALTER TRIGGER VEHICLES_HISTORY
ON vehicles_data_history
INSTEAD OF DELETE
AS
BEGIN
    THROW 50001, 'Vehicle History records cannot be deleted', 1;
END;
rollback
-- List all sessions accessing vehicles_data_history
SELECT r.session_id, t.text AS sql_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE t.text LIKE '%vehicles_data_history%';
commit