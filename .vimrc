" set max width to 120
set textwidth=120

" no text wrapping
set nowrap

" set line numbers
set number

" set spacing and indent
"set tabstop=2 shiftwidth=2 expandtab
"set ts=2

" set max width for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

let mapleader=','
map - :Explore<cr>

" save swap files to /tmp
set dir=/tmp//

" highlight search
set hlsearch

" golang syntax highlighting
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
