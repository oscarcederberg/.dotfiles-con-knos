xdg_cache="${XDG_CACHE_HOME:-$HOME/.cache}"
xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}"
xdg_data="${XDG_DATA_HOME:-$HOME/.local/share}"
xdg_state="${XDG_STATE_HOME:-$HOME/.local/state}"

zsh_alias_if_exists() {
  [[ $# -eq 2 ]] || return 1
  local alias_name="$1"
  local target="$2"

  if command -v "$target" >/dev/null; then
    alias "$alias_name=$target"
  fi
}

[[ -d "$xdg_state/less" ]] || mkdir -p "$xdg_state/less"
[[ -d "$xdg_cache/zsh" ]] || mkdir -p "$xdg_cache/zsh"

export LANG=en_US.UTF-8

export LESSHISTFILE="$xdg_state/less/history"
export GOPATH="$xdg_data/go"
export GIT_CONFIG_GLOBAL="$xdg_config/git/config"
export CARGO_HOME="$xdg_data/cargo"
export RUSTUP_HOME="$xdg_data/rustup"
export MPLAYER_HOME="$xdg_config/mplayer"
export NPM_CONFIG_USERCONFIG="$xdg_config/npm/npmrc"

if [[ -o interactive ]]; then
  export GPG_TTY=$(tty)
fi

typeset -U path
path+=(
  $HOME/.local/bin
  $CARGO_HOME/bin
  $GOPATH/bin
)

HISTFILE="$xdg_cache/zsh/zhistory"
SAVEHIST=100000
HISTSIZE=100000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_FCNTL_LOCK
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

autoload -U compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
source "$ZDOTDIR/shell-integration.zsh"

PROMPT="%B%F{cyan}%n%f@%F{yellow}%m%f %F{green}%2~%f $%b "
RPROMPT="%B[%F{yellow}%T%f]%b"

zsh_alias_if_exists fd fdfind
zsh_alias_if_exists ls eza
zsh_alias_if_exists vim nvim

for file in "$ZDOTDIR"/.zshrc.d/*.zsh(.N); do
  source "$file" || echo "Failed to source $file"
done
