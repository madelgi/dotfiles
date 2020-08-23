####################################################################################################
# Ubuntu install script
####################################################################################################

# Zsh
sudo apt-get install zsh

# Python packages
# sudo apt-get install python-dev python-pip python3-dev python3-pip

# Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Oh My Zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Node
curl -sL install-node.now.sh/lts | sudo bash


# Install vim plugins
vim +PlugInstall +qall
