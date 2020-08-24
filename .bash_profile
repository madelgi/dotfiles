# Source your bashrc dog
. "$HOME/.bashrc"

# Virtual Env wrapper
source "/usr/local/bin/virtualenvwrapper.sh"
if [ -e /home/max/.nix-profile/etc/profile.d/nix.sh ]; then . /home/max/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
