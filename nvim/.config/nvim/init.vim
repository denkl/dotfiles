" Precede each line with its line number
set number

" Show the line number relative to the line with the cursor
set relativenumber

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" Possibility to have more than one unsaved buffers
set hidden

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Number of spaces to a <Tab>
set tabstop=4

" Replace tabs with spaces
set expandtab

" Put the new window right of the current one
set splitright

" Put the new window below the current one
set splitbelow

" Patterns to ignore when expanding command-line completions
set wildignore+=*.pyc
set wildignore=*/__pycache__/

set statusline=
set statusline+=%f          " File name
set statusline+=\ %m        " Modified flag
"set statusline+=\ [%{FugitiveHead()}]
set statusline+=\ %r        " Readonly flag
set statusline+=\ %w        " Preview window flag
set statusline+=\ %q        " Quickfix/Location list
set statusline+=%=          " Align right
set statusline+=%y          " File type
set statusline+=\ [%{&ff}]  " File format
set statusline+=\ %4.l:     " Line number
set statusline+=%-3.c       " Column number
set statusline+=%4.p%%      " Percentage through file in lines

au BufRead,BufNewFile *.conf set filetype=conf

" Use <C-L> to clear the highlighting of :set hlsearch (tpope/vim-sensible)
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

let mapleader="\<Space>"

nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bl :buffers<cr>
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>bD :bdelete!<cr>

" Behave like other capital letters
nnoremap Y y$

" Make it centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Preserve cursor position on join lines
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ; ;<c-g>u

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
