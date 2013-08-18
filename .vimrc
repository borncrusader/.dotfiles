" get all the vim goodness
set nocp

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
