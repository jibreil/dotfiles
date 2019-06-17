" auto commands
augroup General
    autocmd FileType markdown,text,tex setlocal spell
    autocmd VimResized * execute "normal \<C-W>="
augroup END

" basic options
filetype plugin on
set nocompatible
set path+=**
set updatetime=100
set wildmenu
syntax on

" colours
hi LineNr ctermfg=8
hi CursorLineNr ctermfg=5
hi TabLineSel ctermfg=5 ctermbg=0
hi TabLine ctermfg=7 ctermbg=0
hi TabLineFill ctermfg=0 ctermbg=1

" disable bells
set t_vb=
set visualbell

" hide end of file symbols
hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black

" indenting
set autoindent
set smartindent

" line wrapping
highlight ColorColumn ctermbg=8
set colorcolumn=81
set nowrap
set textwidth=0
set wrapmargin=0
"nnoremap <down> gj
"nnoremap <up> gk
"vnoremap <down> gj
"vnoremap <up> gk
"set breakindent
"set linebreak

" netrw
let g:netrw_banner=0        " disable annoying banner
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" no backup file
set nobackup

" plugins
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/goyo.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'lervag/vimtex'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-maktaba'
    Plug 'google/vim-glaive'
call plug#end()

" searching
set hlsearch
set ignorecase
set incsearch
set smartcase
nnoremap <esc> :noh<CR>

" set title of file as window title
set title

" show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" spelling
set spelllang=en_au
hi SpellBad ctermbg=1 ctermfg=0

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" tab > 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4

" ui
set relativenumber
set scrolloff=10
set ttyfast
"set cmdheight=1
"set laststatus=1
"set noshowmode
"set shortmess=at

" status bar colors
hi StatusLine ctermfg=0 ctermbg=8 cterm=none term=none
hi User1 ctermfg=8 ctermbg=0 cterm=none term=none
hi User2 ctermfg=8 ctermbg=none cterm=none term=none
hi User3 ctermfg=8 ctermbg=0 cterm=none term=none
hi User4 ctermfg=0 ctermbg=8 cterm=none term=none

" status bar
set statusline=\                    "
set statusline+=%t                  "
set statusline+=\ %1*\              "
set statusline+=%y                  "
set statusline+=\ %2*\              "
set statusline+=%=                  "
set statusline+=\ %3*\              "
set statusline+=line                "
set statusline+=\                   "
set statusline+=%l                  "
set statusline+=\ %4*\              "
set statusline+=of                  "
set statusline+=\                   "
set statusline+=%L                  "
set statusline+=\                   "
