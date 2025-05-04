vim.lsp.config.ruff = {
    root_dir = function(bufnr, cb)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true }) [1]) or require('lspconfig.util').root_pattern('pyproject.toml', 'ruff.toml', '.ruff.toml')(fname)
        return cb(root)
    end,
    settings = {
        lint = {
            preview = true
        },
        format = {
            preview = true
        },
    }
}
