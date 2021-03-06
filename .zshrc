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

plugins=(aws docker docker-compose git python tmuxinator)

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
source ~/.tmuxinator.zsh

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


# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

# Scala and spark
export SCALA_HOME="/usr/share/scala"
export SPARK_HOME="$HOME/spark-2.3.2-bin-hadoop2.7"
export SPARK_LOCAL_IP="127.0.0.1"

# OPAM
export OPAMROOT="$HOME/opam-coq.8.9.0"

# Pip embeddings library
export EMBEDDINGS_ROOT="/data/biowordvec"

# Private tokens, etc
if [ -f "$HOME/.env.local" ]; then source "$HOME/.env.local"; fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"

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

# Pasting
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# }}}

# {{{ Bindings

# no zle vim mode:
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

# {{{ History

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
alias lup='netstat -tulpn | grep LISTEN'        # List in-use ports
alias vim=nvim                                  # Always use neovim

# Grep colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# Cisco VPN
alias vpn='/opt/cisco/anyconnect/bin/vpn'
alias vpnui='/opt/cisco/anyconnect/bin/vpnui'

# }}}

# {{{ Misc options

# various misc options
setopt interactivecomments # comments in the shell
setopt autocd              # type the name of a dir to change (no cd necessary)
setopt nonomatch           # try to avoid the 'zsh: no matches found...'
setopt extended_glob       # increase glob options

# import local zsh customizations, if present
zrcl="$HOME/.zshrc.local"
[[ ! -a $zrcl ]] || source $zrcl


# }}}

# {{{ Path options

export PATH="$PATH:/usr/local/Cellar/maven30/3.0.5/libexec/bin"     # add mvn to path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/bin"                                       # Local scripts
export PATH="$PATH:$HOME/.npm-packages/bin"                         # npm path
export PATH="$PATH:$HOME/Library/Haskell/bin"                       # add haskell shit to path
#export PATH="$PATH:$HOME/anaconda/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"        # add adb to path
export PATH="$PATH:$SPARK_HOME/bin"
export PATH="$PATH:$SCALA_HOME/bin"
export PATH="$PATH:/opt/public_mm/bin"                              # MetaMap
export PATH="$PATH:/usr/local/Jena/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/ghc/8.6.5/bin/"
export PATH="$PYENV_ROOT/bin:$PATH"

# remove duplicates in $PATH
typeset -aU path

# }}}

# {{{ Optional commands, depending on install

### Coq
if which opam > /dev/null 2>&1; then
    eval `opam config env`
    # opam configuration
    test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
fi

### Ruby
if which rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# pyenv settings
if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"
fi

# Conda initialization
conda_dir=""
if [ -d "$HOME/anaconda3" ]; then
    conda_dir="anaconda3"
elif [ -d "$HOME/miniconda3" ]; then
    conda_dir="miniconda3"
fi

if [ ! -z "$conda_dir" ]; then
    __conda_setup="$("$HOME/$conda_dir/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/$conda_dir/etc/profile.d/conda.sh" ]; then
            . "$HOME/$conda_dir/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/$conda_dir/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# If fzf is installed, enable
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

#}}}

