# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="daniel"

SAVEHIST=1000
setopt   appendhistory
setopt   extendedhistory
setopt   histignoredups

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"

# change keyboard delay
export KEYTIMEOUT=1

plugins=(git bundler zsh-syntax-highlighting)

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
alias uuid="/usr/local/bin/uuid | tr -d '\n' | pbcopy && pbpaste && echo"
alias nrs='npm run --silent $*'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export WORKSPACE_PATH=/Users/daniel/Development/
export TMUX_WORKSPACES_PATH=/Users/daniel/.tmux_workspaces/
export EDITOR='/usr/local/bin/vim'

export PATH=/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:~/Development/Tools/jakarta-jmeter-2.4/bin
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init - zsh)";

function ws {
  cd "$WORKSPACE_PATH$1"
  export CURRENT_WORKSPACE=$WORKSPACE_PATH$1
}

function tws {
  tmux source-file "$TMUX_WORKSPACES_PATH$1"
}

_tws() {
  _files -W $TMUX_WORKSPACES_PATH
}

_ws() {
  _files -W $WORKSPACE_PATH
}

compdef _tws tws
compdef _ws ws

precmd () {
  print -Pn "\e]0;\a"
}
preexec () {
  print -Pn "\e]0; $1\a"
}

if [[ ! -o interactive ]]; then
  return
fi

# compctl -K _tmuxinator tmuxinator mux

_tmuxinator() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(tmuxinator commands)"
  else
    completions="$(tmuxinator completions ${words[2,-2]})"
  fi

  reply=("${(ps:\n:)completions}")
}

# fix tmux something
export EVENT_NOKQUEUE=1

# Set Current Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

export NVM_DIR="/Users/daniel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
