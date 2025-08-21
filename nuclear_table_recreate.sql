-- Nuclear option: Recreate table exactly like Supabase would
-- Run this in Supabase SQL Editor

-- Step 1: Drop everything completely
DROP TABLE IF EXISTS marriage_meetings_dev CASCADE;

-- Step 2: Create table with Supabase's exact pattern
CREATE TABLE public.marriage_meetings_dev (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    user_id uuid,
    week_key text,
    data_content jsonb
);

-- Step 3: Add constraint
ALTER TABLE public.marriage_meetings_dev ADD CONSTRAINT marriage_meetings_dev_week_key_user_id_key UNIQUE (week_key, user_id);

-- Step 4: Enable RLS
ALTER TABLE public.marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Step 5: Create Supabase standard policies
CREATE POLICY "Enable read access for all users" ON public.marriage_meetings_dev FOR SELECT USING (true);
CREATE POLICY "Enable insert for authenticated users only" ON public.marriage_meetings_dev FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Enable update for users based on user_id" ON public.marriage_meetings_dev FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Enable delete for users based on user_id" ON public.marriage_meetings_dev FOR DELETE USING (auth.uid() = user_id);

-- Step 6: Grant all permissions
GRANT ALL ON public.marriage_meetings_dev TO postgres, anon, authenticated, service_role;

-- Step 7: Create trigger for updated_at
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER handle_marriage_meetings_dev_updated_at
    BEFORE UPDATE ON public.marriage_meetings_dev
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

-- Step 8: Force multiple schema refreshes
NOTIFY pgrst, 'reload schema';
NOTIFY pgrst, 'reload schema';
NOTIFY pgrst, 'reload schema';

-- Step 9: Insert test data
INSERT INTO public.marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2',
    '2025-08-18',
    '{"schedule": {"Monday": ["Test from new table"], "Tuesday": ["Database working"]}, "todos": ["Test todo"], "prayers": ["Test prayer"], "goals": ["Test goal"], "grocery": ["Test item"], "unconfessedSin": [], "weeklyWinddown": ["Test activity"]}'::jsonb
);

-- Step 10: Verify
SELECT 'Table recreated with Supabase native pattern' as status;
