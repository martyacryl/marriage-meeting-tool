# Marriage Meeting Tool - Development Guide

This is the development version of the Marriage Meeting Tool, designed for testing, debugging, and development work without affecting production data.

## 🚧 Development Features

### Environment Management
- **Separate Database Table**: Uses `marriage_meetings_dev` table instead of production
- **Configuration File**: `config.js` manages environment-specific settings
- **URL Parameters**: Switch environments using `?env=development` or `?env=production`

### Enhanced Debugging
- **Console Logging**: Detailed logging with `[DEV]` prefix
- **Debug Mode Toggle**: Enable/disable debug logging on the fly
- **Data Tracking**: Monitor all data changes and operations

### Development Tools
- **Mock Data Loading**: Pre-populate with sample data for testing
- **Data Clearing**: Reset all data to start fresh
- **Admin Panel**: Development-specific admin interface
- **Floating Dev Tools**: Quick access to development features

### Data Storage
- **LocalStorage Primary**: Data stored locally for fast development
- **Supabase Backup**: Optional cloud backup (development table)
- **Mock Data**: Sample data for immediate testing

## 🚀 Quick Start (Development)

### 1. Database Setup
```sql
-- Run in Supabase SQL Editor
\i setup_dev_database.sql
```

### 2. Open Development Version
- **Development**: `dev.html` (default)
- **Production**: `index.html`
- **Environment Switch**: Add `?env=development` or `?env=production` to URL

### 3. Test Features
- Load mock data using the dev tools button (bottom right)
- Toggle debug logging
- Use the development admin panel
- Test all functionality with sample data

## 🔧 Development Workflow

### Local Development
1. **Clone Repository**: `git clone <repo-url>`
2. **Switch to Dev Branch**: `git checkout dev`
3. **Open dev.html**: Start with development version
4. **Make Changes**: Edit code and test immediately
5. **Test Features**: Use mock data and dev tools
6. **Commit Changes**: `git add . && git commit -m "feature: description"`

### Testing
1. **Load Mock Data**: Use dev tools to populate with sample data
2. **Test All Features**: Schedule, lists, navigation, etc.
3. **Check Console**: Monitor debug logs and errors
4. **Verify Data**: Ensure localStorage and Supabase sync correctly

### Debugging
1. **Enable Debug Logging**: Toggle in dev tools
2. **Monitor Console**: Watch for `[DEV]` prefixed logs
3. **Use Admin Panel**: Check data statistics and environment info
4. **Clear Data**: Reset to clean state when needed

## 📁 File Structure

```
marriage-meeting-tool/
├── index.html              # Production version
├── dev.html               # Development version
├── config.js              # Environment configuration
├── setup_dev_database.sql # Development database setup
├── DEV_README.md          # This file
├── README.md              # Production documentation
└── ...                    # Other production files
```

## ⚙️ Configuration

### Environment Variables
The `config.js` file manages different environments:

```javascript
const config = {
  development: {
    tableName: 'marriage_meetings_dev',
    enableDebugLogging: true,
    enableMockData: true,
    environment: 'development'
  },
  production: {
    tableName: 'marriage_meetings',
    enableDebugLogging: false,
    enableMockData: false,
    environment: 'production'
  }
};
```

### Switching Environments
- **Default**: Development environment
- **URL Parameter**: `?env=production` for production
- **Dynamic**: Environment detected automatically

## 🛠️ Development Tools

### Floating Dev Tools Button
- **Location**: Bottom right corner (red button with gear icon)
- **Features**:
  - Load Mock Data
  - Clear All Data
  - Toggle Debug Logging
  - Environment Information

### Development Admin Panel
- **Access**: Click "Show Dev Admin" button
- **Features**:
  - Data Statistics
  - Environment Information
  - Development Notes
  - Quick Data Overview

### Mock Data
Pre-populated sample data includes:
- **Schedule**: Weekly activities for each day
- **Lists**: Todo, prayer, goals, grocery, etc.
- **Realistic Content**: Marriage-focused examples

## 🔍 Debugging Features

### Console Logging
```javascript
// All development operations are logged
devLog('Adding item to todo:', item);
devLog('Data saved to localStorage');
devLog('Navigated to previous week:', newWeek);
```

### Data Tracking
- **LocalStorage Operations**: All saves/loads logged
- **State Changes**: Component state updates tracked
- **User Actions**: All user interactions logged
- **Error Handling**: Detailed error information

### Performance Monitoring
- **Data Operations**: Track data save/load times
- **State Updates**: Monitor React state changes
- **Memory Usage**: Watch for memory leaks

## 🧪 Testing Scenarios

### Basic Functionality
1. **Add/Remove Items**: Test all list types
2. **Schedule Management**: Add activities to different days
3. **Week Navigation**: Move between weeks
4. **Data Persistence**: Verify localStorage saves

### Edge Cases
1. **Empty Inputs**: Try adding empty items
2. **Large Data**: Test with many items
3. **Special Characters**: Test with unusual text
4. **Network Issues**: Test offline functionality

### Integration Testing
1. **Mock Data Loading**: Verify sample data populates correctly
2. **Data Clearing**: Ensure all data is removed
3. **Environment Switching**: Test different configurations
4. **Admin Functions**: Verify development admin panel

## 🚨 Troubleshooting

### Common Issues

#### Mock Data Not Loading
- Check if `enableMockData` is true in config
- Verify console for error messages
- Ensure localStorage permissions

#### Debug Logging Not Working
- Check if `enableDebugLogging` is true
- Verify console is open
- Look for `[DEV]` prefixed messages

#### Data Not Saving
- Check localStorage permissions
- Verify Supabase connection
- Check console for errors

#### Environment Issues
- Verify `config.js` is loaded
- Check URL parameters
- Ensure correct table names

### Debug Steps
1. **Open Console**: Check for error messages
2. **Verify Config**: Ensure correct environment loaded
3. **Test localStorage**: Check browser storage
4. **Check Network**: Verify Supabase connection
5. **Use Dev Tools**: Load mock data and test

## 📝 Development Notes

### Best Practices
- **Always Test**: Use mock data before testing with real data
- **Monitor Console**: Keep debug logging enabled during development
- **Clear Data**: Reset data when testing new features
- **Document Changes**: Update this README when adding features

### Code Organization
- **Components**: Modular React components
- **State Management**: Local state with localStorage backup
- **Error Handling**: Comprehensive error catching and logging
- **Performance**: Optimized for development workflow

### Future Enhancements
- **Unit Tests**: Add Jest/React Testing Library
- **E2E Tests**: Add Cypress or Playwright
- **Hot Reloading**: Implement development server
- **TypeScript**: Add type safety
- **Storybook**: Component documentation

## 🔄 Deployment

### Development to Production
1. **Test Thoroughly**: Use all development features
2. **Update Config**: Ensure production settings
3. **Deploy Files**: Upload to hosting service
4. **Verify Functionality**: Test in production environment

### Branch Management
- **Main Branch**: Production-ready code
- **Dev Branch**: Development and testing
- **Feature Branches**: Individual feature development
- **Pull Requests**: Code review before merging

## 📞 Support

### Development Issues
- Check console for error messages
- Verify configuration settings
- Test with mock data
- Review this documentation

### Production Issues
- Check production README
- Verify Supabase configuration
- Test authentication setup
- Review deployment process

---

**Happy Developing! 🚀**

Remember: This is a development environment - feel free to experiment, break things, and learn from the process!
