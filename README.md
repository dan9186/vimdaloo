# Vimdaloo
Easy installation and configuration of Vim to act more like a full blown version of IDEs that everyone loves.

# Installation
Git submodules are in use with this repo.  To avoid extra confusion, the recursive flag will download all the submodules when initially checking it out.

```
git clone --recursive https://github.com/dan9186/vimderp.git $HOME/.vim
$HOME/.vim/run.sh
```

## Updating
Updating the submodules can be tedious, so a script has been provided.

```
$HOME/.vim/run.sh update
```

After the update script has run, the changes have not been checked in. If you want to preserve those updates, they must be committed.
