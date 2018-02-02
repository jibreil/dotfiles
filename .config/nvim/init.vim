"=====================================================
"      __ __ _             __    ___   ___  _
"     / //_/(_)___  ___ _ / /__ |_  | |_  |( )___
"    / ,<  / // _ \/ _ `//  '_// __/ / __/ |/(_-<
"   /_/|_|/_//_//_/\_, //_/\_\/____//____/  /___/
"                 /___/     _
"     ___  ___  ___  _  __ (_)__ _
"    / _ \/ -_)/ _ \| |/ // //  ' \
"   /_//_/\__/ \___/|___//_//_/_/_/
"     _____             ___ _
"    / ___/___   ___   / _/(_)___ _
"   / /__ / _ \ / _ \ / _// // _ `/
"   \___/ \___//_//_//_/ /_/ \_, /
"                            /___/
"
"=====================================================


" PLUGINS

" Plugin directory
call plug#begin('~/.vim/plugged')

" Plugin list
Plug 'junegunn/goyo.vim'

" End list
call plug#end()

" Hide UI
set noshowmode
set laststatus=0
set shortmess=atI
set cmdheight=2

nnoremap <down> gj
nnoremap <up> gk
vnoremap <down> gj
vnoremap <up> gk

set spelllang=en_au

augroup General

    autocmd FileType markdown,text setlocal spell

    autocmd BufReadPost * Goyo 90%x90%

augroup END

cnoreabbrev q qa

" Show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Softwrapped lines keep indent level
set breakindent

" Don't wrap in the middle of a word
set linebreak

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <esc> :noh<return><esc>
