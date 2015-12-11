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
set laststatus=2

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " mac
    else
        " linux, bsd
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    endif
endif

set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/swap/

set t_ut=

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
Plugin 'scrooloose/nerdcommenter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/a.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-startify'
"Plugin 'scrooloose/syntastic'
" Plugin 'Shougo/unite.vim' !!! doesn't work with vim 702
Plugin 'mbbill/undotree'
call vundle#end()
"
" Vundle setup -- BEGIN
"

" searching
set smartcase
set showmatch
set incsearch
set showmatch
set hlsearch
set mat=2
nnoremap <CR> :let @/ = ""<CR>

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

" language-specific settings
set cinoptions+=g0

" wildmode
set wildmenu
set wildmode=list,longest,full
set wildignore=*.o,*~,*.pyc

" Airline Config
let g:airline_powerline_fonts=1
let g:airline_theme='wombat'
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'
let g:airline_section_z = '[0x%02.B] %3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
""  plugins
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#tagbar#flags='s'
" let g:airline#extensions#syntastic#enabled=1

" tagbar setup
let g:tagbar_ctags_bin="/fs/home/sewing/.packages/bin/ctags"

" CTags
set tags+=src/TAGS

if has('gui_running')
    colorscheme desert
else
    set background=dark
    colorscheme desertEx
endif
