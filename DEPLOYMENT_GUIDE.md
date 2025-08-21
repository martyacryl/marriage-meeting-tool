# Deployment Guide - Marriage Meeting Tool

This guide shows you how to deploy both development and production versions from the same repository using different branches.

## 🌿 **Branch Structure**

- **`main`** → Production deployment
- **`development`** → Development deployment

## 🚀 **Development Netlify Setup**

### **1. Create Development Project**
1. Go to [Netlify](https://netlify.com) and sign in
2. Click **"New site from Git"**
3. Choose **GitHub** and authorize
4. Select repo: `martyacryl/marriage-meeting-tool`
5. **Important**: Choose branch `development` (not main!)
6. Build settings:
   - Build command: `echo "No build needed"`
   - Publish directory: `.`
7. Click **"Deploy site"**

### **2. Update Configuration**
Once deployed, copy your development Netlify URL and update `config.js`:

```javascript
development: {
  // ... other settings ...
  netlifyUrl: 'https://your-actual-dev-url.netlify.app' // Replace this
}
```

### **3. Test Development**
- Your development site will automatically deploy from the `development` branch
- Any changes you push to `development` will auto-deploy
- Test features, debug logging, and mock data

## 🚀 **Production Netlify Setup**

### **1. Create Production Project**
1. Go to [Netlify](https://netlify.com) and sign in
2. Click **"New site from Git"**
3. Choose **GitHub** and authorize
4. Select repo: `martyacryl/marriage-meeting-tool`
5. **Important**: Choose branch `main` (production)
6. Build settings:
   - Build command: `echo "No build needed"`
   - Publish directory: `.`
7. Click **"Deploy site"**

### **2. Update Configuration**
Once deployed, copy your production Netlify URL and update `config.js`:

```javascript
production: {
  // ... other settings ...
  netlifyUrl: 'https://your-actual-prod-url.netlify.app' // Replace this
}
```

## 🔄 **Development Workflow**

### **Daily Development**
1. **Work on `development` branch**
2. **Test locally** by opening `dev.html` in browser
3. **Push changes** to `development` branch
4. **Auto-deploy** to development Netlify
5. **Test online** to ensure it works in production-like environment

### **Ready for Production**
1. **Test thoroughly** on development Netlify
2. **Merge to `main`**: `git checkout main && git merge development`
3. **Push to main**: `git push origin main`
4. **Auto-deploy** to production Netlify
5. **Verify production** works correctly

## 📱 **Testing Both Environments**

### **Development Testing**
- **URL**: Your development Netlify URL
- **Features**: Debug logging, mock data, dev tools
- **Database**: `marriage_meetings_dev` table
- **Purpose**: Feature development and testing

### **Production Testing**
- **URL**: Your production Netlify URL
- **Features**: Clean, optimized for users
- **Database**: `marriage_meetings` table
- **Purpose**: Live user access

## 🚨 **Important Notes**

- **Never deploy `development` branch to production**
- **Always test on development Netlify first**
- **Keep both environments in sync** (same code, different configs)
- **Use mock data** for development testing
- **Monitor console logs** for debugging

## 🔧 **Troubleshooting**

### **Development Not Deploying**
- Check that Netlify is connected to `development` branch
- Verify build settings are correct
- Check GitHub for any build errors

### **Production Not Deploying**
- Check that Netlify is connected to `main` branch
- Verify you've merged changes from development
- Check that production config is correct

### **Database Issues**
- Development uses `marriage_meetings_dev` table
- Production uses `marriage_meetings` table
- Verify RLS policies are set up correctly

---

**That's it!** You now have a clean development workflow with separate environments but everything in one repository.
