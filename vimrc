scriptencoding=utf-8
"
" stewing@outlook.com .vimrc
"

" general
set nocompatible
set shell=/bin/bash
set background=dark
set history=700
set autoread
set autoindent
set ruler
set lazyredraw
set hidden
set timeoutlen=500
set laststatus=2
set showcmd
set showmode
set t_Co=256

" disable bells
set noerrorbells
set novisualbell
set t_vb=

autocmd! GUIEnter * set vb t_vb=

for dirname in ['/tmp/stewing', '/tmp/stewing/vim', '/tmp/stewing/vim/swap', '/tmp/stewing/vim/backup', $HOME.'/.vim/files/info']
    if !isdirectory(dirname)
        call mkdir(dirname, 'p')
    endif
endfor

set directory=/tmp/stewing/vim/swap/
set backupdir=/tmp/stewing/vim/backup/
set mouse-=a
set t_ut=

" ALE
"let g:ale_completion_enabled = 0
"let g:airline#extensions#ale#enabled = 1
"let g:ale_sign_column_always = 1
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_set_highlights = 0


" Jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#use_splits_not_buffers = "left"
" Defaults
" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"

" better whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" misc plugin stuff
let g:rainbow_active=1
let g:vim_search_pulse_duration=200
hi link illuminatedWord Visual

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" misc
Plug 'mhinz/vim-startify'
Plug 'jlanzarotta/bufexplorer'
Plug 'ntpeters/vim-better-whitespace'

" color
Plug 'danielwe/base16-vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'BurntSushi/ripgrep'

" tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'inside/vim-search-pulse'
Plug 'RRethy/vim-illuminate'

"Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'sheerun/vim-polyglot'

call plug#end()

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
set matchtime=2

" FZF
nnoremap \f :FZF<cr>
nnoremap \t :Tags<cr>

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
cnoremap Wq wq
cnoremap WQ wq
nnoremap ; :
nnoremap <silent> <buffer> <cr> :nohls<cr>

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
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_colors'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t %m'
let g:airline_section_z = '[0x%02.B] %3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
"  plugins
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#tagbar#flags='s'

" CTags
set tags+=src/tags,src/TAGS

" autocmds for certain files
autocmd FileType yaml   setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
autocmd BufEnter *.yml.template  setlocal filetype=yaml

" System-specific setttings
if has('unix')
    let s:uname = system('/usr/bin/uname')
    if s:uname ==? 'Darwin\n' " mac
        let g:tagbar_ctags_bin='/usr/local/bin/ctags'
    else " linux, bsd
        " tagbar setup
        let g:tagbar_ctags_bin='/usr/bin/ctags'
    endif
endif

if has('gui_running')
    colorscheme base16-tomorrow-night
    set guifont=MonoidNerdFontComplete-Regular:h12
    set clipboard=unnamed
else
    set background=dark
    " colorscheme base16-grayscale-dark
endif

if &diff
    set background=dark
    " colorscheme solarized
endif

if filereadable(expand('~/.vimrc_background'))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Background
set background=dark
hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE

