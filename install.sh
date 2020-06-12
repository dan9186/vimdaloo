#!/bin/bash

python_cmd="python"

install_prereqs() {
	local OS=$(uname -s | tr '[:upper:]' '[:lower:]')

	local install_cmd=""
	case $OS in
		"darwin")
			hash vim && hash mvim && hash cmake && hash ctags && hash python3 || ( echo "Dependency for ${OS} is missing" && exit 1 )
			brew install vim macvim cmake ctags python3 2>/dev/null
			python_cmd="python3"
			;;
		"linux")
			hash vim && hash cmake && hash ctags || ( echo "Dependency for ${OS} is missing" && exit 1 )
			hash yum && yum install -y vim cmake ctags 2>/dev/null
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


$python_cmd $HOME/.vim/bundle/YouCompleteMe/install.py --all

[ -e "$HOME/.vimrc" -a ! -h "$HOME/.vimrc" ] && mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"

if [ ! -e "$HOME/.vimrc" ] || [ "$(ls -l "$HOME/.vimrc" | awk -F"-> " '{print $2}')" != "$HOME/.vim/vimrc" ]; then
	ln -f -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
fi
