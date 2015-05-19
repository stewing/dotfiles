"
" stewing@outlook.com .vimrc
"

" general
set nocompatible
set background=dark
set history=700
set autoread
set ruler
set lazyredraw
set hid
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"
" Vundle setup -- BEGIN
"
filetype off
set runtimepath+=$HOME/.vim/bundle
set runtimepath+=$HOME/.vim/bundle/Vundle.vim
" Vundle setup -- MODULES
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/ctags.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/a.vim'
Plugin 'flazz/vim-colorschemes'
call vundle#end()
"
" Vundle setup -- BEGIN
"

" searching
set smartcase
set showmatch
set incsearch
set showmatch
set mat=2

" filetype plugin/syntax
filetype plugin on
filetype indent on
syntax enable

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%


" spacing
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" wildmode
set wildmenu
set wildmode=list,longest
set wildignore=*.o,*~,*.pyc

" Airline Config
let g:airline_powerline_fonts=1
let g:airline_theme='wombat'

" CTags
set tags+=src/TAGS

colorscheme molokai
