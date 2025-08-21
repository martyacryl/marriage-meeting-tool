-- Check and fix RLS policies for marriage_meetings_dev
-- Run this in Supabase SQL Editor

-- Step 1: Check if RLS is enabled
SELECT 
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Step 2: Check current policies
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'marriage_meetings_dev';

-- Step 3: Drop existing policies to recreate them
DROP POLICY IF EXISTS "Users can access own data" ON marriage_meetings_dev;

-- Step 4: Create a more permissive policy for testing
CREATE POLICY "Allow all authenticated users" ON marriage_meetings_dev
    FOR ALL 
    TO authenticated
    USING (true)
    WITH CHECK (true);

-- Step 5: Also allow service role access
CREATE POLICY "Service role access" ON marriage_meetings_dev
    FOR ALL 
    TO service_role
    USING (true)
    WITH CHECK (true);

-- Step 6: Verify policies were created
SELECT 
    policyname,
    cmd,
    permissive,
    roles
FROM pg_policies 
WHERE tablename = 'marriage_meetings_dev';
