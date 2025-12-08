export NNN_ORDER;

# export HTML_TIDY="$HOME/.config/tidy/tidyrc"
export PANDOC_CONFIG="$HOME/.config/pandoc/"
export ARIA2C_SESSION_TOKEN="8adabed3-e9db-4ef4-acb3-ba56af3b6c4f"

alias utm-l="utm start '74116267-CFC1-4A5F-BE9A-E682419A3DA8' & ssh l"


function ssh-push() {
	scp -r "$1" pritam@192.168.64.9:/home/pritam/sent-ssh/
}

function ssh-pull() {
	scp -r "$HOME/Downloads" "$1"
}

# === Java ===
export JAVA_HOME="/Users/pritam/.local/dev-tools/jdk-21.0.8.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export MANPATH="$JAVA_HOME/man:$MANPATH"

# === Android SDK ===
export ANDROID_HOME="/Users/pritam/.local/dev-tools/android-sdk-tools"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
# export PATH="$ANDROID_HOME/platform-tools:$PATH"
# export PATH="$ANDROID_HOME/emulator:$PATH"
# alias apktool="java -jar $ANDROID_HOME/reverse-engineering/dex-tools-v2.4/bin/apktool_2.12.1.jar "
# alias dex-tools="$ANDROID_HOME/reverse-engineering/dex-tools-v2.4/bin/dex-tools "


# === Flutter ===
export PATH="$ANDROID_HOME/flutter/bin:$PATH"

# === GO ===
export GOPATH="$HOME/.local/dev-tools/dev–libs–packages"
export PATH="$GOPATH/bin:$PATH"

# === RUST ===
export RUST_HOME="/Users/pritam/.local/dev-tools/rust-1.91.0";
export PATH="$RUST_HOME/bin:$PATH"
export PATH="$RUST_HOME/cargo/bin:$PATH"
# export PATH="$RUST_HOME/lib/rustlib/aarch64-apple-darwin/bin:$PATH"
export MANPATH="$RUST_HOME/share/man:$MANPATH"
export CARGO_HOME="$RUST_HOME/cargo"
# export CARGO_TARGET_DIR="$RUST_HOME/../dev–libs–packages/cargo/bin"
# . "$HOME/.cargo/env"


# =========================================================================
# -------------------------------------------------------------------------
# Node config
# -------------------------------------------------------------------------
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.local/dev-tools/dev–libs–packages/node_modules/bin:$PATH"
# =========================================================================


# === VCPGK ===
# export VCPKG_ROOT="/Users/pritam/Downloads/vcpkg/vcpkg-2025.10.17"    # new version
# export VCPKG_ROOT="/Users/pritam/Downloads/vcpkg/vcpkg-2025.09.17"    # old version
export VCPKG_ROOT="$HOME/Downloads/vcpkg/vcpkg"                         # with git

export CMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
export PKG_CONFIG_PATH="$VCPKG_ROOT/installed/arm64-osx-dynamic/share/pkgconfig:$PKG_CONFIG_PATH"
export VCPKG_DOWNLOADS="$HOME/.cache/vcpkg-downloads"
export VCPKG_TARGET_ARCHITECTURE="arm64"
export VCPKG_TARGET_TRIPLET="arm64-osx"
# export VCPKG_DEFAULT_TRIPLET=arm64-osx-dynamic
# export VCPKG_OVERLAY_TRIPLETS="$HOME/my-vcpplet-triplets"



source /Users/pritam/.config/broot/launcher/bash/br
