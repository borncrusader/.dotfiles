set nocp                " get all the vim goodness

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

" solarized stuff
let t_Co=16
let g:solarized_termcolors=16
set background=dark      " sets bg to a darker theme, making text more anti-aliased
colorscheme solarized

syntax on
syntax enable           " syntax coloring for files
filetype plugin indent on " detect, load plugin and indent the filetype

set keywordprg=:help    " use 'K' for vim-help
"set term=xterm-256color " for knowing the terminal control characters
set nowrap              " don't wrap lines

set tabstop=4           " a tab's worth
set softtabstop=4       " a tab's worth while editing with <TAB> or <BS>
set shiftwidth=4        " shifting with >> and <<
set expandtab           " expand tab to spaces
set autoindent          " autoindent the code
set smartindent         " smartindent for more c-style indents

set incsearch           " search incrementally as you key
set hlsearch            " highlight search words
set ignorecase          " ignore case for searches
set smartcase           " case-sensitive when uppercase chars given

set sidescroll=1        " sidescroll this much number of chars
set ruler               " show row,column in the bottom right corner
set laststatus=2        " show the status line always
set iskeyword+=_,$,@,%,#,' " for word boundaries

" autostart with NERDTree, but move to the other window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd w

" specific filetype vim settings
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 tabstop=4 textwidth=80 noexpandtab
autocmd FileType markdown setlocal textwidth=80 spell
autocmd FileType python setlocal textwidth=79
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79

" set ctags related variables for function display in status bar
if os =~ "Darwin"
	let g:ctags_path="/opt/local/bin/ctags"
endif
let g:ctags_statusline=1
let generate_tags=1

let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

set colorcolumn=80
