" Enable syntax highlighting
syntax on

" Allow backspacing over autoindent, EOL markers, and the start of insert
set backspace=indent,eol,start

" Copy indent from current line when starting a new line
set autoindent

" Show the line number relative to the line with the cursor
set relativenumber
" but display its line number instead 0
set number

" Show the line and column number of the cursor position
set ruler

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" Possibility to have more than one unsaved buffers
set hidden

" Start searching before pressing enter
set incsearch

" Highlight all a previous search pattern's matches
set hlsearch

" Enhanced command-line completion
set wildmenu

" Remove scrollbars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Remove intro message
set shortmess+=I

" Always display a status line
set laststatus=2
set statusline=
set statusline+=%t          " File name (tail)
set statusline+=\ %m        " Modified flag
"set statusline+=\ [%{FugitiveHead()}]
set statusline+=\ %r        " Readonly flag
set statusline+=\ %w        " Preview window flag
set statusline+=\ %q        " Quickfix/Location list
set statusline+=%=          " Align right
set statusline+=%y          " Type of file
set statusline+=\ [%{&ff}]  " Format of file
set statusline+=\ %4.l:     " Line number
set statusline+=%-3.c       " Column number
set statusline+=%4.p%%      " Percentage through file in lines

let g:netrw_banner = 0      " Suppress the banner
let g:netrw_liststyle = 3   " Tree style listing
let g:netrw_winsize = 30    " Initial window size (%)
" Override default netrw buffer settings - display line numbers
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

let mapleader="\<space>"
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bl :buffers<cr>
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>bD :bdelete!<cr>
nnoremap <leader>w <C-w>

filetype plugin indent on
au BufRead,BufNewFile *.conf set filetype=conf
set shiftwidth=4
set tabstop=4
set expandtab


" Use <C-L> to clear the highlighting of :set hlsearch (tpope/vim-sensible)
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

