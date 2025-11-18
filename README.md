# React + Vite - Warmup Script Test Project

This project is configured to test warmup scripts that check and install dependencies before running a Vite development server in a remote environment.

## 🎯 Purpose

This setup simulates a real-world scenario where a project is cloned into a remote environment and a warmup script must:
1. Verify that required dependencies are installed
2. Detect missing dependencies
3. Install any missing dependencies
4. Validate that the application is ready to run

## 🚀 Quick Start

### Option 1: Normal Setup
```bash
npm install
npm run dev
```

### Option 2: Test Warmup Script
```bash
# Run the example warmup script
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

# Run warmup script (should install everything)
./warmup-example.sh

# Verify with dev server
npm run dev
```

### Scenario 2: Missing specific dependencies
```bash
# Ensure base installation
npm install

# Remove specific dependencies
rm -rf node_modules/axios node_modules/sass

# Run warmup script (should detect and fix)
./warmup-example.sh

# Verify
npm run dev
```

### Scenario 3: Everything installed
```bash
# Full installation
npm install

# Run warmup script (should verify and pass)
./warmup-example.sh
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

## 📚 Documentation

See `WARMUP_TEST_GUIDE.md` for detailed testing instructions and warmup script implementation guide.

## 🛠️ Available Scripts

- `npm run dev` - Start development server (port 3000)
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `./warmup-example.sh` - Run example warmup script

## 🎨 Project Features

This is a fun "Mars Attacks!" themed React application with:
- Interactive particle system
- Multi-language support (EN/RU)
- Multiple pages (Home, HTML Elements, Interactive Components)
- Responsive design
- SCSS styling with theme variables
