# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

#[ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

#PS1='[\u@\h \w]\$ '
PS1='\[\e[1;31m\][\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[31m\]] \$\[\e[m\] '

alias ls='ls --color=always'
alias dir='dir --color=always'
alias vdir='vdir --color=always'

alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias less='less -R'

alias ssudo='sudo -sE'

[ -d $HOME/bin ] && export PATH="$PATH:$HOME/bin"

export EDITOR='/usr/bin/vim'

# RVM
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#[[ -r /usr/local/rvm/scripts/completion ]] && . /usr/local/rvm/scripts/completion

# Bash-completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash

# Virtualenv wrapper
[ -f /usr/bin/virtualenvwrapper.sh ] && . /usr/bin/virtualenvwrapper.sh

# Colored man
man() {
 env \
  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
   man "$@"
}

# Local bashrc not tracked in git
[ -f ~/.bashrc_local ] && . ~/.bashrc_local
