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

#---EXPORTS---

# Tell mesa to shut up about not being able to load nvidia driver
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
export NARGA="28087887@open.rga.stb.sun.ac.za"

export HISTFILESIZE=10000
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

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

#---ALIAS---
alias vim='nvim'
alias python='python3'
alias open='xdg-open'
alias fastfetch='fastfetch -c neofetch --logo gnu'
alias http='python3 -m http.server'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ls='eza'
alias la='eza -ah'
alias lsl='eza -lah'
alias less='less -R'
alias grep='grep --color=auto'
alias du='du -h'

# Automatically do an ls after each cd
cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ls
    else
        builtin cd ~ && ls
    fi
}

whatsmyip() {
    if command -v ip &> /dev/null; then
        echo -n "Internal IP: "
        ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig wlan0 | grep "inet " | awk '{print $2}'
    fi
    echo -n "External IP: "
    curl -s ifconfig.me
}

# Bind Ctrl+f to insert zoxide
if [[ $- == *i* ]]; then
    bind '"\C-f":"zi\n"'
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
