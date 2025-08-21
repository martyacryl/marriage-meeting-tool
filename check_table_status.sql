-- Check current table status
-- Run this in Supabase SQL Editor

-- Check if table exists
SELECT 
    schemaname,
    tablename,
    tableowner,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Check table structure
SELECT 
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'marriage_meetings_dev'
ORDER BY ordinal_position;

-- Check RLS policies
SELECT 
    policyname,
    cmd,
    permissive,
    roles
FROM pg_policies 
WHERE tablename = 'marriage_meetings_dev';

-- Check permissions
SELECT 
    grantee,
    privilege_type,
    is_grantable
FROM information_schema.role_table_grants 
WHERE table_name = 'marriage_meetings_dev';

-- Try a simple test insert
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2',
    'test-status-2025',
    '{"test": "status_check"}'::jsonb
);

-- Verify insert worked
SELECT * FROM marriage_meetings_dev WHERE week_key = 'test-status-2025';

-- Clean up
DELETE FROM marriage_meetings_dev WHERE week_key = 'test-status-2025';
