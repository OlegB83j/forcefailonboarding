# Quick Start Guide - Warmup Script Testing

## 🎯 What This Project Tests

This project simulates a **real-world deployment scenario** where:
1. Code is cloned to a remote environment
2. A warmup script must check for dependencies
3. Missing dependencies must be installed automatically
4. The dev server must start successfully

## 📦 What's Been Added

### New Dependencies
```json
{
  "dependencies": {
    "axios": "^1.6.2",      // Used in App.jsx for API calls
    "clsx": "^2.0.0",       // Used in App.jsx for CSS classes
    "date-fns": "^2.30.0"   // Used in App.jsx for date formatting
  },
  "devDependencies": {
    "sass": "^1.69.5",                // Compiles src/styles.scss
    "vite-plugin-inspect": "^0.8.1"   // Used in vite.config.js
  }
}
```

### New Files
- `warmup-example.sh` - Example warmup script
- `test-scenarios.sh` - Helper to test different scenarios
- `verify-setup.cjs` - Verification script
- `src/styles.scss` - SCSS stylesheet
- `WARMUP_TEST_GUIDE.md` - Detailed guide
- `SETUP_SUMMARY.md` - Technical summary
- `QUICK_START.md` - This file

## 🚀 Quick Test (5 minutes)

### Step 1: Verify Current State
```bash
node verify-setup.cjs
```

Expected output: ❌ FAILED (because node_modules is missing)

### Step 2: Run Warmup Script
```bash
./warmup-example.sh
```

This will:
- ✅ Check Node.js/npm
- ✅ Detect missing dependencies
- ✅ Run `npm install`
- ✅ Verify all packages load correctly

### Step 3: Verify Again
```bash
node verify-setup.cjs
```

Expected output: ✅ PASSED

### Step 4: Start Dev Server
```bash
npm run dev
```

Visit http://localhost:3000 to see the app running with all dependencies working.

## 🧪 Test Different Scenarios

### Scenario 1: Fresh Clone (No Dependencies)
```bash
# Setup
rm -rf node_modules

# Test warmup
./warmup-example.sh

# Verify
npm run dev
```

### Scenario 2: Missing Specific Dependencies
```bash
# Use the helper script
./test-scenarios.sh
# Select option 2

# Test warmup
./warmup-example.sh

# Verify
npm run dev
```

### Scenario 3: Everything Installed
```bash
# Ensure everything is installed
npm install

# Test warmup (should skip installation)
./warmup-example.sh

# Verify
npm run dev
```

## ✅ Success Indicators

When everything works correctly, you should see:

1. **Warmup Script Output:**
   ```
   ✓ Checking Node.js...
   ✓ Checking npm...
   ✓ Checking dependencies...
   ✓ All critical dependencies are present
   ✓ Verifying dependency integrity...
   ✓ Validating Vite configuration...
   ✅ Warmup complete! Ready to start dev server.
   ```

2. **Dev Server Starts:**
   ```
   VITE v7.0.4  ready in XXX ms
   ➜  Local:   http://localhost:3000/
   ```

3. **In Browser:**
   - Page loads without errors
   - Date appears in navigation (using date-fns)
   - SCSS styles applied correctly
   - No console errors

## 🔍 How Dependencies Are Used

### Runtime (Browser)
- **axios**: Loaded in App.jsx, ready for API calls
- **clsx**: Applied to navigation element for conditional classes
- **date-fns**: Formats and displays current date in nav bar

### Build Time (Development)
- **sass**: Compiles `src/styles.scss` to CSS
- **vite-plugin-inspect**: Adds dev tooling to Vite

## ⚠️ What Fails Without Dependencies

Try it yourself:

```bash
# Remove dependencies
rm -rf node_modules

# Try to start dev server
npm run dev
```

**Result:** ❌ Fails with errors:
- Cannot find module 'axios'
- Cannot find module 'sass'
- Cannot find module 'vite-plugin-inspect'
- etc.

**After warmup:**
```bash
./warmup-example.sh
npm run dev
```

**Result:** ✅ Works perfectly!

## 🌍 Remote Environment

**Target:** Ubuntu 24.04.2 LTS (linux/amd64)

**Available:**
- ✅ Node.js v20.19.2
- ✅ npm 10.8.2
- ✅ Yarn 1.22.22

**Compatible:** All dependencies are pure JavaScript, no native compilation needed.

## 📝 For Your Remote Script

Your actual warmup script should do:

```bash
#!/bin/bash
# 1. Clone repository
git clone <repo-url> && cd <project>

# 2. Check and install dependencies
./warmup-example.sh

# 3. Start dev server
npm run dev

# 4. Verify it's running
curl http://localhost:3000
```

## 🔧 Commands Reference

| Command | Purpose |
|---------|---------|
| `node verify-setup.cjs` | Check project setup |
| `./warmup-example.sh` | Run warmup/dependency check |
| `./test-scenarios.sh` | Setup test scenarios |
| `npm install` | Manually install dependencies |
| `npm run dev` | Start development server |
| `npm run build` | Build for production |

## 📚 More Information

- **WARMUP_TEST_GUIDE.md** - Comprehensive testing guide
- **SETUP_SUMMARY.md** - Technical details of changes
- **README.md** - Updated project README

## 🎉 You're All Set!

This project is now configured to test warmup scripts that handle dependency installation. Clone it to your remote environment and test your automation!

**Key takeaway:** The warmup script should detect missing dependencies and install them before attempting to start the dev server.

