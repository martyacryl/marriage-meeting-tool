-- Diagnose the current database state
-- Run this in Supabase SQL Editor

-- Check what tables exist
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE tablename LIKE '%marriage%' OR tablename LIKE '%dev%';

-- Check if our table exists anywhere
SELECT 
    n.nspname as schema_name,
    c.relname as table_name,
    c.relkind as type
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE c.relname LIKE '%marriage%' OR c.relname LIKE '%dev%';

-- Check for any errors in recent operations
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Show current user and permissions
SELECT current_user, current_database();
