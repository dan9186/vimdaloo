" Pathogen
execute pathogen#infect()

" Airline Line
let g:airline_powerline_fonts = 1
set laststatus=2   " always show the statusline
set encoding=utf-8 " necessary to show unicode glyphs
set noshowmode     " hide the default mode text

" Fugitive
nnoremap <C-g><C-b> :Gblame<CR>

" Godef
let g:godef_split=0

" NerdTree
autocmd StdinReadPre * let s:std_in=1 " Open NERDTree if no file was specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Theming
syntax enable
"set showmode     " show what mode we're in
set number       " turn on line numbers
set scrolloff=5  " always have some lines of text when scrolling
set showmatch	  " show matching braces and brackets
set hlsearch	  " highlight search results
set incsearch	  " show the first matching result while searching for results
set history=0	  " disable our search history
set visualbell   " don't beep
set noerrorbells " don't beep
set background=dark

" Folding
set foldmethod=indent " fold based on indents
set foldlevel=99

" Intellisense!
autocmd FileType * set autoindent copyindent smarttab noexpandtab tabstop=3 shiftwidth=3
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cucumber set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd FileType ruby set expandtab tabstop=2 shiftwidth=2 softtabstop=0
setlocal omnifunc=syntaxcomplete#Complete

autocmd BufNewFile,BufRead *.ctp set filetype=php " set cakephp's template extension

" Syntastic
"" Golang
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_check_on_open = 1

" Auto Formatting
autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on write
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif " Jump to the last position when reopening a file

" Disable concealing
let g:vim_json_syntax_conceal = 0

" Mouse
set mouse=a " Set mouse enabled as default
if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
end

nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
	if &mouse == 'a'
		set mouse=
		set ttymouse=
		echo "Mouse usage disabled"
	else
		set mouse=a
		set ttymouse=xterm2
		echo "Mouse usage enabled"
	endif
endfunction

" Working Directories
set backupdir=~/.vim/backup// " set a specific dir for backups to keep them out of the working dir
set directory=~/.vim/swap// " set a specific dir for swap files to keep them out of the working dir

" Shortcut keys
" Easier Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Conflicts with plugins, needs to be fixed
" inoremap <c-space> <c-n>
" nmap <silent> <C-n> :tabnext<CR>
" nmap <silent> <C-p> :tabprev<CR>
" imap <silent> <C-n> <esc><C-n>
" imap <silent> <C-p> <esc><C-p>
