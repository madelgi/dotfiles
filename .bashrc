###############################################################################
# A bashrc for the ages
#
###############################################################################

# vim:set ft=sh sw=2 sts=2:

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

# }}}

# {{{ Functions

# a generalized extraction function
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Takes a number of directies to go up, e.g. up 4 == cd ../../../..
up () {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

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
