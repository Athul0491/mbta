CREATE OR ALTER PROCEDURE DAILY_VEHICLES_DATA_BACKUP
AS
BEGIN
    -- Insert today's updated vehicle records into VEHICLES_DATA_HISTORY
    INSERT INTO vehicles_data_history (
        vehicle_data_id, vehicle_id, bearing, current_stop_sequence, 
        latitude, longitude, speed, updated_at, direction_id,
        route_id, label, current_status, stop_id
    )
    SELECT 
        vehicle_data_id, vehicle_id, bearing, current_stop_sequence, 
        latitude, longitude, speed, updated_at, direction_id,
        route_id, label, current_status, stop_id
    FROM vehicles_data
    WHERE CONVERT(DATE, updated_at) = CONVERT(DATE, GETDATE());
END;
Commit
select * from vehicles_data_history;

DROP PROCEDURE DAILY_VEHICLES_DATA_BACKUP;

-- List all sessions accessing vehicles_data_history
SELECT r.session_id, t.text AS sql_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE t.text LIKE '%vehicles_data_history%';

select * from vehicles_data_history


CREATE OR ALTER PROCEDURE DAILY_VEHICLES_DATA_BACKUP
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO vehicles_data_history (
        vehicle_id, vehicle_data_id, bearing, current_stop_sequence, 
        latitude, longitude, speed, updated_at, direction_id,
        route_id, label, current_status, stop_id
    )
    SELECT 
        v.vehicle_id, v.vehicle_data_id, v.bearing, v.current_stop_sequence, 
        v.latitude, v.longitude, v.speed, v.updated_at, v.direction_id,
        v.route_id, v.label, v.current_status, v.stop_id
    FROM vehicles_data v
    WHERE CONVERT(DATE, updated_at) = CONVERT(DATE, GETDATE())
    AND NOT EXISTS (
        SELECT 1 FROM vehicles_data_history h
        WHERE h.vehicle_data_id = v.vehicle_data_id
    );
END;

EXEC DAILY_VEHICLES_DATA_BACKUP;

SELECT 
    vehicle_id, vehicle_data_id, bearing, current_stop_sequence, 
    latitude, longitude, speed, updated_at, direction_id,
    route_id, label, current_status, stop_id
FROM vehicles_data
WHERE CONVERT(DATE, updated_at) = CONVERT(DATE, GETDATE());



EXEC DAILY_VEHICLES_DATA_BACKUP;
SELECT COUNT(*) FROM vehicles_data_history;

-- Example: check if route_id in vehicles_data actually exists in routes
SELECT DISTINCT route_id 
FROM vehicles_data
WHERE route_id NOT IN (SELECT route_id FROM routes);

-- direction_id
SELECT DISTINCT direction_id 
FROM vehicles_data
WHERE direction_id NOT IN (SELECT direction_id FROM directions);

-- stop_id
SELECT DISTINCT stop_id 
FROM vehicles_data
WHERE stop_id IS NOT NULL AND stop_id NOT IN (SELECT stop_id FROM stops);

-- current_status
SELECT DISTINCT current_status 
FROM vehicles_data
WHERE current_status IS NOT NULL AND current_status NOT IN (SELECT status_id FROM statuses);


SELECT *
FROM vehicles_data
WHERE 
    vehicle_id IS NULL OR
    vehicle_data_id IS NULL OR
    latitude IS NULL OR
    longitude IS NULL OR
    updated_at IS NULL OR
    direction_id IS NULL OR
    route_id IS NULL;

SELECT name, is_unique, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('vehicles_data_history');

SELECT 
    i.name AS index_name,
    c.name AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON i.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID('vehicles_data_history')
  AND i.is_unique = 1
  AND i.name LIKE 'UQ%';

SELECT COUNT(*)
FROM vehicles_data
WHERE CONVERT(DATE, updated_at) = CONVERT(DATE, GETDATE())
AND vehicle_data_id IN (
    SELECT vehicle_data_id FROM vehicles_data_history
);

SELECT TOP 10 vehicle_data_id 
FROM vehicles_data
WHERE CONVERT(DATE, updated_at) = CONVERT(DATE, GETDATE());

SELECT * FROM vehicles_data_history
WHERE vehicle_data_id IN (1,2,3,4,5,6,7,8,9,10);
