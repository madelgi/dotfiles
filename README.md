# Dotfiles

This is a collection of dotfiles nd such. I modeled the install scripts off of
[this repo](https://github.com/hashrocket/dotmatrix). The actuall config files are
a combination of my stuff and the stuff from that repo.

To copy each of these files to your home directory, type `bin/install`.

## Vundle stuff

There are some lines in the vimrc that have to do w/ vundle. To get those working,
you have to do a few things

```
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim
# Execute :PluginInstall in vim
```
