#!/bin/bash -x
# file -> updateNNN.sh

# working file with nnn v5.1

NNN_PATCH="$DOT_FILE/config/nnn/patchs/"
NNN_LOCAL_REPO="$HOME/Developer/git_repository/online-repos/nnn"

export PREFIX="$HOME/.local"

applyPatch() {
	# Apply your patch
	if git apply --check "$1" 2> /dev/null; then
		git apply "$1"
	else
		echo "⚠ Patch failed to apply cleanly — attempting 3-way merge"
		git apply --3way "$1" || {
			echo "❌ Patch could not be applied. Manual fix required."
			exit 1
		}
	fi
}

if [ ! -d "$NNN_LOCAL_REPO" ]; then
	echo "Cloning nnn repository..."
	git clone git@github.com:jarun/nnn.git "$NNN_LOCAL_REPO"
	sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
fi

builtin cd "$NNN_LOCAL_REPO" || exit 1

# Hard reset to upstream
git clean -dfx
git checkout -f
git pull --rebase

applyPatch "$NNN_PATCH/nnn-builtin-cd-lastdir-v5.patch"
applyPatch "$NNN_PATCH/icons-v5.2.patch"

# Your custom header
command cp -p "$DOT_FILE/config/nnn/patchs/nnn-v5.h" src/nnn.h

# O_NOFIFO=1 \
make \
	O_PCRE2=1 \
	O_NOMOUSE=1 \
	O_GITSTATUS=1 \
	O_EMOJI=1 \
	O_NOX11=1 \
	clean strip install

cp -p "$NNN_LOCAL_REPO/misc/auto-completion/zsh/_nnn" "$HOME/.local/share/zsh/site-functions/_nnn"

if [ -f "$HOME/.config/nnn/plugins/.ntfy" ]; then
	mv "$HOME/.config/nnn/plugins/.ntfy" "$HOME/.config/nnn/plugins/.ntfy-bk"
fi

if [ -f "$HOME/.config/nnn/plugins/.cbcp" ]; then
	mv "$HOME/.config/nnn/plugins/.cbcp" "$HOME/.config/nnn/plugins/.cbcp-bk"
fi
