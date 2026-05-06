_export_path LESSHISTFILE "$_xdg_state/less/history"
_export_path GIT_CONFIG_GLOBAL "$_xdg_config/git/config"
_export_path WGETRC "$_xdg_config/wget/wgetrc"
_export_path WGET_HSTS "$_xdg_state/wget/hsts-file"

export GOPATH="$_xdg_data/go"
export CARGO_HOME="$_xdg_data/cargo"
export RUSTUP_HOME="$_xdg_data/rustup"
export MPLAYER_HOME="$_xdg_config/mplayer"
export NPM_CONFIG_USERCONFIG="$_xdg_config/npm/npmrc"

if [[ -o interactive ]]; then
  export GPG_TTY=$(tty)
fi

path+=(
  "$CARGO_HOME/bin"
  "$GOPATH/bin"
)

_alias_if_exists fd fdfind
_alias_if_exists ls eza
_alias_if_exists vim nvim
