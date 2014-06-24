set nocompatible
filetype off

" Set up vundle (source: http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/)
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'Rip-Rip/clang_complete'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jcf/vim-latex'
Plugin 'lepture/vim-jinja'
Plugin 'sophacles/vim-bundle-mako'
Plugin 'mattn/emmet-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'parkr/vim-jekyll'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler.git'
Plugin 'rking/ag.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

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
set showmatch
set hlsearch
set incsearch
set ignorecase
set smarttab
set ruler

" Insert mode options
set backspace=2
set autoindent
set formatoptions=c,q,r,t

" Enable syntax and set background
set background=dark
syntax on

" Change leader to comma
let mapleader = ","

" Set shortcuts
set pastetoggle=<F10>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>

" Solarized theme
let vundle_readme=expand('~/.vim/bundle/vim-colors-solarized/README.mkd')
if !filereadable(vundle_readme)
    let g:solarized_termcolors=256
    colorscheme solarized
endif

" Tags
" set tags+=~/.vim/tags/ctags

" clang complete
"let g:clang_complete_auto = 1
"let g:clang_use_library = 1
"let g:clang_debug = 1
"let g:clang_library_path = '/usr/lib/'
"let g:clang_user_options='|| exit 0'

" Move on the displayed lines, not real lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Customize emmet keymappings
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_expandword_key = '<c-e>'
let g:user_emmet_wrap_with_abbreviation_key = '<c-e>'

" Vim-latex options
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" Command to compile files
command Gcc :!gcc % -o %:r && %:r
