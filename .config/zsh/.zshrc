_xdg_cache="${XDG_CACHE_HOME:-$HOME/.cache}"
_xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}"
_xdg_data="${XDG_DATA_HOME:-$HOME/.local/share}"
_xdg_state="${XDG_STATE_HOME:-$HOME/.local/state}"

_alias_if_exists() {
  [[ $# -eq 2 ]] || return 1
  local alias_name="$1"
  local target="$2"

  if command -v "$target" >/dev/null; then
    alias "$alias_name=$target"
  fi
}

_create_dir_if_not_exists() {
  [[ $# -eq 1 ]] || return 1
  local directory="$1"
  [[ -d "$directory" ]] || mkdir -p "$directory"
}

_create_dir_if_not_exists "$_xdg_state/less"
_create_dir_if_not_exists "$_xdg_cache/zsh"
_create_dir_if_not_exists "$_xdg_state/zsh"

export LANG=en_US.UTF-8

export LESSHISTFILE="$_xdg_state/less/history"
export GOPATH="$_xdg_data/go"
export GIT_CONFIG_GLOBAL="$_xdg_config/git/config"
export CARGO_HOME="$_xdg_data/cargo"
export RUSTUP_HOME="$_xdg_data/rustup"
export MPLAYER_HOME="$_xdg_config/mplayer"
export NPM_CONFIG_USERCONFIG="$_xdg_config/npm/npmrc"

if [[ -o interactive ]]; then
  export GPG_TTY=$(tty)
fi

typeset -U path
path+=(
  "$HOME/.local/bin"
  "$CARGO_HOME/bin"
  "$GOPATH/bin"
)

HISTFILE="$_xdg_state/zsh/zhistory"
SAVEHIST=100000
HISTSIZE=100000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_FCNTL_LOCK
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

autoload -U compinit
compinit -d "$_xdg_cache/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
source "$ZDOTDIR/shell-integration.zsh"

PROMPT="%B%F{cyan}%n%f@%F{yellow}%m%f %F{green}%2~%f $%b "
RPROMPT="%B[%F{yellow}%T%f]%b"

_alias_if_exists fd fdfind
_alias_if_exists ls eza
_alias_if_exists vim nvim

for file in "$ZDOTDIR"/.zshrc.d/*.zsh(.N); do
  source "$file" || echo "Failed to source $file"
done

unfunction _alias_if_exists _create_dir_if_not_exists
unset _xdg_cache _xdg_config _xdg_data _xdg_state
