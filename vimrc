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



silent !mkdir /tmp/sewing > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim/swap/ > /dev/null 2>&1
silent !mkdir /tmp/sewing/vim/backup/ > /dev/null 2>&1
set directory=/tmp/sewing/vim/swap/
set backupdir=/tmp/sewing/vim/backup/
set mouse-=a
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
Plugin 'scrooloose/nerdcommenter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/a.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-startify'
Plugin 'rking/ag.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wellle/targets.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'tpope/vim-fugitive'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-vinegar'
Plugin 'morhetz/gruvbox'
Plugin 'rust-lang/rust.vim'
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
"nnoremap W w
"nnoremap Q q

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
"set viminfo^=%
set viminfo='100,n$HOME/.vim/files/info/viminfo

" spacing
set expandtab
set smarttab
set shiftwidth=2
set tabstop=4
set listchars=trail:¡,precedes:«,extends:»,eol:↩,tab:▸\ 
"set listchars=trail:⏘,precedes:👈,extends:👉,eol:👇,tab:👊\

" language-specific settings
set cinoptions+=g0

" wildmode
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.class
set wildignore+=*~
set wildignore+=*.pyc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.gifv

" Common Command Mappings
command WQ wq
command Wq wq
command Wa wa
command WA wa
command WQa wqa
command Wqa wqa
command W w
command Q q


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

" clang_complete setup
let g:clang_library_path="/usr/lib/llvm-3.8/lib/libclang.so.1"

" CTags
set tags+=src/tags,src/TAGS

" System-specific setttings
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n" " mac

        set guifont=Anonymice\ Powerline:h13
        let g:tagbar_ctags_bin="/usr/local/bin/ctags"
        " clang_complete setup
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"


    else " linux, bsd

        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
        " tagbar setup
        let g:tagbar_ctags_bin="/fs/home/sewing/.packages/bin/ctags"

        " clang_complete setup
        if !empty(glob("/usr/lib/libclang.so.0"))
            let g:clang_library_path="/usr/lib/libclang.so.0"
        else
            let g:clang_complete_loaded=1
        endif

    endif
endif


if has('gui_running')
    colorscheme Tomorrow-Night
    set clipboard=unnamed
else
    set background=dark
    colorscheme solarized
endif

if &diff
    set background=dark
    colorscheme solarized
endif
