#!/bin/bash
# Test scenarios for the warmup script
# This script helps you test different dependency scenarios

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}  Warmup Script Test Scenarios${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Function to backup node_modules
backup_node_modules() {
    if [ -d "node_modules" ]; then
        echo -e "${YELLOW}Backing up node_modules...${NC}"
        mv node_modules node_modules.backup
    fi
}

# Function to restore node_modules
restore_node_modules() {
    if [ -d "node_modules.backup" ]; then
        echo -e "${YELLOW}Restoring node_modules...${NC}"
        rm -rf node_modules
        mv node_modules.backup node_modules
    fi
}

# Display menu
echo "Select a test scenario:"
echo ""
echo "1) Test with no node_modules (fresh install)"
echo "2) Test with missing specific dependencies (axios, sass)"
echo "3) Test with all dependencies present"
echo "4) Restore backup and exit"
echo ""
read -p "Enter choice [1-4]: " choice

case $choice in
    1)
        echo ""
        echo -e "${BLUE}=== Scenario 1: No node_modules ===${NC}"
        backup_node_modules
        echo -e "${GREEN}✓ Removed node_modules${NC}"
        echo ""
        echo "Now run: ./warmup-example.sh"
        ;;
    2)
        echo ""
        echo -e "${BLUE}=== Scenario 2: Missing specific dependencies ===${NC}"
        
        # Ensure we have a base installation
        if [ ! -d "node_modules" ]; then
            echo -e "${YELLOW}Installing base dependencies first...${NC}"
            npm install --silent
        fi
        
        # Remove specific dependencies
        echo -e "${YELLOW}Removing axios, sass, and vite-plugin-inspect...${NC}"
        rm -rf node_modules/axios
        rm -rf node_modules/sass
        rm -rf node_modules/vite-plugin-inspect
        
        echo -e "${GREEN}✓ Removed specific dependencies${NC}"
        echo ""
        echo "Now run: ./warmup-example.sh"
        ;;
    3)
        echo ""
        echo -e "${BLUE}=== Scenario 3: All dependencies present ===${NC}"
        
        if [ ! -d "node_modules" ]; then
            echo -e "${YELLOW}Installing all dependencies...${NC}"
            npm install
        fi
        
        echo -e "${GREEN}✓ All dependencies installed${NC}"
        echo ""
        echo "Now run: ./warmup-example.sh"
        ;;
    4)
        echo ""
        restore_node_modules
        echo -e "${GREEN}✓ Backup restored${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${YELLOW}Scenario ready! Next steps:${NC}"
echo "  1. Run: ./warmup-example.sh"
echo "  2. Then: npm run dev"
echo ""
echo -e "${YELLOW}To restore your original setup:${NC}"
echo "  ./test-scenarios.sh (and select option 4)"
echo ""

