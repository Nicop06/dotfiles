call pathogen#infect()

let mapleader = ","

set pastetoggle=<F7>
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

