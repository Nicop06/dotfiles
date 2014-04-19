set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Plugin 'garbas/vim-snipmate'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'Rip-Rip/clang_complete'
Plugin 'jcf/vim-latex'

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

" For vim-latex
set grepprg=grep\ -nH\ $*

" Command to compile files
command Gcc :!gcc % -o %:r && %:r

" Search in the current directory
function! FSearchl(pattern)
    execute '!grep --color=auto -Rl ' .  a:pattern . ' --include=\*.{cpp,c,h}'
endfunction

function! FSearch(pattern)
    execute '!grep --color=auto -R ' . a:pattern . ' --include=\*.{cpp,c,h}'
endfunction

command! -nargs=1 Search call FSearch(<f-args>)
command! -nargs=1 Searchl call FSearchl(<f-args>)
