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
vim.o.timeoutlen = 500

-- decrease update time
vim.o.updatetime = 250

-- options for Insert mode completion
vim.o.completeopt = "menuone,noselect"

-- indent wrapped lines when wrap is set
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true


-- clear highlight on <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- make it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "g;", "g;zz")
vim.keymap.set("n", "g,", "g,zz")

-- preserve cursor position on lines join
vim.keymap.set("n", "J", "mzJ`z")

-- add empty line above/below cursor
-- TODO: remove once 0.11 released
vim.keymap.set("n", "[<leader>", "mzO<esc>k`z")
vim.keymap.set("n", "]<leader>", "mzo<esc>k`z")

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

-- diagnostic mappings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TODO: remove once 0.11 released
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Re[n]ame symbol references' })
vim.keymap.set({'n', 'v'}, 'gra', vim.lsp.buf.code_action, { desc = 'Code [a]ction' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'List symbol [r]eferences' })
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'List [i]mplementations' })
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'List [s]ymbols' })
vim.keymap.set('i', '<c-S>', vim.lsp.buf.signature_help, {})

-- normal mode in terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')


-- highlight on yanking
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


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            "aktersnurra/no-clown-fiesta.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                local plugin = require "no-clown-fiesta"
                plugin.setup({
                    styles = {
                        type = { bold = false },
                        lsp = { underline = false },
                        match_paren = { underline = true },
                    }
                })
                return plugin.load()
            end
        },
        {
            'echasnovski/mini.nvim',
            version = '*',
            config = function()
                require('mini.statusline').setup { use_icons = true }
                require('mini.bracketed').setup {}
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require'nvim-treesitter.configs'.setup {
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },
                    auto_install = false,
                    highlight = {
                        enable = true,
                        disable = function(lang, buf)
                            local max_filesize = 100 * 1024 -- 100 KB
                            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                            if ok and stats and stats.size > max_filesize then
                                return true
                            end
                        end,
                        additional_vim_regex_highlighting = false,
                    },
                }
            end
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { 'williamboman/mason.nvim', config = true },
                'williamboman/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                { 'j-hui/fidget.nvim', opts = {} },
                --'hrsh7th/cmp-nvim-lsp',
                {
                    "folke/lazydev.nvim",
                    ft = "lua",
                    opts = {
                        library = {
                            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                    },
                },
                'saghen/blink.cmp',
            },
            opts = {
                servers = {
                    lua_ls = {},
                    basedpyright = {
                        root_dir = function(fname)
                            return require('lspconfig.util').root_pattern({ '.git', 'pyproject.toml'})(fname)
                        end,
                        settings = {
                            basedpyright = {
                                analysis = {
                                    diagnosticMode = "openFilesOnly",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                    typeCheckingMode = "off",
                                },
                            }
                        }
                    }
                }
            },
            config = function(_, opts)
                local lspconfig = require('lspconfig')
                for server, config in pairs(opts.servers) do
                    config.capabilities = require('blink.cmp').get_lsp_capabilities()
                    lspconfig[server].setup(config)
                end

                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('denkl-lsp-attach', { clear = true }),
                    callback = function(event)
                        local map = function(keys, func, desc, mode)
                            mode = mode or 'n'
                            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc})
                        end
                        local builtin = require "telescope.builtin"

                        map('gd', builtin.lsp_definitions, '[G]o to [D]efinition')
                        map('gI', builtin.lsp_implementations, '[G]o to [I]mplementation')
                        -- definition of *type*, not where it was *defined*
                        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
                        map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
                        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                        -- highlight references of the word under the cursor
                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            })

                            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            })

                            vim.api.nvim_create_autocmd('LspDetach', {
                                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                                callback = function(event2)
                                    vim.lsp.buf.clear_references()
                                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                                end,
                            })
                        end
                    end,
                })
            end,
        },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            },
            config = function()
                require('telescope').setup {
                    extensions = {
                        fzf = {}
                    },
                    pickers = {
                        find_files = {
                            theme = "ivy"
                        },
                        buffers = {
                            theme = "ivy"
                        },
                        help_tags = {
                            theme = "ivy"
                        },
                        live_grep = {
                            theme = "ivy"
                        },
                        diagnostics = {
                            theme = "ivy"
                        },
                        oldfiles = {
                            theme = "ivy"
                        },
                        lsp_dynamic_workspace_symbols = {
                            theme = "ivy"
                        },
                    }
                }

                local builtin = require 'telescope.builtin'

                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [f]iles' })
                vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind help' })
                vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
                vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
                vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind recent files ("." for repeat)' })

                vim.keymap.set('n', '<leader>f/', function()
                    builtin.live_grep {
                        grep_open_files = true,
                        prompt_title = 'Live Grep in Open Files',
                    }
                end, { desc = '[S]earch [/] in Open Files' })

                vim.keymap.set('n', '<leader>fD', function()
                    require('telescope.builtin').find_files {
                        cwd = '~/.dotfiles',
                        hidden = true,
                    }
                end, { desc = '[F]ind [D]otfiles' })

                vim.keymap.set('n', '<leader>fp', function()
                    require('telescope.builtin').find_files {
                        cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
                    }
                end, { desc = '[F]ind [P]lugins file' })
                vim.keymap.set('n', '<leader>fP', function()
                    require('telescope.builtin').live_grep {
                        cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
                    }
                end, { desc = '[F]ind in [P]lugins by grep' })

                require "utils.multigrep".setup()
            end
        },
        {
            'saghen/blink.cmp',
            --dependencies = 'rafamadriz/friendly-snippets',

            version = 'v0.*',

            opts = {
                keymap = { preset = 'default' },

                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono'
                },

                signature = { enabled = true }
            },
        },
        {
            "otavioschwanck/arrow.nvim",
            dependencies = {
                { "echasnovski/mini.icons" },
            },
            opts = {
                show_icons = true,
                leader_key = '|', -- Recommended to be a single key
                buffer_leader_key = 'm', -- Per Buffer Mappings
            }
        },
    },

  -- automatically check for plugin updates
  checker = { enabled = true },
})

--vim.cmd[[colorscheme habamax]]
