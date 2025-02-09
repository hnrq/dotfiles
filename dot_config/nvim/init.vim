set nocompatible
let g:mapleader=" "

call plug#begin('~/.vim/vendor')

if !has('nvim') && !exists('g:gui_oni') | Plug 'tpope/vim-sensible' | endif
Plug 'rstacruz/vim-opinion'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/space-vim-theme'
Plug 'terryma/vim-multiple-cursors'

call plug#end()


let g:ale_fixers = {
\ 'javascript': ['biome', 'eslint'],
\ 'typescript': ['biome', 'eslint'],
\ 'css': ['biome', 'eslint'],
\ 'scss': ['biome', 'eslint'],
\ 'javascriptreact': ['biome', 'eslint'],
\ 'typescriptreact': ['biome', 'eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
