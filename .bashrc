#!/usr/bin/env bash
iatest=$(expr index "$-" i)

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

## EXPORTS
# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export XCURSOR_SIZE=24

# Ignore case on auto-completion
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi
# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ALIAS'S
alias vim='nvim'
alias python='python3'
alias venv='source .venv/bin/activate'
alias sbcl='rlwrap sbcl'
alias narga='ssh 28087887@open.rga.stb.sun.ac.za'
alias open='xdg-open'
alias http='python3 -m http.server'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias rmd='rm -rf'

alias ls='ls -Fh --color=always' # add colors and file type extensions
alias grep='grep --color=always'
alias la='ls -ah'
alias lsl='ls -lah'
alias du='du -h'

alias f="find . -name"
alias search="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"


## FUNCTIONS
function kys-now () {
	shutdown now
}

function kys () {
	pgrep $1 | xargs kill
}

# Automatically do an ls after each cd, z, or zoxide
function cd () {
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

alias whatismyip="whatsmyip"
function whatsmyip () {
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

# Bind Ctrl+f to insert 'zi'
if [[ $- == *i* ]]; then
    bind '"\C-f":"zi\n"'
fi

# PATH
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
