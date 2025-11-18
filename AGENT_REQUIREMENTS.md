# Agent Requirements for Non-Interactive Installation

## 🎯 Purpose

This project requires **non-interactive mode** during `npm ci` or `npm install` because postinstall scripts use `npx` commands that would prompt for user confirmation.

## ⚠️ Critical Requirement

Your warmup agent **MUST** set these environment variables before running npm:

```bash
export CI=true
export npm_config_yes=true
```

## Why This Is Required

### Postinstall Scripts in package.json:
```json
{
  "postinstall": "npx --yes patch-package || true",
  "prepare": "npx --yes simple-git-hooks || echo 'Skipping git hooks in CI'"
}
```

### Without Non-Interactive Flags (FAILS):
```bash
npm ci

# npx prompts:
# "Need to install the following packages: patch-package. Ok to proceed? (y)"
# ❌ Hangs waiting for input
# ❌ Agent timeout/failure
```

### With Non-Interactive Flags (WORKS):
```bash
export CI=true
export npm_config_yes=true
npm ci

# ✅ Automatically proceeds
# ✅ Installation completes
```

## Agent Implementation

### Minimum Required:
```bash
#!/bin/bash
export CI=true
export npm_config_yes=true
npm ci
```

### Recommended (Full):
```bash
#!/bin/bash
set -e

# CRITICAL: Set non-interactive mode
export CI=true
export npm_config_yes=true

# Verify environment
command -v node &> /dev/null || exit 1
command -v npm &> /dev/null || exit 1

# Install dependencies (postinstall runs automatically)
npm ci

echo "✅ Installation complete"
```

## What Gets Installed

**New dependencies that trigger postinstall:**
- `patch-package` (8.0.0) - Applies patches to node_modules
- `simple-git-hooks` (2.9.0) - Sets up git hooks

**Total:** ~247 packages including all sub-dependencies

## Verification

After installation, you should see:
```
> demo-project@0.0.0 postinstall
> npx --yes patch-package || true
patch-package 8.0.1
Applying patches...

> demo-project@0.0.0 prepare
> npx --yes simple-git-hooks || echo 'Skipping git hooks in CI'
[INFO] Successfully set all git hooks

added 247 packages
```

## Environment Compatibility

✅ **Ubuntu 24.04.2 LTS**
✅ **Node.js v20.19.2**
✅ **npm 10.8.2**
✅ All dependencies are pure JavaScript (no native compilation)

## Summary

**Without CI flags:** Installation hangs on npx prompts
**With CI flags:** Installation completes successfully

Your agent must set `CI=true` and `npm_config_yes=true` before running npm commands!

