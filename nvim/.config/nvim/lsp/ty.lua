vim.lsp.config.ty = {
    root_dir = function(bufnr, cb)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        return cb(require('lspconfig.util').root_pattern('.git', 'pyproject.toml')(fname))
    end,
    settings = {
        ty = {
            diagnosticMode = 'workspace',
        },
    },
}
