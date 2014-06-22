#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

TERM="xterm-256color"
[ -n "$TMUX" ] && export TERM=screen-256color

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

[ -f ~/.systemd ] && source ~/.systemd

[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash

alias search="grep -R --include=\*.{cpp,c,h}"
# GEM
#[ -d $HOME/.gem/ruby/2.1.0/bin/ ] && PATH="$PATH:$HOME/.gem/ruby/2.1.0/bin/"
#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r /usr/local/rvm/scripts/completion ]] && . /usr/local/rvm/scripts/completion
