#!/bin/bash

if [ -e $HOME/.vimrc ]; then
	mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"
fi

cp vimrc $HOME/.vimrc && echo "New vimrc copied"
