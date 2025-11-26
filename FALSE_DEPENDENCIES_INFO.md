# False Dependencies Test Setup

## Overview
This repository contains intentionally mismatched dependencies between `package.json` and `package-lock.json` for testing purposes.

## The Inconsistency

### package.json
- Declares `lodash: ^4.17.21` (version 4.x)

### package-lock.json
- Root package lists `lodash: ^4.17.21`
- **BUT** `node_modules/lodash` specifies version `3.10.1` (old version)

### src/App.jsx
- Imports lodash: `import _ from 'lodash'`
- Uses `_.upperCase()` method which only exists in lodash 4.x+
- This method does NOT exist in lodash 3.10.1

## Expected Behavior

### ❌ npm ci - FAILURE (Detects Mismatch)
```bash
npm ci
```
- **FAILS immediately** with error: `Invalid: lock file's lodash@3.10.1 does not satisfy lodash@4.17.21`
- Does not install anything
- This is the correct behavior - validates lockfile integrity

### ⚠️ npm install - "Fixes" the Mismatch (Not Recommended)
```bash
npm install
```
- Detects the mismatch between package.json and package-lock.json
- **Automatically updates** package-lock.json to lodash 4.17.21
- Installs the updated version
- **Succeeds** but modifies the lockfile
- This is why npm ci should be used in production/CI environments

### ❌ npm run dev - FAILURE (If npm ci was somehow forced to install)
```bash
npm run dev
```
- If lodash 3.10.1 was installed (hypothetically)
- App imports lodash and calls `_.upperCase()`
- **RUNTIME ERROR**: `_.upperCase is not a function`
- The app fails to start because lodash 3.10.1 doesn't have this method

## Why This Happens

1. **npm ci** strictly follows package-lock.json and installs exact versions
2. **npm ci** doesn't validate if installed versions match code requirements
3. The code expects features from lodash 4.x but gets 3.10.1
4. Runtime failure occurs when trying to use non-existent methods

## How to Fix (For Reference)

To resolve this and get the app working:

```bash
# Option 1: Let npm install fix it (updates lockfile)
npm install

# Option 2: Manually install correct version
npm install lodash@^4.17.21

# Option 3: Start fresh
rm -rf node_modules package-lock.json
npm install
```

## Why npm install Can't Be Prevented from "Fixing" Mismatches

**Technical Limitation:** `npm install` is designed to resolve dependency conflicts automatically. It:
1. Reads package.json and package-lock.json
2. Detects any mismatches
3. **Updates package-lock.json automatically** (before any scripts run)
4. Runs preinstall scripts (after lockfile is already updated)
5. Installs packages

There's no way to prevent step 3 with preinstall hooks because they run after the lockfile is already modified.

**This is why `npm ci` exists:**
- `npm ci` requires exact lockfile match
- Fails fast if there's any mismatch
- Never modifies package-lock.json
- Perfect for CI/CD and production environments

## Test Scenario

This setup is useful for testing:
- Dependency resolution edge cases
- CI/CD pipeline validation
- Package manager behavior with lockfile inconsistencies
- Runtime vs install-time error detection

## Technical Details

**Lodash 3.10.1 vs 4.17.21:**
- `_.upperCase()` was introduced in lodash 4.0.0
- Lodash 3.x uses different method names (e.g., `_.capitalize()`)
- The version mismatch creates a silent failure during install
- Error only surfaces at runtime when code executes

## Note

This is an **intentional** configuration for testing purposes. In production, package.json and package-lock.json should always be in sync.

