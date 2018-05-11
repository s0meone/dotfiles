# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="daniel"

SAVEHIST=1000
setopt   appendhistory
setopt   extendedhistory
setopt   histignoredups

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"

plugins=(git bundler npm tmuxinator sudo)

autoload -U zmv

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

alias migrate='rake db:migrate'
alias ws='nocorrect ws'
alias prune_branches='git checkout master && git fetch && git remote prune origin && git branch --merged master | grep -v "master$" | xargs git branch -d'
alias prune_branches_remote="git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin"
alias gitx='echo "You are not using gitx for ages now, use gittower"'
alias uuid="uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo"
alias nrs='npm run --silent $*'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias t='tmuxinator'
alias ip='echo $(curl -s https://api.ipify.org)'
alias thinkas="sudo nmap -T5 -sS -oG - -p 51822 192.168.178.0/24 | grep 51822/open | cut -f1 -d$'\t'"

export WORKSPACE_PATH=/Users/daniel/Development/
export EDITOR='/usr/local/bin/vim'
export EVENT_NOKQUEUE=1
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export NVM_DIR="/Users/daniel/.nvm"
export KEYTIMEOUT=1

export PATH=/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init - zsh)";

function ws {
  cd "$WORKSPACE_PATH$1"
  export CURRENT_WORKSPACE=$WORKSPACE_PATH$1
}

_ws() {
  _files -W $WORKSPACE_PATH
}

compdef _ws ws
compdef dotfiles=git
compdef t=tmuxinator

precmd () {
  print -Pn "\e]0;\a"
}
preexec () {
  print -Pn "\e]0;$1\a"
}

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load avn
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh"

# Load zsh highlighter

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[function]='none'
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
