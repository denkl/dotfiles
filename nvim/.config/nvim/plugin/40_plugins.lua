local now, later = Config.now, Config.later

now(function()
    local ts_update = function() vim.cmd('TSUpdate') end
    Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

    vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

    local languages = {
        "go",
        "markdown_inline",
        "python",
        "query",
        "rust",
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
    Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

later(function()
    vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

    vim.lsp.enable('gopls')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('ruff')
    vim.lsp.enable('terraformls')
    vim.lsp.enable('ty')
    vim.lsp.enable('rust_analyzer')
end)
