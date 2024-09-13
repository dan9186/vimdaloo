#!/bin/bash

python_cmd="python"

install_prereqs() {
	local OS=$(uname -s | tr '[:upper:]' '[:lower:]')

	local install_cmd=""
	case $OS in
		"darwin")
      local ARCH=$(uname -m | tr '[:upper:]' '[:lower:]')
      case $ARCH in
        "arm64")
          brew install vim cmake ctags python3 java 2>/dev/null
        ;;
        *)
          brew install vim macvim cmake ctags python3 java 2>/dev/null
        ;;
      esac

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

install_ycm() {
  CWD=$PWD
  $python_cmd $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --cs-completer --go-completer --rust-completer --ts-completer
  cd $CWD
}

install_md_preview() {
  CWD=$PWD
  cd $HOME/.vim/bundle/markdown-preview
  yarn install
  cd $CWD
}

archive_old() {
  [ -e "$HOME/.vimrc" -a ! -h "$HOME/.vimrc" ] && mv $HOME/.vimrc $HOME/.vimrc.old && echo "Archiving old vimrc"
}

symlink() {
  if [ ! -e "$HOME/.vimrc" ] || [ "$(ls -l "$HOME/.vimrc" | awk -F"-> " '{print $2}')" != "$HOME/.vim/vimrc" ]; then
    ln -f -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
  fi
}

update() {
  git submodule foreach git checkout $(git symbolic-ref refes/remotes/origin/HEAD | cut -d '/' -f4) && git submodule foreach git pull
  CWD=$PWD
  cd bundle/YouCompleteMe
  git submodule update --init --recursive
  cd $PWD
  git submodule update --init --recursive
}

install() {
  configure
  install_ycm
  #install_md_preview
  archive_old
  symlink
}

if [ $# -eq 0 ]; then
  install
else
  "$@"
fi
