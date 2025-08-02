# $ZDOTDIR/shell_customizations.d/30-dev.zsh - language & tooling helpers

# Yarn / Node paths
path=(
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  $path
)
export MISE_NODE_COREPACK=true

# Ruby performance & aliases
export RUBY_YJIT_ENABLE=1 ENABLE_YJIT=1 DISABLE_SPRING=true
alias nxt=.bundle/gems/next_rails-1.1.0/exe/next.sh
# # make ruby quieter rn
# export RUBYOPT='-W0 -W:no-deprecated -W:no-experimental'
alias spacecop='rubocop -A --only Style/FrozenStringLiteralComment,Layout/EmptyLines,Style/StringLiterals,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLinesAroundClassBody,Layout/TrailingWhitespace,Layout/EmptyLinesAroundBlockBody,Layout/EmptyLinesAroundModuleBody,Layout/EmptyLinesAroundMethodBody,Layout/SpaceAroundOperators,Layout/TrailingEmptyLines,Layout/SpaceInsideHashLiteralBraces,Layout/EmptyLineAfterGuardClause,Layout/FirstHashElementIndentation,Layout/EmptyLines,Layout/HashAlignment'

# Neovim Ruby + Pry history logs
export NVIM_RUBY_LOG_FILE=$HOME/.local/state/nvim/nvim_ruby.log
export NVIM_RUBY_LOG_LEVEL=debug
export PRY_HISTFILE=.pry_history

# macOS-only fork-safety
if [[ $(uname) == Darwin ]]; then
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi


# macOS-only Java helpers
if [[ $(uname) == Darwin ]] && [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  path=( /opt/homebrew/opt/openjdk/bin $path )
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
fi

# acme.sh path if present
if [[ -d $HOME/.acme.sh ]]; then
  path=( $HOME/.acme.sh $path )
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
# export GOPATH=~/src/go
# export GOBIN=$GOPATH/bin
# export GO15VENDOREXPERIMENT=1
# export PATH=$GOPATH/bin:$PATH

#  vim: set ft=zsh ts=2 sw=2 tw=0 et :
