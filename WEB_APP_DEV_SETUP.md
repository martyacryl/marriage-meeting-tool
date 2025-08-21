# Web App Development Setup

This guide shows you how to set up a development environment that mirrors production exactly, just with separate Supabase tables and Netlify projects.

## 🚀 Quick Setup

### 1. Create Development Supabase Table

Run this in your Supabase SQL Editor:

```sql
-- Create development table
CREATE TABLE IF NOT EXISTS marriage_meetings_dev (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    data_type TEXT NOT NULL CHECK (data_type IN ('schedule', 'todo', 'prayer', 'goals', 'grocery', 'unconfessed_sin', 'weekly_winddown')),
    data_content JSONB NOT NULL,
    week_start DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE marriage_meetings_dev ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view own data (dev)" ON marriage_meetings_dev
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own data (dev)" ON marriage_meetings_dev
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own data (dev)" ON marriage_meetings_dev
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own data (dev)" ON marriage_meetings_dev
    FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Service role full access (dev)" ON marriage_meetings_dev
    FOR ALL USING (auth.role() = 'service_role');
```

### 2. Create Development Netlify Project

1. **Fork/Clone** your repository to a new GitHub repo (e.g., `marriage-meeting-tool-dev`)
2. **Create Netlify Project**:
   - Connect to your dev GitHub repo
   - Set build command: `echo "No build needed"`
   - Set publish directory: `.`
   - Deploy

3. **Update Config**: Replace `your-dev-app.netlify.app` in `config.js` with your actual dev Netlify URL

### 3. Test Development Environment

1. **Open dev.html** in your browser
2. **Load Mock Data** using the dev tools button
3. **Test All Features** - everything should work exactly like production
4. **Check Console** for `[DEV]` logs

## 🔄 Development Workflow

### Daily Development
1. **Edit dev.html** with your changes
2. **Test locally** by opening dev.html in browser
3. **Push to dev repo** when ready to test online
4. **Test on Netlify** to ensure it works in production-like environment
5. **Merge to main** when features are ready

### Testing
- **Local Testing**: Open dev.html directly in browser
- **Online Testing**: Deploy to dev Netlify and test there
- **Production Testing**: Test on main Netlify before final deployment

## 📁 File Structure

```
marriage-meeting-tool/
├── index.html              # Production version
├── dev.html               # Development version  
├── config.js              # Environment config
├── setup_dev_database.sql # Dev database setup
├── WEB_APP_DEV_SETUP.md  # This guide
└── README.md              # Production docs
```

## ⚙️ Environment Switching

### Development (Default)
- Opens `dev.html`
- Uses `marriage_meetings_dev` table
- Debug logging enabled
- Mock data available

### Production
- Opens `index.html` 
- Uses `marriage_meetings` table
- Debug logging disabled
- No mock data

## 🧪 Testing Features

### Development Tools
- **Mock Data**: Pre-populate with sample data
- **Data Clearing**: Reset all data
- **Debug Logging**: Monitor operations
- **Admin Panel**: Development statistics

### What to Test
1. **All List Types**: Todo, prayer, goals, grocery, etc.
2. **Schedule Management**: Add/remove weekly activities
3. **Data Persistence**: Verify data saves correctly
4. **User Isolation**: Ensure data privacy
5. **Admin Functions**: Test user management

## 🚨 Troubleshooting

### Common Issues

#### Table Not Found
- Run the SQL setup script in Supabase
- Check table name in config.js
- Verify RLS policies are created

#### Data Not Saving
- Check browser console for errors
- Verify Supabase connection
- Check user authentication

#### Mock Data Not Loading
- Ensure `enableMockData: true` in config
- Check console for error messages
- Verify localStorage permissions

## 🔄 Deployment

### Development to Production
1. **Test thoroughly** in development environment
2. **Copy working code** from dev.html to index.html
3. **Update config** to use production table
4. **Deploy to production** Netlify
5. **Test production** to ensure everything works

### Branch Strategy
- **Main Branch**: Production-ready code
- **Dev Branch**: Development and testing
- **Feature Branches**: Individual features

## 💡 Tips

- **Always test locally** before pushing to dev
- **Use mock data** to test without real data
- **Check console logs** for debugging info
- **Test on Netlify** to catch deployment issues
- **Keep dev and prod** as similar as possible

---

**That's it!** Simple web app development with separate tables and projects. No Node.js, no weird JavaScript - just pure web app development like production.
