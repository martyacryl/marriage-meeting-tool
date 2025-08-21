-- Simple table recreation
-- Run this in Supabase SQL Editor

-- Create the table
CREATE TABLE marriage_meetings_dev (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID,
    week_key TEXT,
    data_content JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add unique constraint
ALTER TABLE marriage_meetings_dev ADD CONSTRAINT marriage_meetings_dev_week_key_user_id_key UNIQUE (week_key, user_id);

-- Enable RLS
ALTER TABLE marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Create simple policy
CREATE POLICY "Allow all" ON marriage_meetings_dev FOR ALL USING (true);

-- Grant permissions
GRANT ALL ON marriage_meetings_dev TO authenticated;
GRANT ALL ON marriage_meetings_dev TO service_role;

-- Verify table exists
SELECT 'Table created successfully' as status;
