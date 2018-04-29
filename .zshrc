# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# {{{ Optional oh-my-zsh settings

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git)

# }}}

# {{{ Source content

source $ZSH/oh-my-zsh.sh

# Function locations
fpath=(
  $fpath
  ~/.zsh/functions
  /usr/local/share/zsh/site-functions
)

# tmuxinator stuff
# source ~/.bin/tmuxinator.zsh

# ros stuff
#source /opt/ros/kinetic/setup.zsh

# }}}

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

# }}}

# {{{ History (\)

# History file location
HISTFILE=~/.zsh_history

# Save a lot of history
HISTSIZE=10000
SAVEHIST=10000

# zsh sessions append history to the end of the history file, rather
# than rewrite.
setopt APPEND_HISTORY
# add new lines to the history incrementally, rather than waiting for a
# zsh session to end.
setopt INC_APPEND_HISTORY
# Remove unnecessary whitespace from commands before adding to history list
setopt HIST_REDUCE_BLANKS
# Add a command's beginning timestamp and the duration to the history file
setopt EXTENDED_HISTORY
# Ignore duplicated commands in history
setopt HIST_IGNORE_DUPS

# }}}

# {{{ Aliases (\)

# Convenient ls shortcuts
alias ll='ls -l'
alias la='ls -a'
alias l.='ls -ld .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'

# purty colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# projects
alias site='cd ~/Projects/maxdelgiudice'

# Cisco VPN
alias vpn='/opt/cisco/anyconnect/bin/vpn'
alias vpnui='/opt/cisco/anyconnect/bin/vpnui'

# }}}

# {{{ Misc options (\)

# various misc options
setopt interactivecomments # comments in the shell
setopt autocd              # type the name of a dir to change (no cd necessary)
setopt nonomatch           # try to avoid the 'zsh: no matches found...'
setopt extended_glob       # increase glob options

# import local zsh customizations, if present
zrcl="$HOME/.zshrc.local"
[[ ! -a $zrcl ]] || source $zrcl

# remove duplicates in $PATH
typeset -aU path

# pyenv settings
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# }}}

# {{{ Path options

export PATH="$HOME/.rvm/bin:$PATH"                                  # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/Cellar/maven30/3.0.5/libexec/bin"     # add mvn to path
export PATH="$PATH:/usr/local/share/python/"                        # powerline
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/bin"                                       # Local scripts
export PATH="$PATH:$HOME/.npm-packages/bin"                         # npm path
export PATH="$PATH:$HOME/Library/Haskell/bin"                       # add haskell shit to path
export PATH="$PATH:$HOME/anaconda/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"        # add adb to path
export PATH="/home/max/anaconda3/bin:$PATH"                         # Anaconda

# }}}

# Needs to be the last line
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/max/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/home/max/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/max/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/max/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
