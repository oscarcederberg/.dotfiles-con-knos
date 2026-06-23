if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# Definitions

_xdg_cache="${XDG_CACHE_HOME:-$HOME/.cache}"
_xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}"
_xdg_data="${XDG_DATA_HOME:-$HOME/.local/share}"
_xdg_state="${XDG_STATE_HOME:-$HOME/.local/state}"
_xdg_bin="${XDG_BIN_HOME:-$HOME/.local/bin}"

_alias_if_exists() {
  [[ $# -eq 2 ]] || return 1
  local alias_name="$1"
  local target="$2"

  if command -v "$target" >/dev/null; then
    alias "$alias_name=$target"
  fi
}

_ensure_dir() {
  [[ $# -eq 1 ]] || return 1
  local directory="$1"
  [[ -d "$directory" ]] || mkdir -p "$directory"
}

_export_path() {
  [[ $# -eq 2 ]] || return 1
  local var_name="$1"
  local file_path="$2"

  local dir="${file_path:h}"
  _ensure_dir "$dir"

  export "$var_name=$file_path"
}

# Configuration

export LANG=en_US.UTF-8

typeset -U path
path+=(
  $_xdg_bin
)

_export_path HISTFILE "$_xdg_state/zsh/zhistory"
SAVEHIST=100000
HISTSIZE=100000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_FCNTL_LOCK
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

_export_path ZSH_COMPDUMP "$_xdg_cache/zsh/zcompdump"
autoload -U compinit
compinit -d "$ZSH_COMPDUMP"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

PROMPT="%B%F{cyan}%n%f@%F{yellow}%m%f %F{green}%2~%f $%b "
RPROMPT="%B[%F{yellow}%T%f]%b"

alias zsh_zprof="time env -u ZDOTDIR -i ZSH_DEBUGRC=1 zsh -i -c exit"
alias zsh_trace='env -u ZDOTDIR zsh -xlic exit 2>&1'

# Source

for file in "$ZDOTDIR"/sources/**/*.zsh(.N); do
  source "$file" || echo "Failed to source $file"
done

# Cleanup

unfunction _alias_if_exists _ensure_dir _export_path
unset _xdg_cache _xdg_config _xdg_data _xdg_state

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
