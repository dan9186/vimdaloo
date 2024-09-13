" Pathogen
execute pathogen#infect()

" Working Directories
set backupdir=~/.vim/backup// " set a specific dir for backups to keep them out of the working dir
set directory=~/.vim/swap// " set a specific dir for swap files to keep them out of the working dir

" Shortcut keys
" Easier Split Navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

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

" Wrapping
set nowrap

" Show a marker for 80th column
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey guibg=#090909

" Theming
set number       " turn on line numbers
set scrolloff=5  " always have some lines of text when scrolling
set showmatch	  " show matching braces and brackets
set hlsearch	  " highlight search results
set incsearch	  " show the first matching result while searching for results
set visualbell   " don't beep
set noerrorbells " don't beep
set background=dark

" Airline Line
set laststatus=2   " always show the statusline
set encoding=utf-8 " necessary to show unicode glyphs
let g:airline_powerline_fonts = 1
set noshowmode     " hide the default mode text

" Disable concealing
let g:vim_json_syntax_conceal = 0

" Auto Formatting
autocmd BufWritePre * :%s/\s\+$//e " Remove all trailing whitespace on write
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif " Jump to the last position when reopening a file
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.vue,*.html PrettierAsync

" Fugitive
nnoremap <C-g><C-b> :Gblame<CR>

" NerdTree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Copilot
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Folding
set foldmethod=indent
set foldlevel=99

augroup javascript_folding
	au!
	au FileType javascript setlocal foldmethod=syntax
augroup END

syntax on

" Filetypes
autocmd FileType * set autoindent copyindent smarttab noexpandtab tabstop=3 shiftwidth=3
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cucumber set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd FileType ruby set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 softtabstop=0
autocmd FileType sh set expandtab tabstop=2 shiftwidth=2 softtabstop=0
"setlocal omnifunc=syntaxcomplete#Complete

" File extension to syntax highlighting
autocmd BufNewFile,BufRead *.js,*.jsx set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd BufNewFile,BufRead *.ts,*.tsx set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd BufNewFile,BufRead *.json set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd BufNewFile,BufRead *.proto set expandtab tabstop=2 shiftwidth=2 softtabstop=0
autocmd BufNewFile,BufRead *.ctp set filetype=php " cakephp template
autocmd BufNewFile,BufRead *.template set filetype=json " cloudformation templates

" YouCompleteMe
set completeopt-=preview
let g:ycm_gopls_binary_path = 'gopls'

" Golang
let g:godef_split=0 "Do not create new split on jump to definition
let g:go_template_autocreate=0

" ALE
let g:ale_linters_explicit = 1
let g:ale_linters = {
\	'proto': ['buf-lint'],
\	'go': ['gopls', 'golangci-lint', 'govet', 'gosimple'],
\}
let g:ale_fixers = {
\	'proto': ['ale#fixers#protolint#Fix'],
\	'javascript': ['prettier', 'eslint'],
\}
let g:ale_virtualtext_cursor = 0
let g:ale_go_golangci_lint_package=1

" Markdown
let g:mkdp_refresh_slow = 1
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'light'
nmap <C-s> <Plug>MarkdownPreview
