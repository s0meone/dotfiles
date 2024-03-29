# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="daniel"

SAVEHIST=1000
setopt   appendhistory
setopt   extendedhistory
setopt   histignoredups

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"

plugins=(git bundler npm sudo)

autoload -U zmv

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt correct

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

alias migrate='rake db:migrate'
alias ws='nocorrect ws'
alias prune_branches='git checkout main && git fetch && git remote prune origin && git branch --merged main | grep -v "main$" | xargs git branch -d'
alias prune_branches_remote="git branch -r --merged | grep -v main | sed 's/origin\///' | xargs -n 1 git push --delete origin"
alias gitx='echo "You are not using gitx for ages now, use gittower"'
alias uuid="uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo"
alias nrs='npm run --silent $*'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ip='echo $(curl -s https://api.ipify.org)'

export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

export LC_ALL=en_US.UTF-8
export WORKSPACE_PATH=/Users/daniel/Development/
export EDITOR='/usr/local/bin/vim'
export EVENT_NOKQUEUE=1
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export NVM_DIR="/Users/daniel/.nvm"
export KEYTIMEOUT=1
export GOPATH=$HOME/go
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history --extended"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export WORKON_HOME=~/.virtualenvs
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

function ws {
  cd "$WORKSPACE_PATH$1"
  export CURRENT_WORKSPACE=$WORKSPACE_PATH$1
}

_ws() {
  _files -W $WORKSPACE_PATH
}

compdef _ws ws
compdef dotfiles=git

_tmuxinator() {
  local commands projects
  commands=(${(f)"$(tmuxinator commands zsh)"})
  projects=(${(f)"$(tmuxinator completions start)"})

  if (( CURRENT == 2 )); then
    _alternative \
      'commands:: _describe -t commands "tmuxinator subcommands" commands' \
      'projects:: _describe -t projects "tmuxinator projects" projects'
  elif (( CURRENT == 3)); then
    case $words[2] in
      copy|debug|delete|open|start)
        _arguments '*:projects:($projects)'
      ;;
    esac
  fi

  return
}

compdef _tmuxinator tmuxinator t
alias t="tmuxinator"

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et
precmd () {
  print -Pn "\e]0;\a"
}
preexec () {
  print -Pn "\e]0;$1\a"
}

# Load rbenv
eval "$(rbenv init - zsh)";

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load avn
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# Load pyenv
eval "$(pyenv init --path)"

mkdir -p $WORKON_HOME
. "$(pyenv which virtualenvwrapper.sh)"

# Load zsh highlighter
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[function]='none'
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

stty sane
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
