# printf "Importing \t %s \n" "$HOME.config/zsh/zshenv-footer.zsh"
# echo "[ -f "$ZDOTDIT/zshenv-private.zsh" ] && source "$ZDOTDIT/zshenv-private.zsh"" >> ~/.zshenv


# SUPPORTING SOME PRIVATE VARIABLES INSIDE .zshenv =============================
# export ARIA2C_SESSION_TOKEN="go to .zshenv"
# export GITHUB_AUTH_TOKEN="go to    .zshenv"     # this pritam_lpu_12416
# ==============================================================================


# sudo curl -L https://curl.se/ca/cacert.pem -o /usr/local/etc/ca-certificates/cert.pem
export SSL_CERT_FILE="/usr/local/etc/ca-certificates/cert.pem"

# FOR THE DEVELOPER===========================================================================================
export CXX="/usr/bin/clang++"
export CC="/usr/bin/clang"
export PREFIX="$HOME/.local"

# FOR PYTHON ======
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export MANPATH="$MANPATH:$HOME/Library/Python/3.9/share/man"
fpath=($fpath "$HOME/Library/Python/3.9/share/zsh/site-functions")

# FOR DEVELOPMENT LIBRARIES ==========
export PATH="/usr/local/big_library-bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/lib:$DYLD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export CMAKE_PREFIX_PATH="/usr/local/lib/cmake:$CMAKE_PREFIX_PATH"
export CPP_LIB_DIR="/usr/local/big_library"


# FOR DEVELOPMENT LIBRARIES ==========
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/github-releases-bin"
fpath=($fpath "$HOME/.local/share/zsh/site-functions")

export EDITOR="nvim"
# export EDITOR="hx"
export DOT_FILE="$HOME/Developer/git_repository/my_dotfile/dirwin_os/"
# ============================================================================================================


# Linux LS color theme =======================================================================================
# Allow Zed editor to run as root
export ZED_ALLOW_ROOT=true

# Set CMake generator to Ninja
export CMAKE_GENERATOR=Ninja

# Enable colored diagnostics in CMake
export CMAKE_COLOR_DIAGNOSTICS=true

# Enable colored output for ls
export CLICOLOR=true

# Set default pager to less
export PAGER="less"

# Configure less for raw control characters and case-insensitive search
export LESS="-Rir"

# Define ls color scheme
export LSCOLORS="ExFxBxDxCxegedabagacad"
# ============================================================================================================


# FZF Configuration ==========================================================================================
# Set up FZF default options for appearance and layout
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Configure FZF previews for file selection
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"

# Uncomment the following line to enable directory previews with eza
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# Uncomment to enable FZF preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "
# ============================================================================================================


# Red & Green Man Page Theme (2025 edition) ==================================================================
# Bold text & headings → Bright green (function names, section titles)
export LESS_TERMCAP_md=$'\e[01;38;5;82m'   # vivid neon green

# Start blinking (rarely used) → Bright red (makes it actually noticeable)
export LESS_TERMCAP_mb=$'\e[05;38;5;196m'  # blinking bright red

# Search highlight bar / standout → White text on red background (super visible)
export LESS_TERMCAP_so=$'\e[01;97;41m'     # bright white on red

# End standout
export LESS_TERMCAP_se=$'\e[0m'

# Underlined text (options, arguments, --flags) → Bright red underline
export LESS_TERMCAP_us=$'\e[04;38;5;196m'  # bright red underline

# End underline
export LESS_TERMCAP_ue=$'\e[0m'

# End all bold/attributes
export LESS_TERMCAP_me=$'\e[0m'
# ============================================================================================================


# GPG CONFIGURATION ==========================================================================================
# Set GPG_TTY for signing commits with GPG
export GPG_TTY=$(tty)
# ============================================================================================================


source ~/.config/broot/launcher/bash/br
