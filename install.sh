#!/bin/bash

install_prereqs() {
	local OS=$(uname -s | tr '[:upper:]' '[:lower:]')

	local install_cmd=""
	case $OS in
		"darwin")
			install_cmd="brew install -y"
			;;
		"")
			echo "OS Name came back blank, can't proceed"
			exit 1
			;;
		*)
			echo "${OS} is currently not supported by this install script"
			exit 1
			;;
	esac

	hash vim && hash mvim && hash cmake && hash ctags || ${install_cmd} vim macvim cmake ctags 2>/dev/null
}

check_git_deps() {
	DEPS=$(ls "$HOME/.vim/bundle" | head -n 1)
	if [[ ! -f "$HOME/.vim/bundle/$DEPS/.git" ]]; then
		echo "Dependencies don't exist; you probably forgot to run:"
		printf "\n\tgit submodule update --init --recursive\n\n"
		exit 1
	fi
}

configure() {
	install_prereqs
	check_git_deps
}

configure


$HOME/.vim/bundle/YouCompleteMe/install.py --gocode-completer

[ -e "$HOME/.vimrc" -a ! -h "$HOME/.vimrc" ] && mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"

if [ ! -e "$HOME/.vimrc" ] || [ "$(ls -l "$HOME/.vimrc" | awk -F"-> " '{print $2}')" != "$HOME/.vim/vimrc" ]; then
	ln -f -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
fi
