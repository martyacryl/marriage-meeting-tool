-- Test if app can read data from Supabase
-- Run this in Supabase SQL Editor

-- Step 1: Insert test data exactly like your app would
INSERT INTO marriage_meetings_dev (user_id, week_key, data_content) 
VALUES (
    '9bbd09f4-1680-45e0-b257-b8569770efd2', -- Your actual user ID
    '2025-08-18', -- Week your app is trying to load
    '{"schedule": {"Monday": ["Test from Supabase"], "Tuesday": ["Database working"]}, "todos": ["Test todo"], "prayers": ["Test prayer"], "goals": ["Test goal"], "grocery": ["Test item"], "unconfessedSin": [], "weeklyWinddown": ["Test activity"]}'::jsonb
);

-- Step 2: Verify the data was inserted
SELECT 
    week_key,
    user_id,
    data_content->'schedule'->'Monday' as monday_schedule,
    data_content->'todos' as todos
FROM marriage_meetings_dev 
WHERE week_key = '2025-08-18' 
AND user_id = '9bbd09f4-1680-45e0-b257-b8569770efd2';

-- Step 3: Show all data in the table
SELECT COUNT(*) as total_rows FROM marriage_meetings_dev;
