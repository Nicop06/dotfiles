set nocompatible
filetype off

" Vim plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Plugin 'VundleVim/Vundle.vim'

" Base plugins
Plugin 'jlanzarotta/bufexplorer'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'will133/vim-dirdiff'
"Plugin 'godlygeek/tabular'

" Version control software
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/vcscommand.vim'

" Hints
"Plugin 'scrooloose/syntastic'
"Plugin 'bling/vim-airline'

" Colorscheme
Plugin 'altercation/vim-colors-solarized.git'
"Plugin 'tomasr/molokai'

" EditorConfig
"Plugin 'editorconfig/editorconfig-vim'

" Autocomplete
"Plugin 'mattn/emmet-vim'
"Plugin 'Valloric/YouCompleteMe'

" Snippets
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

" Vim Note
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-notes'
"Plugin 'vimoutliner/vimoutliner'
Plugin 'reedes/vim-pencil'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

" Latex
"Plugin 'LaTeX-Box-Team/LaTeX-Box'

" R
"Plugin 'jalvesaq/Nvim-R'

call vundle#end()


filetype plugin indent on

" Set tabs size and use spaces
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Line numbers, search and command options
set showcmd
set number
set relativenumber
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab
set ruler

" Insert mode options
set backspace=2
set autoindent
set formatoptions=c,q,r,t

" Status line
set laststatus=2

" Enable folding
set foldmethod=marker

" Force vertical split
set diffopt+=vertical

" Enable syntax and set background
set background=dark
syntax on

" Change leader to comma
let mapleader = ","
let maplocalleader = ","

" Clear search register
nnoremap <leader>/ :let @/=""<CR>

" Set shortcuts
map <F5> :setlocal spell! spelllang=en_us<CR>:syntax spell toplevel<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>
set pastetoggle=<F10>

" Colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1
try
  colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme slate
endtry

" Move on the displayed lines, not real lines
noremap <silent> k gk
noremap <silent> j gj

" CtrlP preferences
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Customize Emmet keymappings
let g:user_emmet_leader_key='<C-S>'

" UltiSnips config
let g:UltiSnipsExpandTrigger="<c-c>"
let g:UltiSnipsJumpForwardTrigger="<c-c>"
let g:UltiSnipsJumpBackwardTrigger="<c-v>"

" Vim-airline
let g:airline_powerline_fonts = 1

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" LatexBox
let g:LatexBox_viewer = "zathura"

" Run Makefile
nnoremap <leader>r :make! run<CR>

" Improve tabs management
nnoremap <leader>te :tabe<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <C-n>      :tabnext<CR>
nnoremap <C-h>      :tabprevious<CR>
nnoremap <C-k>      :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <C-j>      :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>

" GNU Global
set csprg=gtags-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Auto_Map = 1
let g:GtagsCscope_Quiet = 1
