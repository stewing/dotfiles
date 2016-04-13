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
set tm=500
set laststatus=2
set showcmd
set showmode

" disable bells
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " mac
        set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline:h11
    else
        " linux, bsd
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    endif
endif

silent !mkdir /tmp/sewing > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim/swap/ > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim/backup/ > /dev/null 2>&1
set directory=/tmp/sewing/vim/swap/
set backupdir=/tmp/sewing/vim/backup/

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
Plugin 'rking/ag.vim'
<<<<<<< HEAD
Plugin 'vim-airline/vim-airline-themes'
=======
Plugin 'wellle/targets.vim'
>>>>>>> 6da2aa4325dc4d046c48f2232aeb7517acc74b13
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
"Plugin 'scrooloose/syntastic'
" Plugin 'Shougo/unite.vim' !!! doesn't work with vim 702
Plugin 'mbbill/undotree'
call vundle#end()
"
" Vundle setup -- END
"

" scrolling
set scrolloff=2
set sidescrolloff=15
set sidescroll=1

" searching
set smartcase
set showmatch
set incsearch
set showmatch
set hlsearch
set mat=2
nnoremap  <CR> :noh<CR>

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
<<<<<<< HEAD
set listchars=trail:🚫,precedes:«,extends:»,eol:↩,tab:▸\ 
"set listchars=trail:⏘,precedes:👈,extends:👉,eol:👇,tab:👊\
=======
set listchars=trail:⛔,precedes:«,extends:»,eol:↩,tab:▸\ 
"set listchars=trail:⏘,precedes:👈,extends:👉,eol:👇,tab:👊\ 
"
>>>>>>> 6da2aa4325dc4d046c48f2232aeb7517acc74b13

" language-specific settings
set cinoptions+=g0

" wildmode
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.class
set wildignore+=*~
set wildignore+=*.pyc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.gifv

" BufExplorer Setup
let g:bufExplorerShowRelativePath=1     " Show relative paths.
let g:bufExplorerSortBy='fullpath'      " Sort by full file path name.

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

" ag.vim setup
let g:ag_prg="/fs/home/sewing/.packages/bin/ag --vimgrep"

" tagbar setup
let g:tagbar_ctags_bin="/fs/home/sewing/.packages/bin/ctags"

" CTags
set tags+=src/TAGS

if has('gui_running')
    colorscheme grey2
else
    set background=dark
    colorscheme enzyme
endif

if &diff
    colorscheme desert256v2
endif
