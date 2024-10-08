set nocompatible                        " get all the vim goodness

let mapleader = ";"

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
if !has('nvim')
    set term=xterm-256color " for knowing the terminal control characters
endif
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
set magic               " use magic (regex) for searches
set showmatch           " show matching brackets
set smartcase           " case-sensitive when uppercase chars given
set sidescroll=1        " sidescroll this much number of chars
set ruler               " show row,column in the bottom right corner
set laststatus=2        " show the status line always
set iskeyword+=_,$,@,%,#,',],),},; " for word boundaries
set textwidth=119       " limit maximum length of line to 79
set colorcolumn=120     " show a line at 80 and 120 char limit
"set cscopetag          " use cstag for <Ctrl-]> and vim -t, and default is to first search cscope db
set backspace=2         " allow backspace deleting of characters
set mouse=i             " get all that nice mouse scrolling support in insert mode
set encoding=utf-8      " set encoding to utf-8

" buffers
map <Leader>bn :bnext<cr>
map <Leader>bp :bprevious<cr>
map <Leader>bd :bdelete<cr>

" autostart with NERDTree, but move to the other window
"command Nerd NERDTree | wincmd w
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd w
:nnoremap <C-g> :NERDTreeToggle<CR>

" specific filetype vim settings
autocmd FileType c setlocal shiftwidth=8 softtabstop=8 tabstop=8 textwidth=80 noexpandtab
autocmd BufNewFile,BufRead *.h setlocal filetype=c
autocmd FileType markdown setlocal spell noautoindent nosmartindent wrap
autocmd FileType python setlocal textwidth=79
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 textwidth=79
autocmd FileType html setlocal textwidth=0 shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType go setlocal textwidth=79 shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" set ctags related variables for function display in status bar
"let g:ctags_statusline=1
"let generate_tags=1

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

" alacritty
set termguicolors

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

autocmd FileType json syntax match Comment +\/\/.\+$+

" set color column color
highlight ColorColumn ctermbg=grey

" language: golang
let g:go_fmt_command = "goimports" " run goimports along gofmt on save
let g:go_auto_type_info = 1 " automatically get signature/typo info of object under cursor
"au filetype go inoremap <buffer> . .<C-x><C-o>

"let g:syntastic_python_checkers = ['flake8', 'pylint', 'mypy']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :Rg<Space>

" ale
"let g:ale_linters_explicit = 1
"let g:ale_linters = {
"  \ 'zig': ['zls'],
"  \ 'go': ['gopls'],
"\}
"highlight ALEVirtualTextWarning guifg=#FF8800 gui=italic
"highlight ALEVirtualTextError guifg=#FF0000 gui=italic
"
"let g:ale_enabled = 0
"let g:ale_disable_lsp = 1
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
"" You can disable this option too
"" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0

" airline
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' l:'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = 'c:'

" typo protection
command! Wq wq
command! Wqa wqa
command! Q q

" vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nnoremap <silent> <leader> :WhichKey ';'<CR>
set timeoutlen=500

call plug#begin()

" List your plugins here
Plug 'nvim-lua/plenary.nvim'
Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }

call plug#end()
