-- Test API access to the table
-- Run this in Supabase SQL Editor

-- Step 1: Check if table exists and is accessible
SELECT 
    schemaname,
    tablename,
    tableowner,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Step 2: Check RLS policies
SELECT 
    policyname,
    cmd,
    permissive,
    roles
FROM pg_policies 
WHERE tablename = 'marriage_meetings_dev';

-- Step 3: Check permissions
SELECT 
    grantee,
    privilege_type,
    is_grantable
FROM information_schema.role_table_grants 
WHERE table_name = 'marriage_meetings_dev';

-- Step 4: Try to insert a test row with your actual user ID
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2',
    'api-test-2025',
    '{"test": "api_access"}'::jsonb
);

-- Step 5: Verify insert worked
SELECT * FROM marriage_meetings_dev WHERE week_key = 'api-test-2025';

-- Step 6: Clean up
DELETE FROM marriage_meetings_dev WHERE week_key = 'api-test-2025';
