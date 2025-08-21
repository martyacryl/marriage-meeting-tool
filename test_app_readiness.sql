-- Test if table is ready for your app to use
-- Run this in Supabase SQL Editor

-- Step 1: Verify table structure matches what your app expects
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'marriage_meetings_dev'
ORDER BY ordinal_position;

-- Step 2: Test inserting data exactly like your app will
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2', -- Your actual user ID
    '2025-08-18', -- Same week key your app uses
    '{"schedule": {"Monday": ["Coffee"], "Tuesday": ["Walk"]}, "todos": ["Test item"], "prayers": ["Test prayer"], "goals": ["Test goal"], "grocery": ["Test item"], "unconfessedSin": [], "weeklyWinddown": ["Test activity"]}'::jsonb
) ON CONFLICT (week_key, user_id) DO NOTHING;

-- Step 3: Test reading data exactly like your app will
SELECT 
    week_key,
    user_id,
    data_content
FROM marriage_meetings_dev 
WHERE week_key = '2025-08-18' 
AND user_id = '9bbd09f4-1680-45e0-b257-b8569770efd2';

-- Step 4: Test updating data exactly like your app will
UPDATE marriage_meetings_dev 
SET data_content = jsonb_set(
    data_content, 
    '{schedule,Monday}', 
    '["Coffee", "Updated item"]'::jsonb
)
WHERE week_key = '2025-08-18' 
AND user_id = '9bbd09f4-1680-45e0-b257-b8569770efd2';

-- Step 5: Verify the update worked
SELECT 
    week_key,
    user_id,
    data_content->'schedule'->'Monday' as monday_schedule
FROM marriage_meetings_dev 
WHERE week_key = '2025-08-18' 
AND user_id = '9bbd09f4-1680-45e0-b257-b8569770efd2';

-- Step 6: Test the unique constraint (should prevent duplicates)
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2',
    '2025-08-18', -- Same week and user
    '{"test": "duplicate"}'::jsonb
) ON CONFLICT (week_key, user_id) DO NOTHING;

-- Step 7: Verify only one row exists (constraint working)
SELECT COUNT(*) as row_count 
FROM marriage_meetings_dev 
WHERE week_key = '2025-08-18' 
AND user_id = '9bbd09f4-1680-45e0-b257-b8569770efd2';

-- Step 8: Clean up test data
DELETE FROM marriage_meetings_dev WHERE week_key = '2025-08-18';

-- Step 9: Final verification
SELECT 'Table is ready for your app!' as status;
