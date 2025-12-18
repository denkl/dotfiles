vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.breakindent = true    -- visually indent wrapped lines when wrap is set
vim.o.cursorline = true     -- show which cursor is on
vim.o.expandtab = true      -- replace tabs with spaces
vim.o.ignorecase = true     -- ignore case in search patterns
vim.o.number = true         -- precede each line with its line number
vim.o.pumheight = 10        -- smaller popup menu
vim.o.relativenumber = true -- show the line number relative to the line with the cursor
vim.o.scrolloff = 5         -- minimal number of screen lines to keep above and below the cursor
vim.o.shiftwidth = 4        -- number of spaces to use for each step of (auto)indent
vim.o.showmode = false      -- do not show mode message
vim.o.signcolumn = "yes"    -- always draw the signcolumn
vim.o.smartcase = true      -- match case only when at least one char is upper
vim.o.smartindent = true    -- make indenting smart
vim.o.splitbelow = true     -- put the new window below the current one
vim.o.splitright = true     -- put the new window right of the current one
vim.o.tabstop = 4           -- number of spaces to a <Tab>
vim.o.undofile = true       -- enable persistent undo
vim.o.virtualedit = 'block' -- allow going past the end of line in visual block mode
vim.o.winborder = 'single'  -- single-line box border style of floating windows
vim.o.wrap = false          -- do not wrap long lines
vim.o.writebackup = false   -- do not make backup before overwriting a file
vim.o.completeopt = "menuone,noselect,fuzzy,nosort" -- options for Insert mode completion

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.hl.on_yank()
    end,
    desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces",
})

local start_terminal_insert = vim.schedule_wrap(function(data)
    -- Try to start terminal mode only if target terminal is current
    if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then return end
    vim.cmd('startinsert')
end)
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("TerminalInsert", {}),
    pattern = "term://*",
    callback = start_terminal_insert,
    desc = "Start builtin terminal in Insert mode",
})

vim.diagnostic.config({
    -- display source of diagnostics
    virtual_text = { source = true, current_line = true },
    underline = false,
})
