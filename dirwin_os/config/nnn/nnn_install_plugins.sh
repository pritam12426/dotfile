#!/bin/bash
set -euo pipefail # Good practice: exit on error, unset vars, and pipe failures

# Colors for pretty output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== nnn plugins installer ===${NC}"

# Determine plugins directory (XDG compliant)
PLUGINS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins"

echo -e "${YELLOW}→ Target plugins directory:${NC} $PLUGINS_DIR"

# Create directory if it doesn't exist
if mkdir -p "$PLUGINS_DIR" 2>/dev/null; then
	echo -e "${GREEN}✓ Created plugins directory${NC}"
else
	# mkdir -p rarely fails, but just in case
	if [[ -d $PLUGINS_DIR ]]; then
		echo -e "${GREEN}✓ Plugins directory already exists${NC}"
	else
		echo -e "${RED}✗ Failed to create plugins directory: $PLUGINS_DIR${NC}" >&2
		exit 1
	fi
fi

# Check if source plugins exist
if [[ ! -d "./plugins" ]]; then
	echo -e "${RED}✗ Error: ./plugins directory not found in current path!${NC}" >&2
	echo "    Make sure you're running this script from the correct location." >&2
	exit 1
fi

if [ -z "$(ls -A ./plugins/*.npl ./plugins/* 2>/dev/null || true)" ]; then
	echo -e "${YELLOW}! Warning: No plugins found in ./plugins/${NC}"
else
	echo -e "${YELLOW}→ Found plugins, copying to $PLUGINS_DIR...${NC}"
fi

# Copy plugins
if cp -vp ./plugins/* "$PLUGINS_DIR"/ 2>/dev/null; then
	echo -e "${GREEN}✓ Successfully installed nnn plugins!${NC}"
	echo -e "${BLUE}You can now use them in nnn. Restart nnn if it's already running.${NC}"
else
	echo -e "${RED}✗ Failed to copy some plugins (check permissions or disk space)${NC}\a" >&2
	exit 1
fi

echo -e "${BLUE}=== Installation complete ===${NC}"
