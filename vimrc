"
" stewing@outlook.com .vimrc
"

" general
set nocompatible
set shell=/bin/bash
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

"silent !mkdir /tmp/stewing > /dev/null 2>&1
"silent !mkdir /tmp/stewing/vim > /dev/null 2>&1
"silent !mkdir /tmp/stewing/vim/swap/ > /dev/null 2>&1
"silent !mkdir /tmp/stewing/vim/backup/ > /dev/null 2>&1
"silent !mkdir $HOME/.vim/files/info/

for dirname in ["/tmp/stewing", "/tmp/stewing/vim", "/tmp/stewing/vim/swap", "/tmp/stewing/vim/backup", $HOME."/.vim/files/info"]
    if !isdirectory(dirname)
        call mkdir(dirname, "p")
    endif
endfor

set directory=/tmp/stewing/vim/swap/
set backupdir=/tmp/stewing/vim/backup/
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
" git-related
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" airline
Plugin 'bling/vim-airline'

" colors
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'

"
Plugin 'ervandew/supertab'
Plugin 'gmarik/Vundle.vim'
"Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'jlanzarotta/bufexplorer'
Plugin 'mbbill/undotree'
Plugin 'mhinz/vim-startify'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-vinegar'
Plugin 'Shougo/denite.nvim'

Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/OmniCppComplete'
" tags
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/ctags.vim'
Plugin 'vim-scripts/taglist.vim'

Plugin 'wellle/targets.vim'
Plugin 'wincent/command-t'
Plugin 'mtth/scratch.vim'

" completion
"Plugin 'Rip-Rip/clang_complete'
Plugin 'artur-shaik/vim-javacomplete2'

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
if has('nvim')
    set viminfo='100,n$HOME/.vim/files/info/shada
else
    set viminfo='100,n$HOME/.vim/files/info/viminfo
endif

" spacing
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set listchars=trail:¡,precedes:«,extends:»,eol:↩,nbsp:↔,tab:●○
" examples: 
" precedes:
" extends
" tail:     
" eol:
" nbsp:  
: tab:  	
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
nnoremap <CR> :noh<CR>
command W w
command Q q
nnoremap ; :
nnoremap <silent> <buffer> <cr> :nohls<cr>
nnoremap \f :FZF<cr>

"" Command Mode Keys, ironically    
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-p> <Up>
"cnoremap <C-n> <Down>
"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <M-b> <S-Left>
"cnoremap <M-f> <S-Right>

" local setup
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" base16 setup
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" BufExplorer Setup
let g:bufExplorerShowRelativePath=1     " Show relative paths.
let g:bufExplorerSortBy='fullpath'      " Sort by full file path name.

" Airline Config
let g:airline_powerline_fonts=1
let g:airline_theme='base16_colors'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t %m'
let g:airline_section_z = '[0x%02.B] %3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
"  plugins
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#tagbar#flags='s'

" clang_complete setup
let g:clang_library_path="/usr/lib/llvm-3.8/lib/libclang.so.1"

" CTags
set tags+=src/tags,src/TAGS

" System-specific setttings
if has("unix")
    let s:uname = system("/usr/bin/uname")
    if s:uname == "Darwin\n" " mac
        "set guifont=Anonymice\ Powerline:h13
        let g:tagbar_ctags_bin="/usr/local/bin/ctags"
        " clang_complete setup
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"

    else " linux, bsd

        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
        " tagbar setup
        let g:tagbar_ctags_bin="/usr/bin/ctags"

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
    " colorscheme base16-grayscale-dark
endif

if &diff
    set background=dark
    " colorscheme solarized
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set background=dark

"
" Whitespace
"

"
" vim-javacomplete2 setup
"
autocmd FileType java setlocal omnifunc=javacomplete#Complete

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)

nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)

nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

function SetJavacompleteClasspath()
    let g:JavaComplete_LibsPath = system('brazil-path build.classpath 2>/dev/null')
    echo printf("%s", g:JavaComplete_LibsPath);
endfunction

"
" end vim-javacomplete2
"

set background=dark
