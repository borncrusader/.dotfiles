" get all the vim goodness
set nocp

" get os
if has("win32")
	let os = "win"
elseif has("unix")
	let os = system("uname")
endif

" load pathogen and let it load the other plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" sets the background to a more darker theme, thus making the text more anti-aliased
set bg=dark

" a tab is worth 8 columns
set tabstop=8

" a tab is worth 8 columns (while editing with <TAB> or <BS>)
set softtabstop=8

" shifting with >> and << is also 8 columns
set shiftwidth=8

" a tab is always a tab! don't expand it to spaces
set noexpandtab

" autoindent the code
set autoindent

" smartindent for more c-style indents
set smartindent

" use 'K' for vim-help
set keywordprg=:help

" don't wrap lines
set nowrap

" for knowing the terminal control characters
set term=builtin_xterm

" enable syntax coloring for files
syntax enable

" search incrementally as you key characters
set incsearch

" highlight search words
set hlsearch

" show the status line always
set laststatus=2

" sidescroll this much number of characters
set sidescroll=1

" show row,column in the bottom right corner
set ruler

" for word boundaries
set iskeyword+=_,$,@,%,#,'

" detect, load plugin and indent the filetype
filetype plugin indent on

" autostart with NERDTree, but move to the other window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd w

" specific filetype vim settings
autocmd FileType markdown setlocal shiftwidth=4 softtabstop=4 tabstop=4 textwidth=80 spell
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" set ctags related variables for function display in status bar
if os =~ "Darwin"
	let g:ctags_path="/opt/local/bin/ctags"
endif
let g:ctags_statusline=1
let generate_tags=1

" other stuff to do
" setup functions for automatic filling of markdown headers
