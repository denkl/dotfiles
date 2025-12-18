local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end},
    })
    local languages = {
        "go",
        "markdown_inline",
        "python",
        "query",
        "terraform",
    }
    local isnt_installed = function(lang)
        return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
    end
    local to_install = vim.tbl_filter(isnt_installed, languages)
    if #to_install > 0 then require('nvim-treesitter').install(to_install) end

    -- Enable tree-sitter after opening a file for a target language
    local filetypes = {}
    for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            table.insert(filetypes, ft)
        end
    end
    local ts_start = function(ev) vim.treesitter.start(ev.buf) end
    vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = ts_start,
        desc = 'Start tree-sitter'
    })
end)

later(function()
    add('neovim/nvim-lspconfig')

    vim.lsp.enable('gopls')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('ruff')
    vim.lsp.enable('terraformls')
    vim.lsp.enable('ty')
end)
