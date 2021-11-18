" Bootstrapping vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'tpope/vim-fugitive'

Plug 'neovim/nvim-lspconfig'

call plug#end()

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
set statusline+=\ [%{FugitiveHead()}]
set statusline+=\ %r        " Readonly flag
set statusline+=\ %w        " Preview window flag
set statusline+=\ %q        " Quickfix/Location list
set statusline+=%=          " Align right
set statusline+=%y          " File type
set statusline+=\ [%{&ff}]  " File format
set statusline+=\ %4.l:     " Line number
set statusline+=%-3.c       " Column number
set statusline+=%4.p%%      " Percentage through file in lines

set diffopt+=indent-heuristic,algorithm:patience

au BufRead,BufNewFile *.conf set filetype=conf

" Use <C-L> to clear the highlighting of :set hlsearch (tpope/vim-sensible)
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

let mapleader="\<space>"

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

lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    }
}
EOF

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>

nnoremap <leader>, <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>] :bnext<cr>
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>d :bdelete<cr>

nnoremap <leader>: <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader><space> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>H <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gb :Git blame<cr>

