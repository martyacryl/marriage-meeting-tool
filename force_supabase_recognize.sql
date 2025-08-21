-- Force Supabase to recognize the marriage_meetings_dev table
-- Run this in Supabase SQL Editor

-- Step 1: Insert a dummy row to force table recognition
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '00000000-0000-0000-0000-000000000000', -- dummy UUID
    'force-recognition-2025',
    '{"dummy": "data"}'::jsonb
);

-- Step 2: Verify the insert worked
SELECT * FROM marriage_meetings_dev WHERE week_key = 'force-recognition-2025';

-- Step 3: Delete the dummy row
DELETE FROM marriage_meetings_dev WHERE week_key = 'force-recognition-2025';

-- Step 4: Force schema refresh
NOTIFY pgrst, 'reload schema';

-- Step 5: Check if table is now visible to the API
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE tablename = 'marriage_meetings_dev';

-- Step 6: Verify table is empty again
SELECT COUNT(*) as row_count FROM marriage_meetings_dev;
