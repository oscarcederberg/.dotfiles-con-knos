_ensure_dir "$_xdg_state/less"
_ensure_dir "$_xdg_config/wget"
_ensure_dir "$_xdg_state/wget"

export CARGO_HOME="$_xdg_data/cargo"
export DOTNET_CLI_HOME="$_xdg_data"
export GIT_CONFIG_GLOBAL="$_xdg_config/git/config"
export GOPATH="$_xdg_data/go"
export LESSHISTFILE="$_xdg_state/less/history"
export MPLAYER_HOME="$_xdg_config/mplayer"
export NPM_CONFIG_USERCONFIG="$_xdg_config/npm/npmrc"
export PASSWORD_STORE_DIR="$_xdg_data/pass"
export RUSTUP_HOME="$_xdg_data/rustup"
export WGETRC="$_xdg_config/wget/wgetrc"

typeset -U path
path+=(
  "$CARGO_HOME/bin"
  "$GOPATH/bin"
)

_alias_if_exists fd fdfind
_alias_if_exists ls eza
_alias_if_exists vim nvim
