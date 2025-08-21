-- Check if table is visible to Supabase API
-- Run this in Supabase SQL Editor

-- Check table exists in database
SELECT 
    'Database Layer' as layer,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'marriage_meetings_dev') 
        THEN 'Table EXISTS' 
        ELSE 'Table MISSING' 
    END as status;

-- Check if table exists in information_schema
SELECT 
    'Information Schema' as layer,
    CASE 
        WHEN EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'marriage_meetings_dev') 
        THEN 'Table EXISTS' 
        ELSE 'Table MISSING' 
    END as status;

-- Check if table exists in pg_class
SELECT 
    'PostgreSQL Class' as layer,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_class WHERE relname = 'marriage_meetings_dev') 
        THEN 'Table EXISTS' 
        ELSE 'Table MISSING' 
    END as status;

-- Check RLS status
SELECT 
    'RLS Status' as layer,
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'marriage_meetings_dev' AND rowsecurity = true) 
        THEN 'RLS ENABLED' 
        ELSE 'RLS DISABLED' 
    END as status;

-- Check policies
SELECT 
    'Policies' as layer,
    COUNT(*) as policy_count
FROM pg_policies 
WHERE tablename = 'marriage_meetings_dev';

-- Check permissions
SELECT 
    'Permissions' as layer,
    COUNT(*) as permission_count
FROM information_schema.role_table_grants 
WHERE table_name = 'marriage_meetings_dev';
