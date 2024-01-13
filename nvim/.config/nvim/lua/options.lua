vim.g.mapleader = " "

-- precede each line with its line number
vim.wo.number = true
-- show the line number relative to the line with the cursor
vim.wo.relativenumber = true

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

-- save undo history
vim.o.undofile = true

-- ms to wait for a mapped sequence to complete
vim.o.timeoutlen = 500

-- options for Insert mode completion
vim.o.completeopt = "menuone,noselect"

