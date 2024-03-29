-- make it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- preserve cursor position on join lines
vim.keymap.set("n", "J", "mzJ`z")

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

-- window mappings
vim.keymap.set("n", "<leader>w", "<c-w>w")
vim.keymap.set("n", "<leader>q", "<cmd>close<cr>")

-- buffer mappings
vim.keymap.set("n", "]b", "<cmd>bnext<cr>zz")
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>zz")
