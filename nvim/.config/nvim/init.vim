"=====================================================
"      __ __ _             __    ___   ___  _
"     / //_/(_)___  ___ _ / /__ |_  | |_  |( )___
"    / ,<  / // _ \/ _ `//  '_// __/ / __/ |/(_-<
"   /_/|_|/_//_//_/\_, //_/\_\/____//____/  /___/
"                 /___/
"                           _
"     ___  ___  ___  _  __ (_)__ _
"    / _ \/ -_)/ _ \| |/ // //  ' \
"   /_//_/\__/ \___/|___//_//_/_/_/
"
"     _____             ___ _
"    / ___/___   ___   / _/(_)___ _
"   / /__ / _ \ / _ \ / _// // _ `/
"   \___/ \___//_//_//_/ /_/ \_, /
"                           /___/
"
"=====================================================

" Always exit all files

" cnoreabbrev q qa
" cnoreabbrev wq wqa

"=====================================================

" Auto commands

augroup General

    autocmd FileType markdown,text setlocal spell
"    autocmd BufReadPost *.md Goyo 85%x85%
    autocmd VimResized * execute "normal \<C-W>="

augroup END

"=====================================================

" Basic options

set nocompatible
filetype plugin on
syntax on

set path+=**
set wildmenu

set updatetime=100

"=====================================================

" Colours

hi TabLineSel ctermfg=5 ctermbg=0
hi TabLine ctermfg=7 ctermbg=0
hi TabLineFill ctermfg=0 ctermbg=1

"=====================================================

" Hide end-of-file symbols

hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black

"=====================================================

" Indenting

set autoindent
set smartindent

"=====================================================

" Netrw

let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"=====================================================

" No backup file

set nobackup

"=====================================================

" On pressing tab, insert 4 spaces

set expandtab
set tabstop=4
set shiftwidth=4

"=====================================================

" Plugins

call plug#begin('~/.vim/plugged')

"Plug 'francoiscabrol/ranger.vim'

"Plug 'junegunn/goyo.vim'

Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

Plug 'airblade/vim-gitgutter'

"Plug 'mzlogin/vim-markdown-toc'

call plug#end()

"=====================================================

" Ranger

"let g:ranger_map_keys = 0
"map <leader>r :Ranger<CR>
"let g:ranger_replace_netrw = 1

"=====================================================

" Searching

set hlsearch
set incsearch
set ignorecase
set smartcase

nnoremap <esc> :noh<CR>

"=====================================================

" Set title of file as window title

set title

"=====================================================

" Show invisible characters

set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

"=====================================================

" Spelling

set spelllang=en_au

hi SpellBad ctermbg=1 ctermfg=0

"=====================================================

" Splits

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

"=====================================================

" UI

set cmdheight=2
set laststatus=1
"set noshowmode
set number
set relativenumber
set scrolloff=10
set shortmess=at
set ttyfast

"=====================================================

" Wrapping

set breakindent
set linebreak

"nnoremap <down> gj
"nnoremap <up> gk
"vnoremap <down> gj
"vnoremap <up> gk
