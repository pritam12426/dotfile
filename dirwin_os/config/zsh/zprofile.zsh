# printf "Importing \t %s \n" "$HOME/.zprofile"


# ===========================================================================================================
if [[ -f "$RUST_HOME" ]]; then
	export PATH="$RUST_HOME/bin:$PATH"
	export PATH="$RUST_HOME/cargo/bin:$PATH"
	export MANPATH="$RUST_HOME/share/man:$MANPATH"
	export CARGO_HOME="$HOME/.local/lib/cargo/cargo"

	# export PATH="$RUST_HOME/lib/rustlib/aarch64-apple-darwin/bin:$PATH"
	# . "$HOME/.cargo/env"
fi


if [[ -f "$VCPKG_ROOT" ]]; then
	export CMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
	export PKG_CONFIG_PATH="$VCPKG_ROOT/installed/arm64-osx-dynamic/share/pkgconfig:$PKG_CONFIG_PATH"
	export VCPKG_DOWNLOADS="$HOME/.cache/vcpkg-downloads"
	export VCPKG_TARGET_ARCHITECTURE="arm64"
	export VCPKG_TARGET_TRIPLET="arm64-osx"

	# export VCPKG_DEFAULT_TRIPLET=arm64-osx-dynamic
	# export VCPKG_OVERLAY_TRIPLETS="$HOME/my-vcpplet-triplets"
fi


if [[ -f "$JAVA_HOME" ]]; then
	export PATH="$JAVA_HOME/bin:$PATH"
	export MANPATH="$JAVA_HOME/man:$MANPATH"
fi


if [[ -f "$NPM_CONFIG_USERCONFIG" ]]; then
	export PNPM_HOME="$HOME/Library/pnpm"
	export PATH="$PNPM_HOME:$PATH"
	export PATH="$HOME/.local/dev-tools/dev–libs–packages/node_modules/bin:$PATH"
fi


if [[ -f "$GOPATH" ]]; then
	export PATH="$GOPATH/bin:$PATH"
fi


if [[ -f "$ANDROID_HOME" ]]; then
	export PATH="$ANDROID_HOME/flutter/bin:$PATH"
	export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

	# export PATH="$ANDROID_HOME/platform-tools:$PATH"
	# export PATH="$ANDROID_HOME/emulator:$PATH"
	# alias apktool="java -jar $ANDROID_HOME/reverse-engineering/dex-tools-v2.4/bin/apktool_2.12.1.jar "
	# alias dex-tools="$ANDROID_HOME/reverse-engineering/dex-tools-v2.4/bin/dex-tools "
fi
# ===========================================================================================================
