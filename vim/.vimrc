" ------------------
" Plugins Configuration
" ------------------

" Set the data directory depending on the editor used (Neovim or Vim)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" Automatically install vim-plug if not present
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ------------------
" General Configurations
" ------------------

" Configure jedi for Python autocompletion
let g:jedi#auto_vim_configuration = 1
let g:jedi#environment_path = "/usr/bin/python3"
let g:jedi#popup_select_first = 0
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#completions_enabled = 1

" Disable CoC startup warnings
let g:coc_disable_startup_warning = 1

" Specify the Python interpreter
let g:python3_host_prog = '/usr/bin/python3'

" ------------------
" Plugin Manager (vim-plug)
" ------------------

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" :CocInstall coc-tsserver
" :CocInstall coc-python
" :CocInstall coc-clangd
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'tmux-plugins/vim-tmux'
call plug#end()

" ------------------
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
" Ale Configuration for Linting and Formatting
" ------------------

" Fix files with prettier then ESLint for JavaScript
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint'],
    \}

" Enable auto-fixing on save
let g:ale_fix_on_save = 1

source ~/vim/plugins/commentary.vim
source ~/vim/plugins/shfmt.vim
source ~/vim/plugins/surround.vim
source ~/vim/plugins/nnn/plugin/nnn.vim
source ~/vim/plugins/gildas-s-plugins.vim

" Install missing plugins when opening Vim
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" ------------------
" NNN File Explorer Configuration
" ------------------

let g:nnn#set_default_mappings = 0 " Disable default mappings
nnoremap <silent> <leader>nn :NnnPicker<CR> " Launch NnnPicker
nnoremap <leader>n :NnnPicker %:p:h<CR> " Open in the current file's directory

" NNN Layout Configuration
let g:nnn#layout = 'new' " New layout (can be 'vnew', 'tabnew', etc.)
let g:nnn#layout = { 'left': '~20%' } " Custom size
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

" ------------------
" Search Mappings Configuration
" ------------------

" Center the search results
nnoremap n nzzzv
nnoremap N Nzzzv

" ------------------
" Visual Block Commands
" ------------------

" Move visual block down
vnoremap J :m '>+1<CR>gv=gv
" Move visual block up
vnoremap K :m '<-2<CR>gv=gv

" ------------------
" Cut/Copy/Paste Commands
" ------------------

if has('unnamedplus')
    set clipboard=unnamed,unnamedplus " Use system clipboard
endif

noremap YY "+y<CR> " Copy the current line to the clipboard
noremap <leader>p "+gP<CR> " Paste from the clipboard
noremap XX "+x<CR> " Cut the selection to the clipboard

" Use pbcopy for macOS
if has('macunix')
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><CR>
endif

" ------------------
" Window and Tab Configuration
" ------------------

" Window navigation mappings
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Tab mappings
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
noremap <leader>tn :tabnew<CR>
noremap <leader>to :tabonly<CR>
noremap <leader>tc :tabclose<CR>
noremap <leader>tm :tabmove

" Miscellaneous configurations
" ------------------

" Display line numbers and customize them

" Syntax and Filetype settings
syntax enable
filetype plugin indent on
set encoding=utf-8
autocmd BufReadPost * set fileencoding=utf-8
set fileformats=unix,dos,mac
set nocompatible

" GUI Font
set guifont=Consolas\ 18

" Line numbers and cursor line
set number relativenumber
set cursorline

" Highlighting
highlight LineNR cterm=none ctermfg=Yellow
highlight CursorLineNR cterm=bold ctermfg=Blue

" Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch
noremap <silent> <leader><space> :noh<CR>

" Tabs and indentation
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smarttab
set shiftround
set breakindent
set copyindent

" Folding
set foldlevel=99
set foldlevelstart=99
set nofoldenable

" Mouse and clipboard
set mouse=a
set clipboard=unnamedplus

" Split window settings
set splitbelow
set splitright
nnoremap <Leader>h :<C-u>split<CR>
nnoremap <Leader>v :<C-u>vsplit<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Fast saving
nnoremap <leader>w :w!<CR>
command! W w !sudo tee % > /dev/null

" Buffer navigation
nnoremap <leader>z :bp<CR>
nnoremap <leader>x :bn<CR>
nnoremap <leader>c :bd<CR>

" Tab navigation
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tc :tabclose<CR>

" Remap escape sequences
inoremap jj <Esc>
imap ;; <Esc>

" Remap <F2> to toggle paste mode in normal and insert modes
autocmd InsertLeave * set nopaste
"autocmd InsertEnter * set paste
nnoremap <F2> :set invpaste paste?<CR>
inoremap <F2> <C-o>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle settings
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Text wrapping
set nowrap
nmap <silent> tw :set invwrap<CR>:set wrap?<CR>

" Resizing splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Abbreviations
cnoreabbrev Q q
cnoreabbrev W w
cnoreabbrev WQ wq
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev qall qall!

" Mapping leader key
let mapleader=","
let maplocalleader=","

nnoremap <leader>rv :source $MYVIMRC<CR>
nnoremap <leader>ev :tabe $MYVIMRC<CR>
inoremap <leader>p :set invpaste paste?<CR>


" Statusline
set laststatus=2
set statusline=\ ☠\ %F%m%r%h%w\ (%{&ff}/%Y)\ ⚐\ %y%m%r%*\ ❑\ %n%=✎\ %(%l:%c\%)\ ⇨\ %P

" Wildmenu
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

" Insert mode mappings
inoremap $1 ()<Esc>i
inoremap $2 []<Esc>i
inoremap $3 {}<Esc>i
inoremap $q ''<Esc>i
inoremap $e ""<Esc>i

" Date and time insertion
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<CR>

" Visual mode mappings for surrounding text
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Moving lines
nnoremap <C-UP> :<C-u>silent! move-2<CR>==
nnoremap <C-DOWN> :<C-u>silent! move+<CR>==
xnoremap <C-UP> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-DOWN> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" Settings for undo and swap

set undofile
set undolevels=1000
set undodir=/home/gildas/.vim/undodir

" Activer les fichiers de sauvegarde
set backup
set backupdir=/home/gildas/.vim/backup//

" Activer les fichiers temporaires
set directory=/home/gildas/.vim/swap//

" Autocommands for folding and encoding
augroup vimrc
    autocmd!
    autocmd BufReadPre * setlocal foldmethod=indent
    autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Directory and session settings
set autochdir
set sessionoptions-=buffers
set sessionoptions-=curdir
set sessionoptions+=sesdir,globals


""=  : (re)indent the text on the current line or on the area selected (SUPER)
""=%  : (re)indent the current braces { ... }
""~  : invert case (upper->lower; lower->upper) of current character
""CTRL-A,CTRL-X : increment, decrement next number on same line as the cursor
""CTRL-R=5*5  : insert 25 into text
""G=gg  : auto (re)indent entire document
""g8  : display hex value of utf-8 character under cursor
""ga  : display hex, ascii value of character under cursor
""gf  : open file name under cursor (SUPER)
""ggg?G  : rot13 whole file
""guu  : lowercase line
""gUU  : uppercase line
""vim -V20 2>&1 | tee logfile # debug
""xp  : swap next two characters around
" vim:set et sw=2 foldmethod=expr
