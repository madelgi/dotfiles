. "$HOME/.bashrc"

source "/usr/local/bin/virtualenvwrapper.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda3 4.0.0 installer
export PATH="/Users/maxdelgiudice/anaconda/bin:$PATH"

# added by Miniconda3 4.1.11 installer
export PATH="/Users/maxdelgiudice/miniconda3/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/maxdelgiudice/.sdkman"
[[ -s "/Users/maxdelgiudice/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/maxdelgiudice/.sdkman/bin/sdkman-init.sh"
eval $(/usr/libexec/path_helper -s)
