###############################################################################
#########################
# A bashrc for the ages #
#########################
###############################################################################


# {{{ env variables

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups
# Append to history file
shopt -s histappend

export HISTIGNORE="%*"

# what happens when you invoke an editor via bash (w/ C-x or C-e). The visual/editor
# distinction isn't really important anymore.
VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"
PSQL_EDITOR='vim -c"setf sql"'
# ls displays different colors depending on whether something is a file, folder,
# etc
CLICOLOR=1
LSCOLORS=gxgxcxdxbxegedabagacad

# makes all the variables available to subprocesses
export VISUAL EDITOR LESS RI PSQL_EDITOR CLICOLOR LSCOLORS

# not terrible man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# }}}

# {{{ Aliases

# Go into extdocs and activate venv
alias extdocs="cd ~/Documents/extdocs && source bin/activate"

# ls aliases
alias ll='ls -alh'    # hidden; verbose; human-readable
alias la='ls -A'      # hidden, but without implied '.' and '..'
alias l='ls -CFlh'
alias woo='fortune'
alias lsd="ls -alF | grep /$"

# purty colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# }}}

# {{{ Functions

# a generalized extraction function

# }}}

# {{{ Key bindings

# search history
if [ -t 1 ]; then
bind 'set bind-tty-special-chars off'
bind '"\ep": history-search-backward'
bind '"\en": history-search-forward'
bind '"\C-w": backward-kill-word'
bind '"\C-q": "%-\n"'
fi

# }}}

# {{{ Misc configs

# TODO wut
[ -z "$PS1" ] || stty -ixon

# git auto-completion
if [ -f '/usr/local/etc/bash_completion.d/git-completion.bash' ]; then
  source '/usr/local/etc/bash_completion.d/git-completion.bash'
fi

[ ! -f "$HOME/.bashrc.local" ] || . "$HOME/.bashrc.local"


# }}}
#eval "$(rbenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/max/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/max/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/max/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/max/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

