-- Force drop the existing table completely
-- Run this in Supabase SQL Editor

-- Step 1: Drop all policies first
DROP POLICY IF EXISTS "Allow all authenticated users" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Service role access" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Users can access own data" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Allow all" ON marriage_meetings_dev;

-- Step 2: Drop the table with CASCADE
DROP TABLE IF EXISTS marriage_meetings_dev CASCADE;

-- Step 3: Verify table is gone
SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'marriage_meetings_dev') 
        THEN 'Table still exists' 
        ELSE 'Table successfully dropped' 
    END as status;

-- Step 4: Check for any remaining references
SELECT 
    n.nspname as schema_name,
    c.relname as object_name,
    c.relkind as object_type
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE c.relname LIKE '%marriage_meetings_dev%';
