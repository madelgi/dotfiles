# Dotfiles

Copy/link (dot)files to home directory:

```bash
$ bin/install
```


## Usage notes

* The `FILES` file controls which of the dotfiles in this root directory will be copied to the user's
home directory.
* The `custom` directory contains files/folders that will be symlinked into the user's home directory,
respecting directory structure. E.g, `custom/bin/up` is symlinked to `~/bin/up`
* **WIP**: `bin/install_packages` is a hacky helper script for provisioning ubuntu-based machines. You will still
have to do some manual work to get everything to play nice, but it will install some relevant dependencies
(e.g., zsh, node, miniconda, etc).
