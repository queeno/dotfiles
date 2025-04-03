### PLUGINS ###
export ZPLUG_HOME=~/.config/zplug
source $(brew --prefix zplug)/init.zsh

# Base16-shell
export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

zplug "djui/alias-tips"
zplug "docker/compose", as:command, use:"contrib/completion/zsh/_docker-compose"
zplug "docker/docker", as:command, use:"contrib/completion/zsh/_docker"
zplug "gulpjs/gulp", use:"completion/zsh"
zplug "modules/directory", from:prezto
zplug "modules/git", from:prezto
zplug "modules/homebrew", from:prezto
#zplug "modules/node", from:prezto
zplug "modules/osx", from:prezto
zplug "peterhurford/git-it-on.zsh"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
zplug "zsh-users/zsh-syntax-highlighting", defer:3 # Should be loaded 2nd last.
zplug "chriskempson/base16-shell", from:github

# Theme.
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:"github", as:"theme"
#zplug "sindresorhus/pure", use:pure.zsh
#zplug "mafredri/zsh-async", on:sindresorhus/pure

# Check for uninstalled plugins.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Source plugins.
zplug load

[ -f /opt/homebrew/share/google-cloud-sdk/bin/kubectl ] && export KUBE_PS1_BINARY="/opt/homebrew/share/google-cloud-sdk/bin/kubectl"

### COMPLETIONS ###
[ -f /usr/local/bin/aws_zsh_completer.sh ] && source /usr/local/bin/aws_zsh_completer.sh
type tmuxp &> /dev/null && eval "`_TMUXP_COMPLETE=source tmuxp`"


### CONFIG ###

# ZSH history
setopt append_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

export TERM=xterm-256color

export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

#unset COMPLETION_WAITING_DOTS # https://github.com/tarruda/zsh-autosuggestions#known-issues
export COMPLETION_WAITING_DOTS=true
export DEFAULT_USER="simonaquino"
export DISABLE_AUTO_TITLE=true
export DISABLE_CORRECTION=true
#export DISABLE_UNTRACKED_FILES_DIRTY=true # Improves repo status check time.
export DISABLE_UPDATE_PROMPT=true
export EDITOR='vim'
export VISUAL='vim'
export FZF_DEFAULT_COMMAND='ag -l -g ""' # Use ag as the default source for fzf
export FZF_DEFAULT_OPTS='--multi'
export NOTIFY_COMMAND_COMPLETE_TIMEOUT=300
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1 # https://github.com/neovim/neovim/pull/2007#issuecomment-74863439
export UPDATE_ZSH_DAYS=1
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='    '
export ZSH_CACHE_DIR=$ZSH/cache
export COMPOSE_HTTP_TIMEOUT=120


### AUTOSUGGESTIONS ###
if zplug check zsh-users/zsh-autosuggestions; then
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
fi

### AUTOCOMPLETION ###

zstyle ':completion:*' menu select
zmodload zsh/complist

### KEY BINDINGS ###
KEYTIMEOUT=1 # Prevents key timeout lag.
bindkey -e
bindkey -M viins ‘jj’ vi-cmd-mode
bindkey '^r' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward


# Bind UP and DOWN arrow keys for subsstring search.
if zplug check zsh-users/zsh-history-substring-search; then
  zmodload zsh/terminfo
  bindkey "$terminfo[cuu1]" history-substring-search-up
  bindkey "$terminfo[cud1]" history-substring-search-down
fi

### SPACESHIP ###
SPACESHIP_CHAR_SYMBOL='❯'
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_KUBECTL_CONTEXT_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_VI_MODE_SHOW=false

### PATHS ###

# Repos
export REPO_PATH=$HOME/hmrc

# Ruby
RUBYPATH=/usr/local/opt/ruby/bin
echo $PATH | grep -q $RUBYPATH || export PATH=$RUBYPATH:$PATH

# Python 3
PYTHON3PATH=/Users/simonaquino/Library/Python/3.6/bin
echo $PATH | grep -q $PYTHON3PATH || export PATH=$PYTHON3PATH:$PATH

# Krew
KREW_ROOT=$HOME/.krew/bin
echo $PATH | grep -q $KREW_ROOT || export PATH=$KREW_ROOT:$PATH

# Cargo
CARGO=$HOME/.cargo/env
echo $PATH | grep -q $CARGO || export PATH=$CARGO:$PATH

# GVM
[[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Java
#JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
#[ -f $JAVA_HOME/bin/java ] && export JAVA_HOME=$JAVA_HOME

# Homebrew
if command -v brew >/dev/null; then
  BREWSBIN=/usr/local/sbin
  BREWBIN=/usr/local/bin
  echo $PATH | grep -q $BREWSBIN || export PATH=$BREWSBIN:$PATH
  echo $PATH | grep -q $BREWBIN || export PATH=$BREWBIN:$PATH
fi

# TFSwitch
if command -v tfswitch >/dev/null; then
  HOMEBIN=/Users/simonaquino/bin
  echo $PATH | grep -q $HOMEBIN || export PATH=$HOMEBIN:$PATH
fi

# Go
if which go >/dev/null; then
  unset GOROOT
  unset GOPATH
  export GOPATH=$(go env GOPATH)
  export GOROOT=$(go env GOROOT)
  export GO111MODULE=on
  export GOBIN=$GOPATH/bin
  echo $PATH | grep -q $GOPATH/bin || export PATH=$GOPATH/bin:$PATH
  echo $PATH | grep -q $GOROOT/bin || export PATH=$GOROOT/bin:$PATH
fi

# Composer
#if command -v composer >/dev/null; then
#  COMPOSERBIN=$HOME/.composer/vendor/bin
#  echo $PATH | grep -q $COMPOSERBIN || export PATH=$PATH:$COMPOSERBIN
#fi

# Yarn
#if command -v yarn >/dev/null; then
#  YARNBIN=`yarn global bin`
#  echo $PATH | grep -q $YARNBIN || export PATH=$PATH:$YARNBIN
#fi

### ALIASES ###

# General shortcuts
alias sudo='sudo ' # @see http://askubuntu.com/a/22043
alias ..='cd ..'
alias l='ls -lAh'
alias echopath='echo $PATH | tr ":" "\012"'
alias kmux='tmux kill-server'
alias vimclean='rm -rf ~/.config/nvim/session/* ~/.config/nvim/swap/* ~/.config/nvim/undo/*  ~/.config/nvim/views/*'

# Git
alias gitgraph='git log --all --graph --decorate --oneline'
alias gpr='git pull-request'
# Unalias gt for graphite.dev
unalias gt

# NeoVim
alias nvim-debug='ulimit -c unlimited && nvim'
alias nvim-backtrace='gdb -q -n -ex bt -batch /usr/local/bin/nvim /cores/core.* > backtrace.txt && rm -f /cores/core.*'

# Scripts
#alias fr='$HOME/.dotfiles/scripts/find-and-replace.sh'
#alias stackshot='sudo $HOME/.dotfiles/scripts/stackshot/stackshot.sh'

# Docker
alias drun='docker run --rm -ti'
alias drc='docker rm $(docker ps -a -q) 2>/dev/null' # http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
alias dri='docker rmi $(docker images -q --filter "dangling=true") 2>/dev/null' # http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html#comment-1515979883

# Docker Compose
alias dc='docker-compose'
alias dcu='docker-compose up -d --remove-orphans'
alias dcl='docker-compose logs --tail 200 -f'
alias dcr='docker-compose run --rm'
docker_compose_rm() {
  docker-compose stop --timeout 1 $@
  docker-compose rm --force $@
}
alias dcrm=docker_compose_rm

# Docker Machine
alias dm='docker-machine'

# LMPM
alias lmpm="$REPO_PATH/lmpm/builder/use.sh"

# Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias ke='kubectl edit'
alias kd='kubectl describe'
alias kdd='kubectl delete'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kns='kubens'
alias kcx='kubectx'
alias wkgp='watch kubectl get pod'

# Mac
alias brewup='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias macup='softwareupdate --install -a'
alias gcloudup='gcloud components update'

# Python
#alias python=/opt/homebrew/bin/python3

### LIBRARY CONFIG ###

# NVM
[ -f ~/.dotfiles/libs/nvm/nvm.sh ] && source ~/.dotfiles/libs/nvm/nvm.sh

# iTerm cli integration.
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# CHRUBY
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# pgsql
[ -d /usr/local/opt/postgresql@9.6/bin ] && export PATH=/usr/local/opt/postgresql@9.6/bin:$PATH

# GNUBIN
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# SSH AGENT - add all known identities
ssh-add -A 2>/dev/null

# The next line enables direnv
eval "$(direnv hook zsh)"

# Expose you are in aws vault
function get_aws_vault_profile() {
  [ -z $AWS_VAULT ] && return
  echo -n "aws:$AWS_VAULT "
}

# Gcloud
export CLOUDSDK_PYTHON=/opt/homebrew/bin/python3

PROMPT="$(get_aws_vault_profile)$PROMPT"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/simonaquino/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/simonaquino/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/simonaquino/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/simonaquino/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# The next line adds playtube if it exists
if [ -f '/Users/simonaquino/.playtube.sh' ]; then alias playtube="/Users/simonaquino/.playtube.sh"; fi
