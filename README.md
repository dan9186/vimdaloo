# Vimderp
Easy installation and configuration of Vim to act more like a full blown version of IDEs that everyone loves.

# Prerequisits

## System

### OS X
```bash
brew install vim macvim cmake ctags
```

### Linux
```bash
apt-get install vim cmake ctags
```

## Pathogen
This repo depends on the use of the [pathogen](https://github.com/tpope/vim-pathogen) plugin for vim to install all the plugins.  Follow it's installation instructions before proceeding.

# Installation
Git submodules are in use with this repo.  To avoid extra confusion, the recursive flag will download all the submodules when initially checking it out.

```
git clone --recursive https://github.com/dna9186/vimderp.git $HOME/.vim
$HOME/.vim/install.sh
```
