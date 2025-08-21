-- Recreate table in a way Supabase will recognize
-- Run this in Supabase SQL Editor

-- Step 1: Drop everything completely
DROP TABLE IF EXISTS marriage_meetings_dev CASCADE;
DROP POLICY IF EXISTS "Allow all authenticated users" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Service role access" ON marriage_meetings_dev;

-- Step 2: Create table with explicit schema
CREATE TABLE public.marriage_meetings_dev (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID,
    week_key TEXT,
    data_content JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Step 3: Add constraint
ALTER TABLE public.marriage_meetings_dev ADD CONSTRAINT marriage_meetings_dev_week_key_user_id_key UNIQUE (week_key, user_id);

-- Step 4: Enable RLS
ALTER TABLE public.marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Step 5: Create very permissive policies
CREATE POLICY "Allow all access" ON public.marriage_meetings_dev
    FOR ALL 
    TO public
    USING (true)
    WITH CHECK (true);

-- Step 6: Grant all permissions
GRANT ALL ON public.marriage_meetings_dev TO public;
GRANT ALL ON public.marriage_meetings_dev TO anon;
GRANT ALL ON public.marriage_meetings_dev TO authenticated;
GRANT ALL ON public.marriage_meetings_dev TO service_role;

-- Step 7: Force schema refresh
NOTIFY pgrst, 'reload schema';

-- Step 8: Verify table exists
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';
