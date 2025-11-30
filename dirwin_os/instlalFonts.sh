#!/usr/bin/env bash
# Nerd Fonts Installer (macOS & Linux) - downloads and installs latest Nerd Fonts
# Fixes multiple issues in the original script

set -euo pipefail

# Destination directory
FONTS_DIR="${HOME}/Library/Fonts/"
[[ "$(uname)" == "Linux" ]] && FONTS_DIR="${HOME}/.local/share/fonts/"

mkdir -p "$FONTS_DIR"
cd /tmp

# List of Nerd Fonts to install (without "Nerd Font" suffix - that's how they're named in releases)
fonts=(
	"CascadiaCode"
	"FiraCode"
	"Hack"
	"Inconsolata"
	"JetBrainsMono"
	"Meslo"
	"Mononoki"
	"RobotoMono"
	"SourceCodePro"
	"UbuntuMono"
)

echo -e "\033[1;34mInstalling Nerd Fonts to $FONTS_DIR\033[0m"

for font in "${fonts[@]}"; do
	echo -e "\033[1;36m==> \033[1;33mInstalling $font Nerd Font\033[1;36m <==\033[0m"

	# Correct archive name (as of 2025, still .tar.xz)
	archive="${font}.tar.xz"
	url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${archive}"

	# Download
	if ! wget -q --show-progress "$url" -O "$archive"; then
		echo -e "\033[1;31mFailed to download $font\033[0m"
		continue
	fi

	# Extract directly into fonts directory (no subfolder needed)
	echo "Extracting $archive..."
	mkdir -p "$FONTS_DIR/$font"
	tar -xJf "$archive" -C "$FONTS_DIR/$font" --strip-components=0

	# Clean up
	rm -f "$archive"
done

# Refresh font cache
echo -e "\033[1;32mUpdating font cache...\033[0m"
if command -v fc-cache >/dev/null 2>&1; then
	fc-cache -fv >/dev/null
else
	echo "fc-cache not found (common on some macOS setups), restarting might be needed."
fi

echo -e "\033[1;32mAll done! Installed ${#fonts[@]} Nerd Fonts.\033[0m"
