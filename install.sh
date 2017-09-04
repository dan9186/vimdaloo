#!/bin/bash

# Singular deps check, may want foreach later
DEPS=$(ls "$HOME/.vim/bundle" | head -n 1)
if [[ ! -f "$HOME/.vim/bundle/$DEPS/.git" ]]; then
	echo "Dependencies don't exist; you probably forgot to run:"
	printf "\n\tgit submodule update --init --recursive\n\n"
	exit 1
fi

# Check YouCompleteMe for running install.sh
$HOME/.vim/bundle/YouCompleteMe/install.py --gocode-completer

[ -e "$HOME/.vimrc" -a ! -h "$HOME/.vimrc" ] && mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"

if [ ! -e "$HOME/.vimrc" ] || [ "$(ls -l "$HOME/.vimrc" | awk -F"-> " '{print $2}')" != "$HOME/.vim/vimrc" ]; then
	ln -f -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
fi
