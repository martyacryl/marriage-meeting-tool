-- Development Database Setup for Marriage Meeting Tool
-- This script creates a development environment with separate tables and policies

-- Create development table (separate from production)
CREATE TABLE IF NOT EXISTS marriage_meetings_dev (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    data_type TEXT NOT NULL CHECK (data_type IN ('schedule', 'todo', 'prayer', 'goals', 'grocery', 'unconfessed_sin', 'weekly_winddown')),
    data_content JSONB NOT NULL,
    week_start DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_marriage_meetings_dev_user_id ON marriage_meetings_dev(user_id);
CREATE INDEX IF NOT EXISTS idx_marriage_meetings_dev_data_type ON marriage_meetings_dev(data_type);
CREATE INDEX IF NOT EXISTS idx_marriage_meetings_dev_week_start ON marriage_meetings_dev(week_start);

-- Enable Row Level Security
ALTER TABLE marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

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

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_marriage_meetings_dev_updated_at
    BEFORE UPDATE ON marriage_meetings_dev
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert some sample development data (optional)
-- This can be used to test the system
INSERT INTO marriage_meetings_dev (user_id, data_type, data_content, week_start) VALUES
(
    (SELECT id FROM auth.users LIMIT 1), -- Replace with actual user ID if needed
    'schedule',
    '{"monday": ["Morning coffee", "Evening walk"], "tuesday": ["Date night", "Budget review"]}',
    CURRENT_DATE - INTERVAL '7 days'
),
(
    (SELECT id FROM auth.users LIMIT 1), -- Replace with actual user ID if needed
    'todo',
    '["Plan vacation", "Fix garage door", "Call insurance"]',
    CURRENT_DATE - INTERVAL '7 days'
),
(
    (SELECT id FROM auth.users LIMIT 1), -- Replace with actual user ID if needed
    'prayer',
    '["Family health", "Career guidance", "Relationship strength"]',
    CURRENT_DATE - INTERVAL '7 days'
)
ON CONFLICT DO NOTHING;

-- Grant necessary permissions
GRANT ALL ON marriage_meetings_dev TO authenticated;
GRANT ALL ON marriage_meetings_dev TO service_role;

-- Create a view for easier data access (optional)
CREATE OR REPLACE VIEW marriage_meetings_dev_view AS
SELECT 
    mm.id,
    mm.user_id,
    u.email,
    mm.data_type,
    mm.data_content,
    mm.week_start,
    mm.created_at,
    mm.updated_at
FROM marriage_meetings_dev mm
JOIN auth.users u ON mm.user_id = u.id;

-- Grant permissions on the view
GRANT SELECT ON marriage_meetings_dev_view TO authenticated;
GRANT SELECT ON marriage_meetings_dev_view TO service_role;

-- Display setup completion message
DO $$
BEGIN
    RAISE NOTICE 'Development database setup completed successfully!';
    RAISE NOTICE 'Table: marriage_meetings_dev';
    RAISE NOTICE 'RLS policies created and enabled';
    RAISE NOTICE 'Sample data inserted (if users exist)';
    RAISE NOTICE 'Remember to test with a development user account';
END $$;
