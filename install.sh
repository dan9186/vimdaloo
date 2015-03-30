#!/bin/bash

# Singular deps check, may want foreach later
DEPS=$(ls "$PWD/bundle" | head -n 1)
if [[ ! -f "$PWD/bundle/$DEPS/.git" ]]; then
	echo "Dependencies don't exist; you probably forgot to run:"
	printf "\n\tgit submodule update --init --recursive\n\n"
fi

# Check YouCompleteMe for running install.sh
#if [[ ! -f "$PWD/bundle/YouCompleteMe/third_party/ycmd/build.py" ]]; then
	#$HOME/.vim/bundle/YouCompleteMe/install.sh
#fi

if [ -e $HOME/.vimrc ]; then
	mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"
fi

cp vimrc $HOME/.vimrc && echo "New vimrc copied"
