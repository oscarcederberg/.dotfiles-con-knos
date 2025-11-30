set -a
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

LANG=en_US.utf8
LANGUAGE=en_US.utf8
LC_ALL=en_US.utf8

LESSHISTFILE="$XDG_STATE_HOME"/less/history
GOPATH=$XDG_DATA_HOME/go
GIT_CONFIG_GLOBAL=$XDG_CONFIG_HOME/git/config
CARGO_HOME=$XDG_DATA_HOME/cargo
RUSTUP_HOME=$XDG_DATA_HOME/rustup
MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

PATH=$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin

HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
SAVEHIST=9000
HISTSIZE=9999
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS

GPG_TTY=$(tty)

set +a

autoload -U compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
source $ZDOTDIR/shell-integration.zsh

PROMPT="%B%F{cyan}%n%f@%F{yellow}%m%f %F{green}%2~%f >%b "
RPROMPT="%B[%F{yellow}%T%f]%b"

if command -v fdfind &>/dev/null
then
  alias fd='fdfind'
fi
if command -v eza &>/dev/null
then
  alias ls='eza'
fi
if command -v nvim &>/dev/null
then
  alias vim="nvim"
fi
alias xcam-scan="xcam-scan -n"

if [ -f $ZDOTDIR/.zshrc_axis ]; then
  source $ZDOTDIR/.zshrc_axis
fi
