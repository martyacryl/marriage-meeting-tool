-- Development Database Setup for Marriage Meeting Tool
-- This script creates a development environment with the correct table structure

-- Drop existing table if it exists to recreate with correct structure
DROP TABLE IF EXISTS marriage_meetings_dev CASCADE;

-- Create development table with the structure the app expects
CREATE TABLE marriage_meetings_dev (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    week_key TEXT NOT NULL,
    data_content JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create unique constraint on week_key and user_id (this is what the app expects)
ALTER TABLE marriage_meetings_dev ADD CONSTRAINT marriage_meetings_dev_week_key_user_id_key UNIQUE (week_key, user_id);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_marriage_meetings_dev_user_id ON marriage_meetings_dev(user_id);
CREATE INDEX IF NOT EXISTS idx_marriage_meetings_dev_week_key ON marriage_meetings_dev(week_key);

-- Enable Row Level Security
ALTER TABLE marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Drop existing policies first to avoid conflicts
DROP POLICY IF EXISTS "Users can view own data (dev)" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Users can insert own data (dev)" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Users can update own data (dev)" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Users can delete own data (dev)" ON marriage_meetings_dev;
DROP POLICY IF EXISTS "Service role full access (dev)" ON marriage_meetings_dev;

-- Create RLS policies for development
-- Policy 1: Users can only see their own data
CREATE POLICY "Users can view own data (dev)" ON marriage_meetings_dev
    FOR SELECT USING (auth.uid() = user_id);

-- Policy 2: Users can insert their own data
CREATE POLICY "Users can insert own data (dev)" ON marriage_meetings_dev
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Policy 3: Users can update their own data
CREATE POLICY "Users can update own data (dev)" ON marriage_meetings_dev
    FOR UPDATE USING (auth.uid() = user_id);

-- Policy 4: Users can delete their own data
CREATE POLICY "Users can delete own data (dev)" ON marriage_meetings_dev
    FOR DELETE USING (auth.uid() = user_id);

-- Policy 5: Service role can access all data (for admin functions)
CREATE POLICY "Service role full access (dev)" ON marriage_meetings_dev
    FOR ALL USING (auth.role() = 'service_role');

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Drop existing trigger if it exists
DROP TRIGGER IF EXISTS update_marriage_meetings_dev_updated_at ON marriage_meetings_dev;

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_marriage_meetings_dev_updated_at
    BEFORE UPDATE ON marriage_meetings_dev
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Grant necessary permissions
GRANT ALL ON marriage_meetings_dev TO authenticated;
GRANT ALL ON marriage_meetings_dev TO service_role;

-- Display setup completion message
DO $$
BEGIN
    RAISE NOTICE 'Development database setup completed successfully!';
    RAISE NOTICE 'Table: marriage_meetings_dev';
    RAISE NOTICE 'Structure: id, user_id, week_key, data_content, created_at, updated_at';
    RAISE NOTICE 'Unique constraint: week_key + user_id';
    RAISE NOTICE 'RLS policies created and enabled';
    RAISE NOTICE 'Ready for app to use!';
END $$;
