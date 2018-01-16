# GIT SHORTCUTS

# required to get __git_complete
source /usr/share/bash-completion/completions/git

alias gst='git status'

alias gco='git checkout'
__git_complete gco _git_checkout

alias gsu='git submodule update --init'

alias gup='git pull ; gsu'

alias gpo='git push origin HEAD'

gswitch() {
  gco $1 ; gup
}
__git_complete gswitch _git_checkout

alias gclean='git prune remote origin ; git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

# GIT SHELL

PS1='\[\033[01;32m\]\u@\h\[\033[01;36m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;36m\] \n\$\[\033[00m\] '

export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUPSTREAM="auto"
