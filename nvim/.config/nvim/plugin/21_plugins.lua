local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        checkout = 'master',
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end},
    })
    -- add('nvim-treesitter/nvim-treesitter-textobjects')
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "terraform", "go" },
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
        },
    }
end)

later(function()
    add('williamboman/mason.nvim')
    require('mason').setup()
end)

later(function()
    add('neovim/nvim-lspconfig')

    vim.lsp.enable('lua_ls')
    vim.lsp.enable('gopls')
    vim.lsp.enable('basedpyright')
    vim.lsp.enable('ruff')
    vim.lsp.enable('clangd')
    vim.lsp.enable('terraformls')
end)
