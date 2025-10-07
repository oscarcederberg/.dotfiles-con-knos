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

if [ -f $ZDOTDIR/.zshrc_axis ]; then
  source $ZDOTDIR/.zshrc_axis
fi

set +a

autoload -U compinit; compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
source $ZDOTDIR/shell-integration.zsh

PROMPT="%B%F{cyan}%n%f@%F{yellow}axis%f %F{green}%2~%f >%b "
RPROMPT="%B[%F{yellow}%T%f]%b"

alias fd='fdfind'
alias ls='eza'
alias vim="nvim"
alias xcam-scan="xcam-scan -n"

