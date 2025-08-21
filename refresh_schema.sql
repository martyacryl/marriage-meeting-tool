-- Refresh schema cache and verify table exists
-- Run this in Supabase SQL Editor

-- Check if table exists
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'marriage_meetings_dev'
ORDER BY ordinal_position;

-- Refresh the schema cache (this might help with the 404 errors)
NOTIFY pgrst, 'reload schema';

-- Show table structure using standard SQL
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'marriage_meetings_dev'
ORDER BY ordinal_position;
