" Pathogen
execute pathogen#infect()

" NerdTree
" autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Uncomment the following to have Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Airline Line
let g:airlne_powerline_fonts = 1
set laststatus=2 " always show the statusline
set encoding=utf-8 " necessary to show unicode glyphs
set noshowmode " hide the default mode text

"Theming
syntax enable
" set showmode " show what mode we're in
set number	" turn on line numbers
set scrolloff=5 " always have some lines of text when scrolling
set showmatch	" show matching braces and brackets
set hlsearch	" highlight search results
set incsearch	" show the first matching result while searching for results
set history=0	" disable our search history
set visualbell " don't beep
set noerrorbells " don't beep
set background=dark

" set cakephp's template extension
au BufNewFile,BufRead *.ctp set filetype=php

set foldmethod=indent "zo to open, zc to close
set foldlevel=99

" Intellisense!
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
setlocal omnifunc=syntaxcomplete#Complete

set mouse=a " enable mouse support
set ttymouse=xterm2 " for mouse support inside screen

set backupdir=~/.vim/backup// " set a specific dir for backups to keep them out of the working dir
set directory=~/.vim/swap// " set a specific dir for swap files to keep them out of the working dir

" use tabs but let them look like spaces
set autoindent
set noexpandtab
set tabstop=3
set shiftwidth=3
