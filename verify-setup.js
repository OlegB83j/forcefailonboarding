#!/usr/bin/env node
/**
 * Verification script to check that all dependencies can be loaded
 * This simulates what the warmup script checks
 */

const fs = require('fs');
const path = require('path');

console.log('🔍 Verifying project setup...\n');

let hasErrors = false;

// Check package.json exists
console.log('1. Checking package.json...');
if (!fs.existsSync('package.json')) {
  console.error('  ❌ package.json not found!');
  hasErrors = true;
} else {
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
  console.log('  ✅ package.json found');
  
  // Check for required dependencies
  const requiredDeps = ['axios', 'clsx', 'date-fns', 'react', 'react-dom'];
  const requiredDevDeps = ['vite', 'sass', 'vite-plugin-inspect', '@vitejs/plugin-react'];
  
  console.log('\n2. Checking dependencies in package.json...');
  requiredDeps.forEach(dep => {
    if (pkg.dependencies && pkg.dependencies[dep]) {
      console.log(`  ✅ ${dep}: ${pkg.dependencies[dep]}`);
    } else {
      console.error(`  ❌ ${dep} not found in dependencies`);
      hasErrors = true;
    }
  });
  
  console.log('\n3. Checking devDependencies in package.json...');
  requiredDevDeps.forEach(dep => {
    if (pkg.devDependencies && pkg.devDependencies[dep]) {
      console.log(`  ✅ ${dep}: ${pkg.devDependencies[dep]}`);
    } else {
      console.error(`  ❌ ${dep} not found in devDependencies`);
      hasErrors = true;
    }
  });
}

// Check if node_modules exists
console.log('\n4. Checking node_modules...');
if (!fs.existsSync('node_modules')) {
  console.warn('  ⚠️  node_modules not found - run npm install');
  hasErrors = true;
} else {
  console.log('  ✅ node_modules exists');
  
  // Check specific modules
  console.log('\n5. Checking installed packages...');
  const checkModules = [
    'axios',
    'clsx',
    'date-fns',
    'react',
    'react-dom',
    'vite',
    'sass',
    'vite-plugin-inspect',
    '@vitejs/plugin-react'
  ];
  
  checkModules.forEach(mod => {
    const modPath = path.join('node_modules', mod);
    if (fs.existsSync(modPath)) {
      console.log(`  ✅ ${mod}`);
    } else {
      console.error(`  ❌ ${mod} - missing in node_modules`);
      hasErrors = true;
    }
  });
}

// Check critical files
console.log('\n6. Checking project files...');
const criticalFiles = [
  'vite.config.js',
  'src/App.jsx',
  'src/styles.scss',
  'src/index.css',
  'src/App.css'
];

criticalFiles.forEach(file => {
  if (fs.existsSync(file)) {
    console.log(`  ✅ ${file}`);
  } else {
    console.error(`  ❌ ${file} not found`);
    hasErrors = true;
  }
});

// Try to load dependencies
if (fs.existsSync('node_modules')) {
  console.log('\n7. Testing module imports...');
  try {
    require('axios');
    console.log('  ✅ axios can be imported');
  } catch (e) {
    console.error(`  ❌ axios import failed: ${e.message}`);
    hasErrors = true;
  }
  
  try {
    require('clsx');
    console.log('  ✅ clsx can be imported');
  } catch (e) {
    console.error(`  ❌ clsx import failed: ${e.message}`);
    hasErrors = true;
  }
  
  try {
    require('date-fns');
    console.log('  ✅ date-fns can be imported');
  } catch (e) {
    console.error(`  ❌ date-fns import failed: ${e.message}`);
    hasErrors = true;
  }
  
  try {
    require('sass');
    console.log('  ✅ sass can be imported');
  } catch (e) {
    console.error(`  ❌ sass import failed: ${e.message}`);
    hasErrors = true;
  }
  
  try {
    require('vite');
    console.log('  ✅ vite can be imported');
  } catch (e) {
    console.error(`  ❌ vite import failed: ${e.message}`);
    hasErrors = true;
  }
}

// Final summary
console.log('\n' + '='.repeat(50));
if (hasErrors) {
  console.error('\n❌ Verification FAILED - issues detected');
  console.log('\nTo fix, run:');
  console.log('  npm install');
  console.log('  # or');
  console.log('  ./warmup-example.sh');
  process.exit(1);
} else {
  console.log('\n✅ Verification PASSED - project is ready!');
  console.log('\nYou can now run:');
  console.log('  npm run dev');
  process.exit(0);
}

