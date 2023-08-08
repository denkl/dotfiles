vim.g.mapleader = " "

-- bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "<leader>gp", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "[G]o to [p]revious hunk" })
                vim.keymap.set("n", "<leader>gn", require("gitsigns").next_hunk, { buffer = bufnr, desc = "[G]o to [n]ext hunk" })
                vim.keymap.set("n", "<leader>ph", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "[P]review [h]unk" })
            end,
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                component_separators = "|",
                section_separators = "",
            },
        },
    },

    "hashivim/vim-terraform",
})


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

-- remove trailing whitespaces
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e"
})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

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

-- edit/source vimrc
vim.keymap.set("n", "<leader>ce", "<cmd>edit $MYVIMRC<cr>", { desc = "vimrc [c]onfig [e]dit "})
vim.keymap.set("n", "<leader>cs", "<cmd>source $MYVIMRC<cr>", { desc = "vimrc [c]onfig [s]ource "})

-- window mappings
vim.keymap.set("n", "<leader>w", "<c-w>w")

-- buffer mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "list open buffers" })
vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>zz")
vim.keymap.set("n", "<leader>[", "<cmd>bprevious<cr>zz")
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<cr>")

-- fugitive mappings
vim.keymap.set("n", "<leader>G", "<cmd>Git<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>Git log<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")

-- telescope mappings
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind [f]iles" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[f]ind [g]it files" })
vim.keymap.set("n", "<leader>fp", builtin.oldfiles, { desc = "[f]ind [p]reviously open files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[f]ind [h]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[f]ind [k]eymaps" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[f]ind [c]ommands" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[f]ind current [w]ord" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "fuzzy find in current buffer" })
vim.keymap.set("n", "<leader><leader>", builtin.live_grep, { desc = "search for a string live" })

-- colorscheme
vim.o.background = "light"
require("gruvbox").setup({
    italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
    },
})
vim.cmd([[colorscheme gruvbox]])
