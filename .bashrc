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

# Disable stuff like Ctrl-s
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

# XDG and stuff
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export RLWRAP_HOME="$HOME/.local/share/rlwrap"

export XCURSOR_THEME=breeze_cursors
export XCURSOR_SIZE=24
export SUDO_EDITOR="nvim"
export JAVAFX="$HOME/Projects/libs/javafx-sdk-25.0.2/lib"

# programs that use LS_COLORS for colors
eval $(dircolors -b ~/.dircolors)
eval "$(starship init bash)"
eval "$(zoxide init bash)"

#---ALIAS---
alias vim='nvim'
alias open='xdg-open'
alias neofetch='fastfetch -c neofetch'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ls='ls --color=auto'
alias la='ls -ah'
alias lsl='ls -lah'

alias less='less -R'
alias grep='grep --color=auto'
alias du='du -h'

# Automatically do an ls after each cd
cd() {
    builtin cd "$@" && ls
}

# To run non-steam games with proton
umu-run() {
    proton=$(echo ~/.steam/steam/compatibilitytools.d/GE-Proton* | head -1)
    PROTONPATH=$proton /bin/umu-run $@
}

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
