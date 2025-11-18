# Warmup Script Test Guide

This project has been configured to test a warmup script scenario where dependencies need to be checked and installed before running the Vite development server.

## Dependencies Added for Testing

### Runtime Dependencies (production)
- **axios** (^1.6.2) - HTTP client library
  - Used in: `App.jsx` for API status checking
- **clsx** (^2.0.0) - Utility for constructing className strings
  - Used in: `App.jsx` for conditional CSS classes on navigation
- **date-fns** (^2.30.0) - Date utility library
  - Used in: `App.jsx` for date formatting in the navigation bar

### Development Dependencies
- **sass** (^1.69.5) - CSS preprocessor
  - Used in: `src/styles.scss` (SCSS stylesheet)
  - Imported in: `App.jsx`
- **vite-plugin-inspect** (^0.8.1) - Vite plugin for inspecting the intermediate state
  - Used in: `vite.config.js`

## How These Dependencies Are Used

1. **SCSS/Sass**: A `styles.scss` file has been created with Martian theme variables and mixins that get compiled during the Vite build process.

2. **Axios**: Imported and initialized in `App.jsx` with a useEffect hook that runs on component mount.

3. **clsx**: Used to conditionally apply CSS classes to the navigation bar (`mars-glow` effect).

4. **date-fns**: Used to format and display the current date in the navigation bar.

5. **vite-plugin-inspect**: Configured in `vite.config.js` to provide development tooling.

## Testing the Warmup Script

### Scenario 1: Fresh Clone (No node_modules)
```bash
# Clone the repo (or simulate by removing node_modules)
rm -rf node_modules

# Run warmup script
bash warmup-example.sh

# The script should:
# 1. Detect missing node_modules
# 2. Run npm install
# 3. Verify all dependencies are present
# 4. Confirm the app is ready to run
```

### Scenario 2: Partial Installation
```bash
# Install base dependencies
npm install

# Remove specific dependencies to simulate incomplete installation
rm -rf node_modules/axios
rm -rf node_modules/sass

# Run warmup script
bash warmup-example.sh

# The script should:
# 1. Detect missing specific dependencies
# 2. Run npm install to fix them
# 3. Verify integrity
```

### Scenario 3: Complete Installation
```bash
# With all dependencies installed
npm install

# Run warmup script
bash warmup-example.sh

# The script should:
# 1. Confirm all dependencies are present
# 2. Skip installation
# 3. Verify integrity
# 4. Report ready status
```

## What Will Fail Without Dependencies

If you try to run `npm run dev` without the dependencies installed:

1. **Without sass**: Vite will fail to compile `styles.scss` imports
2. **Without axios**: Module import error in `App.jsx`
3. **Without clsx**: Module import error in `App.jsx`
4. **Without date-fns**: Module import error in `App.jsx`
5. **Without vite-plugin-inspect**: Vite config will fail to load

## Environment Compatibility

All dependencies are compatible with the remote environment:
- **Node.js v20.19.2** ✓
- **npm 10.8.2** ✓
- **Ubuntu 24.04.2 LTS** ✓
- **linux/amd64** ✓

## Running the Dev Server

After successful warmup:
```bash
npm run dev
```

The server will start on `http://localhost:3000` and you should see:
- The date displayed in the navigation bar (using date-fns)
- SCSS styles applied (using sass)
- Navigation with conditional classes (using clsx)
- Axios loaded confirmation in the component state

## Customizing the Warmup Script

The included `warmup-example.sh` is a reference implementation. Your actual warmup script should:

1. **Check Node.js/npm availability** (already available in remote env)
2. **Check for package.json** (required)
3. **Check node_modules existence**
4. **Detect missing specific dependencies**
5. **Run `npm install` when needed**
6. **Verify dependency integrity**
7. **Validate configuration files**
8. **Report status clearly**

## Additional Notes

- All dependencies use semantic versioning (^) to allow compatible updates
- The example script uses bash, but could be adapted to Node.js
- Dependencies are production-tested and stable
- No C++ compilation or native modules required (pure JS/TS)

