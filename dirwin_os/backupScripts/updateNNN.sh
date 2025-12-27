#!/bin/bash -x

# working file with nnn v5.1

NNN_LOCAL_REPO="$HOME/Developer/git_repository/online-repos/nnn"

export PREFIX="$HOME/.local"

if [ ! -d "$NNN_LOCAL_REPO" ]; then
	echo "Cloning nnn repository..."
	git clone git@github.com:jarun/nnn.git "$NNN_LOCAL_REPO"
	# Install plugins
	sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
else
	cd "$NNN_LOCAL_REPO" || exit 1
	git clean -dfx
	git checkout -f
	git pull
fi

command cp -p "$DOT_FILE/../global/nnn.h" src/nnn.h

make \
O_PCRE2=1 \
O_NOMOUSE=1 \
O_GITSTATUS=1 \
clean strip install

cp -p "$NNN_LOCAL_REPO/misc/auto-completion/zsh/_nnn" "$HOME/.local/share/zsh/site-functions/_nnn"

if [ -f "$HOME/.config/nnn/plugins/.ntfy" ]; then
	cp -p "$HOME/.config/nnn/plugins/.ntfy" "$HOME/.config/nnn/plugins/.ntfy-bk"
fi

if [ -f "$HOME/.config/nnn/plugins/.cbcp" ]; then
	cp -p "$HOME/.config/nnn/plugins/.cbcp" "$HOME/.config/nnn/plugins/.cbcp-bk"
fi
