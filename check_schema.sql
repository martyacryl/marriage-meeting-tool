-- Check schema and table location
-- Run this in Supabase SQL Editor

-- Check current search path
SHOW search_path;

-- Check which schema the table is in
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Check if table exists in public schema
SELECT EXISTS (
    SELECT 1 FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name = 'marriage_meetings_dev'
) as exists_in_public;

-- Check all schemas for this table
SELECT 
    n.nspname as schema_name,
    c.relname as table_name
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE c.relname = 'marriage_meetings_dev';
