################################################################################
# |
# | My zshrc config
# |
################################################################################

# function locations
fpath=(
  $fpath
  ~/.zsh/functions
  /usr/local/share/zsh/site-functions
)

# {{{ Exports

# color term
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# default apps
(( ${+PAGER}   )) || export PAGER='less'
(( ${+EDITOR}  )) || export EDITOR='vim'
export PSQL_EDITOR='vim -c"setf sql"'

# }}}

# {{{ Completions

# make with the nice completion
autoload -U compinit; compinit

# Completion for kill-like commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache

# }}}

# {{{ Bindings

# just say no to zle vim mode:
bindkey -e

# Bindings
# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Partial word history completion
bindkey '\ep' up-line-or-search
bindkey '\en' down-line-or-search
bindkey '\ew' kill-region

# }}}

# {{{ Prompt

# make with the pretty colors
autoload colors; colors
autoload -Uz vcs_info

# turn on command substitution in the prompt
setopt prompt_subst

# prompt
PROMPT='%{$fg_bold[green]%}%n@%m%f:%{$fg_bold[cyan]%}%~%{$reset_color%} '
# show non-success exit code in right prompt
RPROMPT="%(?..{%{$fg[red]%}%?%{$reset_color%}})"

# }}}

# {{{ History

# history file location
HISTFILE=~/.zsh_history

# Save a lot of history
HISTSIZE=10000
SAVEHIST=10000

# zsh sessions append history to the end of the history file, rather than rewrite.
setopt APPEND_HISTORY

# add new lines to the history incrementally, rather than waiting for a zsh session to
# end.
setopt INC_APPEND_HISTORY

# Remove unnecessary whitespace from commands before adding to history list
setopt HIST_REDUCE_BLANKS

# Add a command's beginning timestamp and the duration to the history file
setopt EXTENDED_HISTORY

# Ignore duplicated commands in history
setopt HIST_IGNORE_DUPS

# }}}

# {{{ Aliases

# Convenient ls shortcuts
alias ll='ls -l'
alias la='ls -a'
alias l.='ls -ld .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'

# Work-related shortcuts
alias site='cd ~/Projects/maxdelgiudice'
alias extdocs='cd ~/Documents/extdocs && source bin/activate'
alias engdocs='cd ~/Documents/docs && source bin/activate'
alias open-eng='open -a "Google Chrome" /Users/maxdelgiudice/Documents/docs/_build/html/index.html'
alias open-ext='open -a "Google Chrome" /Users/maxdelgiudice/Documents/extdocs/_build/html/index.html'

# }}}

# {{{ Misc options

# set cd autocompletion to commonly visited directories
cdpath=(~ ~/Projects ~/Programming)

# various misc options
setopt interactivecomments
setopt autocd
setopt nonomatch
setopt extendedglob

# import local zsh customizations, if present
zrcl="$HOME/.zshrc.local"
[[ ! -a $zrcl ]] || source $zrcl

# remove duplicates in $PATH
typeset -aU path

# }}}
