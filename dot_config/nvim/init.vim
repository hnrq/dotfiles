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
Plug 'github/copilot.vim'

call plug#end()

let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'eslint'],
\ 'css': ['prettier', 'eslint'],
\ 'scss': ['prettier', 'eslint'],
\ 'javascriptreact': ['prettier', 'eslint'],
\ 'typescriptreact': ['prettier', 'eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
