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

" Do not wrap long lines
set nowrap

" Change the terminal title according to the currently active buffer
set title

" When searching, match case only when at least one char is upper
set ignorecase
set smartcase

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

" Remove trailing whitespaces
command CleanFile normal! :%s/\s\+$//g<CR>

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
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>

nnoremap <leader>, <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>] :bnext<cr>
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>d :bdelete<cr>

nnoremap <leader>w <c-w>w

tnoremap <esc> <c-\><c-n>:bd!<cr>

nnoremap <leader>: <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader><space> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>H <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>G :Git<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gb :Git blame<cr>

"nnoremap <silent> K :lua vim.lsp.buf.hover()<cr>
"nnoremap <leader>lr :lua vim.lsp.buf.rename()<cr>
"nnoremap <silent> gD :lua vim.lsp.buf.declaration()<cr>
"nnoremap <silent> gd :lua vim.lsp.buf.definition()<cr>
"nnoremap <leader>li :lua vim.lsp.buf.implementation()<cr>
"nnoremap gr :lua vim.lsp.buf.references()<cr>
