# React + Vite - Warmup Script Test Project

This project is configured to test warmup scripts that check and install dependencies before running a Vite development server in a remote environment.

## ⚠️ IMPORTANT: Use npm ci Only

**This project MUST use `npm ci` instead of `npm install`.**

`npm ci` is required because it:
- Enforces strict lockfile consistency
- Validates that package.json and package-lock.json are in sync
- Provides reproducible builds in CI/CD environments
- Fails fast if dependencies are out of sync

## 🎯 Purpose

This setup simulates a real-world scenario where a project is cloned into a remote environment and a warmup script must:
1. Verify that required dependencies are installed
2. Detect missing dependencies
3. Install any missing dependencies using **npm ci**
4. Validate that the application is ready to run

## 🚀 Quick Start

### Option 1: Normal Setup
```bash
# REQUIRED: Use npm ci instead of npm install
npm ci
npm run dev
```

### Option 2: Test Warmup Script
```bash
# Run the example warmup script (uses npm ci internally)
./warmup-example.sh

# Then start dev server
npm run dev
```

## 📦 Dependencies for Testing

This project includes several dependencies that **must be present** for the dev server to run:

### Runtime Dependencies
- `axios` - HTTP client (used in App component)
- `clsx` - CSS class utility (used in navigation)
- `date-fns` - Date formatting (used in navigation)
- `react` & `react-dom` - React framework

### Development Dependencies
- `vite` - Build tool and dev server
- `sass` - SCSS preprocessor (compiles styles.scss)
- `vite-plugin-inspect` - Vite plugin (configured in vite.config.js)
- `@vitejs/plugin-react` - React plugin for Vite
- `eslint` & plugins - Linting

## 🧪 Testing Scenarios

### Scenario 1: Missing node_modules
```bash
# Remove all dependencies
rm -rf node_modules

# Run warmup script (should install everything using npm ci)
./warmup-example.sh

# Verify with dev server
npm run dev
```

### Scenario 2: Missing specific dependencies
```bash
# Ensure base installation using npm ci
npm ci

# Remove specific dependencies
rm -rf node_modules/axios node_modules/sass

# Run warmup script (should detect and fix using npm ci)
./warmup-example.sh

# Verify
npm run dev
```

### Scenario 3: Everything installed
```bash
# Full installation using npm ci
npm ci

# Run warmup script (should verify and pass)
./warmup-example.sh
```

### Scenario 4: Lockfile Out of Sync
```bash
# If package.json and package-lock.json are out of sync
# npm ci will fail with an error message

# DO NOT use npm install to fix it in production
# Instead, ensure your lockfile is properly updated in development first
```

## 🌍 Remote Environment Compatibility

Target Environment: **Ubuntu 24.04.2 LTS (linux/amd64)**

Pre-installed tools:
- ✅ Node.js v20.19.2
- ✅ npm 10.8.2
- ✅ Yarn 1.22.22
- ✅ git, make, cmake, gcc, g++

All dependencies in this project are compatible with this environment.

## 📝 How Dependencies Are Used

1. **SCSS (`sass`)**: `src/styles.scss` contains Martian theme styles with variables and mixins
2. **Axios**: Imported in `App.jsx` with useEffect for status checking
3. **clsx**: Used for conditional CSS classes on the navigation element
4. **date-fns**: Formats current date displayed in navigation bar
5. **vite-plugin-inspect**: Configured in `vite.config.js` for dev tooling

## ⚠️ What Fails Without Dependencies

Without proper dependencies installed, `npm run dev` will fail with:
- **Missing sass**: Cannot compile `.scss` imports
- **Missing axios/clsx/date-fns**: Module not found errors in JavaScript
- **Missing vite-plugin-inspect**: Vite config fails to load

## 🚫 Why NOT npm install?

**Always use `npm ci` in this project, NOT `npm install`:**

| Command | Use Case | Behavior |
|---------|----------|----------|
| `npm ci` | **Production/CI/CD** ✅ | Installs from lockfile, fails if out of sync, removes node_modules first |
| `npm install` | Development only ❌ | Modifies lockfile, resolves versions, not reproducible |

**In remote/production environments, `npm ci` ensures:**
- Exact same dependency versions every time
- Fast, reliable installations
- Early detection of lockfile issues
- No unexpected dependency updates

## 📚 Documentation

See `WARMUP_TEST_GUIDE.md` for detailed testing instructions and warmup script implementation guide.

## 🛠️ Available Scripts

- **`npm ci`** - Install dependencies (REQUIRED - use this, not npm install)
- `npm run dev` - Start development server (port 3000)
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `./warmup-example.sh` - Run example warmup script (uses npm ci internally)

## 🎨 Project Features

This is a fun "Mars Attacks!" themed React application with:
- Interactive particle system
- Multi-language support (EN/RU)
- Multiple pages (Home, HTML Elements, Interactive Components)
- Responsive design
- SCSS styling with theme variables
