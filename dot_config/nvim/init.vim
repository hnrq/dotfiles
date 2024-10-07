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
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-theme'
Plug 'terryma/vim-multiple-cursors'
Plug 'github/copilot.vim'

call plug#end()
