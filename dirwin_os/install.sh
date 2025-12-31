#!/bin/zsh -x
# Note: definitely I am using ./config/.zsh  folder to store the configuration of ZSH but behind the scene, it is important to
# PUT sim link to ~

[ -e $HOME/.hushlogin ] || touch $HOME/.hushlogin

# if "$HOME/.zshenv"  not exists
if [ ! -f "$HOME/.zshenv" ]; then
	echo "[ -f "$HOME/.config/zsh/zshenv-header.zsh" ] && source "$HOME/.config/zsh/zshenv-header.zsh"" >> ~/.zshenv
	source "$HOME/.zshenv"
fi

ln -sf  "$DOT_FILE/config/zsh/zshrc.zsh"     "$HOME/.zshrc"    && source "$HOME/.zshrc"
ln -sf  "$DOT_FILE/config/zsh/zprofile.zsh"  "$HOME/.zprofile" && source "$HOME/.zprofile"

ln -sf  "$DOT_FILE/config/git/gitconfig"     "$HOME/.gitconfig"
ln -sf  "$DOT_FILE/cargo_config.toml"        "$CARGO_HOME/"
ln -sf  "$DOT_FILE/bashrc.bash"              "$HOME/.bashrc"
ln -sf  "$DOT_FILE/wgetrc"                   "$HOME/.wgetrc"
ln -sf  "$DOT_FILE/curlrc"                   "$HOME/.curlrc"

# Tighten permissions on `~/.ssh' directory
# chmod go-rwx $HOME.ssh/*

mkdir  -p "$HOME/.config/"
ln -sf  "$DOT_FILE/config/aria2"              "$HOME/.config/"
ln -sf  "$DOT_FILE/config/bat"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/broot"              "$HOME/.config/"
ln -sf  "$DOT_FILE/config/btop"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/fastfetch"          "$HOME/.config/"
ln -sf  "$DOT_FILE/config/fd"                 "$HOME/.config/"
ln -sf  "$DOT_FILE/config/fzf"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/git"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/glance"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/helix"              "$HOME/.config/"
ln -sf  "$DOT_FILE/config/homebrew"           "$HOME/.config/"
ln -sf  "$DOT_FILE/config/htop"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/iina-mpv"           "$HOME/.config/"
ln -sf  "$DOT_FILE/config/joshuto"            "$HOME/.config/"
ln -sf  "$DOT_FILE/config/karabiner"          "$HOME/.config/"
ln -sf  "$DOT_FILE/config/lf"                 "$HOME/.config/"
ln -sf  "$DOT_FILE/config/mpv"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/navi"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/navidrome"          "$HOME/.config/"
ln -sf  "$DOT_FILE/config/newsboat"           "$HOME/.config/"
ln -sf  "$DOT_FILE/config/ncdu"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/npm"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/nvim"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/pandoc"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/pip"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/radare2"            "$HOME/.config/"
ln -sf  "$DOT_FILE/config/rclone"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/readeck"            "$HOME/.config/"
ln -sf  "$DOT_FILE/config/ripgrep"            "$HOME/.config/"
ln -sf  "$DOT_FILE/config/ripgrep"            "$HOME/.config/"
ln -sf  "$DOT_FILE/config/ruff"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/ruff"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/shiori"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/taplo"              "$HOME/.config/"
ln -sf  "$DOT_FILE/config/task"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/tidy"               "$HOME/.config/"
ln -sf  "$DOT_FILE/config/tig"                "$HOME/.config/"
ln -sf  "$DOT_FILE/config/tealdeer"           "$HOME/.config/"
ln -sf  "$DOT_FILE/config/wireproxy"          "$HOME/.config/"
ln -sf  "$DOT_FILE/config/yt-dlp"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/zellij"             "$HOME/.config/"
ln -sf  "$DOT_FILE/config/zsh"                "$HOME/.config/"


mkdir -p "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/config/zed/snippets"           "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/config/zed/keymap.json"        "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/config/zed/settings.json"      "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/config/zed/zedtasks.json"      "$HOME/.config/zed/"


mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/etc"
mkdir -p "$HOME/.local/share"

ln -sf   "$DOT_FILE/scripts/about_github_repo.py"  "$HOME/.local/bin/aboutrepo"
ln -sf   "$DOT_FILE/scripts/comp.sh"               "$HOME/.local/bin/rr"
ln -sf   "$DOT_FILE/scripts/create-class.sh"       "$HOME/.local/bin/create-class"
ln -sf   "$DOT_FILE/scripts/extractor.sh"          "$HOME/.local/bin/zzz"
ln -sf   "$DOT_FILE/scripts/f.sh"                  "$HOME/.local/bin/f"
ln -sf   "$DOT_FILE/scripts/ff.py"                 "$HOME/.local/bin/ff"
ln -sf   "$DOT_FILE/scripts/fff.py"                "$HOME/.local/bin/fff"
ln -sf   "$DOT_FILE/scripts/fix-ugly-name.py"      "$HOME/.local/bin/fix-ugly-name"
ln -sf   "$DOT_FILE/scripts/fix-ugly-name.py"      "$HOME/.local/bin/rrr"
ln -sf   "$DOT_FILE/scripts/fontify.py"            "$HOME/.local/bin/fontify"
ln -sf   "$DOT_FILE/scripts/gDrive.sh"             "$HOME/.local/bin/gDrive"
ln -sf   "$DOT_FILE/scripts/make-archive.sh"       "$HOME/.local/bin/fff"
ln -sf   "$DOT_FILE/scripts/message.sh"            "$HOME/.local/bin/message"
ln -sf   "$DOT_FILE/scripts/extract-cookies.sh"    "$HOME/.local/bin/extract-cookies"
ln -sf   "$DOT_FILE/scripts/notify.sh"             "$HOME/.local/bin/notify"
ln -sf   "$DOT_FILE/scripts/zed-root.sh"           "$HOME/.local/bin/zed-root"


ln -sf "$DOT_FILE/binary/adbtuifm"         "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/aria2c"           "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/clock"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/entr"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/envpath"          "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/exiv2"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/fclones"          "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/gsed"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/htop"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/live-server"      "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/ncdu"             "$HOME/.local/bin/"
# ln -sf "$DOT_FILE/binary/nnn"              "$HOME/.local/bin/"
# ln -sf "$DOT_FILE/binary/nnn-all"          "$HOME/.local/bin/nnn"
ln -sf "$DOT_FILE/binary/pkgconf"          "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/pstree"           "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/tidy-html"        "$HOME/.local/bin/tidy"
ln -sf "$DOT_FILE/binary/tig"              "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/tree"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/typst-live"       "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/vim-htop"         "$HOME/.local/bin/v-htop"
ln -sf "$DOT_FILE/binary/wget"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/wget2"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/binary/xxc-with-c"       "$HOME/.local/bin/xxc"


ln -sf   "$DOT_FILE/../global/age.py"                                 "$HOME/.local/bin/age"
ln -sf   "$DOT_FILE/config/rclone/backup_scripts/syncLocalfiles.py"   "$HOME/.local/bin/syncLocalfiles"


mkdir -p  ~/Library/Preferences/navi/
ln -sf "$DOT_FILE/config/navi/config.yaml" ~/Library/Preferences/navi/

mkdir -p ~/Library/Application\ Support/tealdeer/
ln -sf "$DOT_FILE/config/tealdeer/config.toml" ~/Library/Application\ Support/tealdeer/



## Some online download and install
# https://github.com/peterkaminski/obsidian-settings-manager/blob/main/osm.py
echo "Downloading Obsidian Settings Manager (osm) ..."
curl -fsSL "https://raw.githubusercontent.com/peterkaminski/obsidian-settings-manager/main/osm.py" \
	-o "$HOME/.local/bin/osm" \
	&& chmod +x "$HOME/.local/bin/osm"

echo "Downloading mac-cleanup ..."
curl -fsSL "https://raw.githubusercontent.com/mac-cleanup/mac-cleanup-sh/refs/heads/main/mac-cleanup" \
	-o "$HOME/.local/bin/mac-cleanup" \
	&& chmod +x "$HOME/.local/bin/mac-cleanup"
