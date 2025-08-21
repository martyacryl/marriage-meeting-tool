-- Force Supabase API to recognize the table
-- Run this in Supabase SQL Editor

-- Step 1: Check if table exists in information_schema
SELECT 
    table_schema,
    table_name,
    table_type
FROM information_schema.tables 
WHERE table_name = 'marriage_meetings_dev';

-- Step 2: Grant explicit permissions to public schema
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;

-- Step 3: Grant all permissions on the table
GRANT ALL ON marriage_meetings_dev TO anon;
GRANT ALL ON marriage_meetings_dev TO authenticated;
GRANT ALL ON marriage_meetings_dev TO service_role;

-- Step 4: Insert a real row to force table recognition
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2', -- Your actual user ID
    'test-week-2025',
    '{"test": "data"}'::jsonb
) ON CONFLICT (week_key, user_id) DO NOTHING;

-- Step 5: Verify the insert worked
SELECT * FROM marriage_meetings_dev WHERE week_key = 'test-week-2025';

-- Step 6: Force multiple schema refreshes
NOTIFY pgrst, 'reload schema';
NOTIFY pgrst, 'reload schema';
NOTIFY pgrst, 'reload schema';

-- Step 7: Check table permissions
SELECT 
    grantee,
    privilege_type,
    is_grantable
FROM information_schema.role_table_grants 
WHERE table_name = 'marriage_meetings_dev';

-- Step 8: Clean up test data
DELETE FROM marriage_meetings_dev WHERE week_key = 'test-week-2025';
