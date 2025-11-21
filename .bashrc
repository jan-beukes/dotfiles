#!/usr/bin/env bash

# Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi
# Interactive
iatest=$(expr index "$-" i)
if [[ $iatest -gt 0 ]]; then
    # Ignore case
    bind "set completion-ignore-case on"
    bind "set show-all-if-ambiguous On"
fi

# Disable slop like Ctrl-s
stty -ixon

# supress warnings
# export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
export WINEDEBUG=fixme-all,err-winediag,err-sync

export HISTFILESIZE=5000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T - "
export HISTCONTROL=erasedups:ignoredups:ignorespace
shopt -s histappend
PROMPT_COMMAND='history -a'

# Color man pages with less
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[m'
export LESS_TERMCAP_se=$'\e[m'
export LESS_TERMCAP_so=$'\e[1;47;34m'
export LESS_TERMCAP_ue=$'\e[m'
export LESS_TERMCAP_us=$'\e[1;36m'
export GROFF_NO_SGR=1

# programs that use LS_COLORS for colors
eval $(dircolors -b)

# set up XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export RLWRAP_HOME="$HOME/.local/share/rlwrap"

export SUDO_EDITOR="nvim"

#---ALIAS---
alias vim='nvim'
alias python='python3'
alias open='xdg-open'
alias neofetch='fastfetch -c neofetch'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias bat='bat --theme=ansi'
alias ls='ls --color=auto'
alias la='ls -ah'
alias lsl='ls -lah'
alias less='less -R'
alias grep='grep --color=auto'
alias du='du -h'

# tmux wrappers
tmn () {
    if [[ $# -eq 0 ]]; then 
        tmux
    else
        tmux new -s $@
    fi
}

tma() {
    if [[ $# -eq 0 ]]; then 
        tmux attach
    else
        tmux attach -t $@
    fi
}

# Automatically do an ls after each cd
cd() {
    builtin cd "$@" && ls
}

# Slop
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# PATH DUDES
appendpath () {
    # makes sure we don't have duplicates
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
        export PATH="$1:$PATH"
    esac
}
appendpath "$HOME/.local/bin"
appendpath "$HOME/Software/AppImages"
appendpath "$HOME/.cargo/bin"
