set nocp                " get all the vim goodness

" get os
if has("win32")
    let os = "win"
elseif has("unix")
    let os = system("uname")
endif

" load pathogen and let it load the other plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" solarized stuff
let t_Co=16
let g:solarized_termcolors=16
if os =~ "Darwin"
    colorscheme solarized
endif

syntax on
syntax enable           " syntax coloring for files
filetype plugin indent on " detect, load plugin and indent the filetype

set bg=dark             " sets bg to a darker theme, making text more anti-aliased
set keywordprg=:help    " use 'K' for vim-help
set term=builtin_xterm  " for knowing the terminal control characters
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
set textwidth=79        " limit maximum length of line to 79
set colorcolumn=80      " show a line at 80 char limit
set cscopetag           " use cstag for <Ctrl-]> and vim -t, and default is to first search cscope db
set backspace=2         " allow backspace deleting of characters

" autostart with NERDTree, but move to the other window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd w

" specific filetype vim settings
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 tabstop=4 textwidth=80 noexpandtab
autocmd FileType markdown setlocal textwidth=80 spell
autocmd FileType python setlocal textwidth=79
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79

" set ctags related variables for function display in status bar
let g:ctags_statusline=1
let generate_tags=1

" Ultisnips directory for extra snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

" show extra whitespaces as red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=1
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
