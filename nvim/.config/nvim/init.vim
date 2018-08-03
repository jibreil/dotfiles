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

cnoreabbrev q qa

"=====================================================

" Auto commands

augroup General

    autocmd FileType markdown,text setlocal spell

"    autocmd BufReadPost * Goyo 90%x90%
    autocmd VimResized * execute "normal \<C-W>="

augroup END

"=====================================================

" Hide end-of-file symbols

hi EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black

"=====================================================

" Indenting

set autoindent
set smartindent

set shiftwidth=4

"=====================================================

" Natural split

set splitbelow
set splitright

"=====================================================

" Nerdtree

noremap <F10> :NERDTreeToggle<CR>
noremap <F5> :NERDTreeFocus<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"=====================================================

" No backup file

set nobackup

"=====================================================

" On pressing tab, insert 4 spaces

set expandtab
set tabstop=4
set shiftwidth=4

"=====================================================

" Pickachu

let g:pickachu_default_date_format = "%d.%m.%Y"

"=====================================================

" Plugins

" Plugin directory

call plug#begin('~/.vim/plugged')

" Plugin list

Plug 'junegunn/goyo.vim'

Plug 'DougBeney/pickachu'

Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'rhysd/open-pdf.vim'

" End list

call plug#end()

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


" Show existing tab with 4 spaces width

set tabstop=4

"=====================================================

" Show invisible characters

set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

"=====================================================

" Spelling

set spelllang=en_au

hi SpellBad ctermbg=1 ctermfg=0

"=====================================================

" UI

set cmdheight=2
set laststatus=0
set noshowmode
set number
set scrolloff=5
set shortmess=atI
set ttyfast

"=====================================================

" Wrapping

set breakindent
set linebreak

nnoremap <down> gj
nnoremap <up> gk
vnoremap <down> gj
vnoremap <up> gk

"=====================================================
