" Pathogen
execute pathogen#infect()

" Airline Line
let g:airline_left_sep = "\u2b80"
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
set laststatus=2   " always show the statusline
set encoding=utf-8 " necessary to show unicode glyphs
set noshowmode     " hide the default mode text

" Fugitive
nnoremap <C-g><C-b> :Gblame<CR>

" Godef
let g:godef_split=0

" Vim-Go
let g:go_template_autocreate=0
let g:go_gocode_unimported_packages = 1

" NerdTree
autocmd vimenter * NERDTree
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
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 softtabstop=0
setlocal omnifunc=syntaxcomplete#Complete

" File extension to syntax highlighting
autocmd BufNewFile,BufRead *.jsx set expandtab tabstop=4 shiftwidth=4 softtabstop=0
autocmd BufNewFile,BufRead *.js set expandtab tabstop=4 shiftwidth=4 softtabstop=0
autocmd BufNewFile,BufRead *.ctp set filetype=php " cakephp template
autocmd BufNewFile,BufRead *.template set filetype=json " cloudformation templates

" Syntastic
let g:syntastic_check_on_open = 1

"" Golang
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
"
"" Ruby
let g:syntastic_ruby_checkers = ['rubocop']

"" Javascript
let g:syntastic_javascript_checkers  = ['eslint']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'

" Auto Formatting
autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on write
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif " Jump to the last position when reopening a file

" Disable concealing
let g:vim_json_syntax_conceal = 0

" Templates
let g:templates_no_builtin_templates = 1
let g:templates_directory = ['$HOME/.vim/templates']

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
		:NERDTreeClose
		:TagbarClose
		:GitGutterDisable
		set mouse=
		set ttymouse=
		set nonu
		echo "Mouse usage disabled"
	else
		set mouse=a
		set ttymouse=xterm2
		set nu
		:GitGutterEnable
		:NERDTree
		echo "Mouse usage enabled"
	endif
endfunction

" Spellcheck
set spell
set spelllang=en_us
set spellfile=$HOME/.vim/spell/en.utf-8.add

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellRare
highlight clear SpellLocal
highlight SpellBad term=standout ctermfg=1 term=undercurl cterm=undercurl
highlight SpellCap term=undercurl cterm=undercurl
highlight SpellRare term=undercurl cterm=undercurl
highlight SpellLocal term=undercurl cterm=undercurl

"autocmd FileType gitcommit set spell " Enable for Git Commit Messages
"autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell " Enable for markdown files

" Working Directories
set backupdir=~/.vim/backup// " set a specific dir for backups to keep them out of the working dir
set directory=~/.vim/swap// " set a specific dir for swap files to keep them out of the working dir

" Shortcut keys
" Easier Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Show a marker for 80th column
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey guibg=#090909

" Conflicts with plugins, needs to be fixed
" inoremap <c-space> <c-n>
" nmap <silent> <C-n> :tabnext<CR>
" nmap <silent> <C-p> :tabprev<CR>
" imap <silent> <C-n> <esc><C-n>
" imap <silent> <C-p> <esc><C-p>
