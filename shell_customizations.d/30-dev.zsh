# $ZDOTDIR/shell_customizations.d/30-dev.zsh - language & tooling helpers

# Yarn / Node paths
path:insert_before /opt/homebrew/bin $HOME/.yarn/bin
path:insert_before /opt/homebrew/bin $HOME/.config/yarn/global/node_modules/.bin

export MISE_NODE_COREPACK=true

# Ruby performance & aliases
export RUBY_YJIT_ENABLE=1 ENABLE_YJIT=1 DISABLE_SPRING=true
alias nxt=.bundle/gems/next_rails-1.1.0/exe/next.sh
# # make ruby quieter rn
# export RUBYOPT='-W0 -W:no-deprecated -W:no-experimental'
alias spacecop='rubocop -A --only Style/FrozenStringLiteralComment,Layout/EmptyLines,Style/StringLiterals,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLinesAroundClassBody,Layout/TrailingWhitespace,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLinesAroundModuleBody,Layout/EmptyLinesAroundMethodBody,Layout/SpaceAroundOperators,Layout/TrailingEmptyLines,Layout/SpaceInsideHashLiteralBraces,Layout/EmptyLineAfterGuardClause,Layout/FirstHashElementIndentation,Layout/EmptyLines,Layout/HashAlignment'

# Debug logging, fork-safety exceptions and Pry history overrides belong to
# explicit command/project configuration. Normal shells use application defaults.

# Java's executable and JAVA_HOME are owned by mise's configured Java version.
# Keep Rust's proxies so rust-toolchain overrides work; do not pin a sysroot.
[[ -d $HOME/.cargo/bin ]] && path:insert_before /opt/homebrew/bin "$HOME/.cargo/bin"

# rust: completions
# rustup completions zsh
# rustup completions zsh cargo

# acme.sh path if present
if [[ -d $HOME/.acme.sh ]]; then
  path:insert_before /opt/homebrew/bin "$HOME/.acme.sh"
fi

# Angular CLI completion (optional)
if (( $+commands[ng] )); then
  source <(ng completion script)
fi

# # elasticsearch stuff
# export ES_HEAP_SIZE=32m
# export ES_JAVA_OPTS=-server
# export ES_DIRECT_SIZE=32m
# export MAX_LOCKED_MEMORY=32m

# # go related
export GOPATH=~/src/go
path:insert_before /opt/homebrew/bin "$HOME/src/go/bin"

# export GOBIN=$GOPATH/bin
# export GO15VENDOREXPERIMENT=1
# export PATH=$GOPATH/bin:$PATH

# Activate once, after static PATH additions. The supported activation performs
# its own initial refresh and registers cd/prompt hooks. Its output includes the
# current session's PATH, so never save or source it from a persistent cache.
(( ${+commands[mise]} )) && () {
  local mise_command=${commands[mise]} activation
  activation=$("$mise_command" activate zsh) || return
  eval "$activation"

}

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
