vim.lsp.config.basedpyright = {
    root_dir = function(bufnr, cb)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return cb(require('lspconfig.util').root_pattern('.git', 'pyproject.toml')(fname))
    end,
    settings = {
        disableOrganizeImports = true,
        basedpyright = {
            analysis = {
                diagnosticMode = 'openFilesOnly',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',
            },
        },
    }
}
