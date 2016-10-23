# Completion
autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
setopt autocd

# Disable terminal stop
stty -ixon

# History
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
export HISTFILE=~/.zhistory
export HISTSIZE=20000
export SAVEHIST=20000

# Help
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help 2> /dev/null
alias help=run-help

# Dirstack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
[ -e ${DIRSTACKFILE%/*} ] || mkdir -p ${DIRSTACKFILE%/*}
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
setopt pushdminus

# Prompt
autoload -U colors && colors
PROMPT="%{$fg_bold[red]%}%n%{$fg_bold[cyan]%}@%{$fg_bold[blue]%}%m %{$fg_bold[yellow]%}%~ %{$fg_bold[green]%}%# %{$reset_color%}"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls'

alias less='less -R'

alias ssudo='sudo -sE'

# Define editor but keep emacs bindings
export EDITOR='/usr/bin/vim'
export PAGER='/usr/bin/less'
bindkey -e

# Command not found
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Syntax highlight
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/site-contrib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/site-contrib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Key binding
autoload zkbd
[ -e ~/.zkbd/$TERM-:0.0 ] && source ~/.zkbd/$TERM-:0.0 # may be different - check where zkbd saved the configuration:

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]]  && bindkey "${key[PageUp]}"    history-beginning-search-backward
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" history-beginning-search-forward
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# Colored man
if [ "x${MANPAGER}" = "x" ]
then
  export GROFF_NO_SGR=1
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
fi

# gpg-agent
if pgrep -x gpg-agent > /dev/null; then
  export GPG_AGENT_INFO="/run/user/$UID/gnupg/S.gpg-agent"
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
else
  eval $(gpg-agent --daemon)
fi

# RVM
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#[[ -r /usr/local/rvm/scripts/completion ]] && . /usr/local/rvm/scripts/completion

# Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
virtualenvwrapper() {
  source /usr/bin/virtualenvwrapper.sh
}
