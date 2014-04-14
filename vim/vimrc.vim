set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'msanders/snipmate.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'

let mapleader = ","

set pastetoggle=<F11>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>

" Solarized theme
let g:solarized_termcolors=256
colorscheme solarized

" Tags
set tags+=~/.vim/tags/ctags

" clang complete
let g:clang_complete_auto = 1
let g:clang_use_library = 1
let g:clang_debug = 1
let g:clang_library_path = '/usr/lib/'
let g:clang_user_options='|| exit 0'

