#!/bin/bash -x

ln -sf "$DOT_FILE/dirwin_os/config/git/gitconfig"      "$HOME/.gitconfig"
ln -sf  "$DOT_FILE/dirwin_os/config.toml"              "$CARGO_HOME/"
ln -sf  "$DOT_FILE/dirwin_os/bashrc"                   "$HOME/.bashrc"
ln -sf  "$DOT_FILE/dirwin_os/zshrc"                    "$HOME/.zshrc"
# ln -sf  "$DOT_FILE/dirwin_os/zshenv"                    "$HOME/.zshenv"


mkdir  -p "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/aria2"              "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/btop"               "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/broot"              "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/bat"                "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/fd"                 "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/gdu"                "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/git"                "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/htop"               "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/iina-mpv"           "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/joshuto"            "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/karabiner"          "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/lf"                 "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/mpv"                "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/ncdu"               "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/nvim"               "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/pandoc"             "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/radare2"            "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/ripgrep"            "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/tig"                "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/wireproxy"          "$HOME/.config/"
ln -sf  "$DOT_FILE/dirwin_os/config/yt-dlp"             "$HOME/.config/"

mkdir -p "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/dirwin_os/config/zed"/snippets       "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/dirwin_os/config/zed"/keymap.json    "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/dirwin_os/config/zed"/settings.json  "$HOME/.config/zed/"
ln -sf   "$DOT_FILE/dirwin_os/config/zed"/zedtasks.json  "$HOME/.config/zed/"


mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/etc"
mkdir -p "$HOME/.local/share"
ln -sf   "$DOT_FILE/dirwin_os/bin/comp.sh"               "$HOME/.local/bin/rr"
ln -sf   "$DOT_FILE/dirwin_os/bin/create-class.sh"       "$HOME/.local/bin/create-class"
ln -sf   "$DOT_FILE/dirwin_os/bin/extractor.sh"          "$HOME/.local/bin/zzz"
ln -sf   "$DOT_FILE/dirwin_os/bin/f.sh"                  "$HOME/.local/bin/f"
ln -sf   "$DOT_FILE/dirwin_os/bin/ff.py"                 "$HOME/.local/bin/ff"
ln -sf   "$DOT_FILE/dirwin_os/bin/fff.py"                "$HOME/.local/bin/fff"
ln -sf   "$DOT_FILE/dirwin_os/bin/aboutrepo.sh"          "$HOME/.local/bin/aboutrepo"
ln -sf   "$DOT_FILE/dirwin_os/bin/make-archive.sh"       "$HOME/.local/bin/fff"
ln -sf   "$DOT_FILE/dirwin_os/bin/rename_pwd.py"         "$HOME/.local/bin/rrr"
ln -sf   "$DOT_FILE/dirwin_os/bin/zed-root.sh"           "$HOME/.local/bin/zed-root"

ln -sf   "$DOT_FILE/global/osm.py"                       "$HOME/.local/bin/osm"
ln -sf   "$DOT_FILE/global/age.py"                       "$HOME/.local/bin/age"

sudo mkdir -p /usr/local/bin/
sudo ln -sf "$DOT_FILE/dirwin_os/bin/binary/ncat"     /usr/local/bin/
sudo ln -sf "$DOT_FILE/dirwin_os/bin/binary/ndiff"    /usr/local/bin/
sudo ln -sf "$DOT_FILE/dirwin_os/bin/binary/nping"    /usr/local/bin/
sudo ln -sf "$DOT_FILE/dirwin_os/bin/binary/nmap"     /usr/local/bin/


ln -sf "$DOT_FILE/dirwin_os/bin/binary/adbtuifm"         "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/aria2c"           "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/clock"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/entr"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/envpath"          "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/exiv2"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/gsed"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/htop"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/live-server"      "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/ncdu"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/nnn"              "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/nnn-all"          "$HOME/.local/bin/"
# ln -sf "$DOT_FILE/dirwin_os/bin/binary/pkgconf"          "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/tig"              "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/vim-htop"         "$HOME/.local/bin/v-htlp"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/wget"             "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/wget2"            "$HOME/.local/bin/"
ln -sf "$DOT_FILE/dirwin_os/bin/binary/xxc-with-c"       "$HOME/.local/bin/xxd"
