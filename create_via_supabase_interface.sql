-- Create table the way Supabase interface would
-- Run this in Supabase SQL Editor

-- Step 1: Drop existing table completely
DROP TABLE IF EXISTS marriage_meetings_dev CASCADE;

-- Step 2: Create table with minimal structure
CREATE TABLE marriage_meetings_dev (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at timestamptz DEFAULT now(),
    user_id uuid,
    week_key text,
    data_content jsonb
);

-- Step 3: Add constraint
ALTER TABLE marriage_meetings_dev ADD CONSTRAINT marriage_meetings_dev_week_key_user_id_key UNIQUE (week_key, user_id);

-- Step 4: Enable RLS
ALTER TABLE marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Step 5: Create basic policy
CREATE POLICY "Enable read access for all users" ON marriage_meetings_dev FOR SELECT USING (true);
CREATE POLICY "Enable insert for authenticated users only" ON marriage_meetings_dev FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Enable update for users based on user_id" ON marriage_meetings_dev FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Enable delete for users based on user_id" ON marriage_meetings_dev FOR DELETE USING (auth.uid() = user_id);

-- Step 6: Grant permissions
GRANT ALL ON marriage_meetings_dev TO postgres, anon, authenticated, service_role;

-- Step 7: Force refresh
NOTIFY pgrst, 'reload schema';

-- Step 8: Verify
SELECT 'Table created via Supabase interface method' as status;
