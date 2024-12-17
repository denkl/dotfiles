vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- precede each line with its line number
vim.wo.number = true
-- show the line number relative to the line with the cursor
vim.wo.relativenumber = true

-- show which cursor is on
vim.o.cursorline = true

-- minimal number of screen lines to keep above and below the cursor
vim.wo.scrolloff = 5

-- number of spaces to use for each step of (auto)indent
vim.o.shiftwidth = 4
-- number of spaces to a <Tab>
vim.o.tabstop = 4
-- replace tabs with spaces
vim.o.expandtab = true

-- put the new window right of the current one
vim.o.splitright = true
-- put the new window below the current one
vim.o.splitbelow = true

-- do not wrap long lines
vim.o.wrap = false

-- change the terminal title according to the currently active buffer
vim.o.title = true

-- do not show mode message
vim.o.showmode = false

-- when searching, match case only when at least one char is upper
vim.o.ignorecase = true
vim.o.smartcase = true

-- patterns to ignore when expanding command-line completions
vim.o.wildignore = "*.pyc,node_modules,*/__pycache__/"

-- option settings for diff mode
vim.o.diffopt = "indent-heuristic,algorithm:patience"

-- always draw the signcolumn
vim.wo.signcolumn = "yes"

-- ms to wait for a mapped sequence to complete
vim.o.timeoutlen = 300

-- decrease update time
vim.o.updatetime = 250

-- options for Insert mode completion
vim.o.completeopt = "menuone,noselect"


-- make it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "g;", "g;zz")
vim.keymap.set("n", "g,", "g,zz")

-- preserve cursor position on lines join
vim.keymap.set("n", "J", "mzJ`z")

-- add blank line below cursor
vim.keymap.set("n", "<cr>", "mzo<esc>k`z")

-- undo break points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- insert inside brackets
vim.keymap.set("n", "<leader>i", "i<cr><esc>O")

-- buffer switching
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")

-- diagnostic mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})

-- remove trailing whitespaces
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e"
})
