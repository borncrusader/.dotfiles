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

if os =~ "Darwin"
    set modelines=5     " modelines are not honoured by default in os x
endif

syntax on
syntax enable           " syntax coloring for files
filetype plugin indent on " detect, load plugin and indent the filetype

set keywordprg=:help    " use 'K' for vim-help
set term=xterm-256color " for knowing the terminal control characters
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
set mouse=i             " get all that nice mouse scrolling support in insert mode

" autostart with NERDTree, but move to the other window
command Nerd NERDTree | wincmd w
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd w

" specific filetype vim settings
autocmd FileType c setlocal shiftwidth=8 softtabstop=8 tabstop=8 textwidth=80 noexpandtab
autocmd BufNewFile,BufRead *.h setlocal filetype=c
autocmd FileType markdown setlocal spell noautoindent nosmartindent wrap
autocmd FileType python setlocal textwidth=79
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79
autocmd FileType html setlocal textwidth=0 shiftwidth=2 softtabstop=2 tabstop=2

" set ctags related variables for function display in status bar
"let g:ctags_statusline=1
"let generate_tags=1

" Ultisnips directory for extra snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

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

" functions for changing the colorscheme between dark and light
function SolarizeDark()
    set bg=dark
    colorscheme solarized
endfunction

function Solarize()
    set bg=light
    colorscheme solarized
endfunction

function UnSolarize()
    colorscheme default
    set bg=dark
endfunction

call UnSolarize()

" show tabs as T>>>>
let g:TabDisplayVal = 0
highlight SpecialKey ctermfg=1
set listchars=tab:T>

function TabDisplay()
    if g:TabDisplayVal
        set nolist
        let g:TabDisplayVal=0
    else
        set list
        let g:TabDisplayVal=1
    endif
endfunction
