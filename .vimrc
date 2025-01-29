" --------------------------------------------------------------
" .vimrc: Vim - Configuration File
" Resources:
" 	http://jmcpherson.org/vimrc.html
" 	http://www.stripey.com/vim/vimrc.html
" 	http://www.hermann-uwe.de/files/vimrc
"   http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"   http://nvie.com/posts/how-i-boosted-my-vim/
"
" --------------------------------------------------------------

"
" vim-plug Setup
"
call plug#begin('~/.vim/plugged')
	Plug 'airblade/vim-gitgutter'
	Plug 'altercation/vim-colors-solarized'
	Plug 'chr4/nginx.vim'
	Plug 'elzr/vim-json'
	Plug 'glench/vim-jinja2-syntax'
	Plug 'fatih/vim-go', { 'tag': '*' }
	Plug 'hashivim/vim-terraform'
	Plug 'hashivim/vim-vagrant'
	Plug 'hashivim/vim-vaultproject'
	Plug 'powerline/powerline'
	Plug 'python-mode/python-mode'
	Plug 'scrooloose/nerdtree'
	Plug 'tmux-plugins/vim-tmux'
	Plug 'tmux-plugins/vim-tmux-focus-events'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'vim-syntastic/syntastic'
	Plug 'will133/vim-dirdiff'
	Plug 'xuyuanp/nerdtree-git-plugin'
	Plug 'yggdroot/indentLine'
call plug#end()

"
" Basic Setup
"

" General application behaviour
set nowrap                         " disable line wrapping
    autocmd FileType markdown setlocal wrap
set textwidth=0                    " don't wrap words
set number                         " enable line numbers
set ruler                          " show the line and column numbers of the cursor
set showmatch                      " set show matching parenthesis
set backspace=indent,eol,start     " allow backspacing over everything in insert mode
set history=1000                   " number of lines of command line history
set undolevels=1000                " number of undo levels
set title                          " change the terminal's title
set showmode                       " show current mode
set showcmd                        " show (partial) command in status line
set visualbell                     " no beeps
set noerrorbells                   " no beeps
set mouse=a                        " enable mouse in terminal & gui
set scrolloff=4                    " keep 4 lines off the edges of the screen when scrolling
set cursorline                     " underline the current line, for quick orientation
set showbreak=+                    " show a '+' if a line is longer than the screen.
"set hidden                        " hide buffers instead of closing them.
set wildmenu                       " make tab completion for files/buffers act like bash
set wildmode=list:full             " show a list when pressing tab and complete first full match
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

" Editor layout
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                     " don't update the display while executing macros
set laststatus=2                   " tell VIM to always put a status line in, even if there is only one window
set cmdheight=2                    " use a status bar that is 2 rows high

" Tabs and indentation
set tabstop=4                      " number of spaces <tab> counts for
set softtabstop=2
set autoindent                     " auto indentation by default
set copyindent                     " copy the previous indentation on autoindenting
set shiftwidth=4                   " number of spaces to use for autoindenting
set shiftround                     " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                       " insert tabs on the start of a line according to shiftwidth, not tabstop
"filetype plugin indent on         " enable indentation based on file type (I don't like this)

" Search behaviour
set ignorecase                     " ignore case when searching
set smartcase                      " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                       " highlight search terms
set incsearch                      " incremental search
"nnoremap / /\v                     " make vim use normal regex
"vnoremap / /\v                     " make vim use normal regex

" Grown-ups use git
set nobackup
"set noswapfile
set directory=~/.vim/.swap,/tmp   " store swap files in one of these directories
if v:version >= 730
    set undofile                  " keep a persistent backup file
    set undodir=~/.vim/.undo,/tmp
endif

"
" Colorscheme & Syntax Highlighting
"
if &t_Co > 2 || has("gui_running")
    syntax enable                 " switch syntax highlighting on, when the terminal has colors
    filetype on                   " allow file type detection
endif

if &t_Co >= 256 || has("gui_running")
	let g:solarized_termcolors=256
	set background=dark
	colorscheme solarized
endif

"
" Key Bindings
"
set pastetoggle=<F2>                     " use function key to toggle `set paste`
let mapleader=","                        " change the mapleader from \ to ,
cmap w!! w !sudo tee % >/dev/null        " just in case you forgot sudo
nnoremap <leader>i :set list!<cr>        " toggle invisible chars
nnoremap <leader>N :setlocal number!<cr> " toggle line numbers

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Enable to train yourself on vim navigation
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

"
" vim Plugins
"

"NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
"NERDTree - open NERDTree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"NERDTree - open NERDTree when a directory is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"NERDTree - close NERDTree when its the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"Markdown Highlighting of all *.md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"Terraform
let g:terraform_align = 1

"GitGutter
let g:gitgutter_max_signs = 500
if exists('&signcolumn')  " Vim 7.4.2201
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif
