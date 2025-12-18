vim.lsp.config.lua_ls = {
    root_markers = { '.git' },
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
}
