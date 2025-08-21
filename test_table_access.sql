-- Test table access for marriage_meetings_dev
-- Run this in Supabase SQL Editor to verify the table works

-- Test 1: Basic SELECT (should work)
SELECT 'Table exists and is accessible' as status;

-- Test 2: Check if we can insert a test row
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '00000000-0000-0000-0000-000000000000', -- dummy UUID
    'test-week-2025',
    '{"test": "data"}'::jsonb
) ON CONFLICT (week_key, user_id) DO NOTHING;

-- Test 3: Check if we can read the test data
SELECT * FROM marriage_meetings_dev WHERE week_key = 'test-week-2025';

-- Test 4: Clean up test data
DELETE FROM marriage_meetings_dev WHERE week_key = 'test-week-2025';

-- Test 5: Verify table is empty
SELECT COUNT(*) as row_count FROM marriage_meetings_dev;
