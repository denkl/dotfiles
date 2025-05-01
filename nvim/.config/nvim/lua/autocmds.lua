vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.hl.on_yank()
    end,
    desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces",
})

local start_terminal_insert = vim.schedule_wrap(function(data)
    -- Try to start terminal mode only if target terminal is current
    if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then return end
    vim.cmd('startinsert')
end)
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("TerminalInsert", {}),
    pattern = "term://*",
    callback = start_terminal_insert,
    desc = "Start builtin terminal in Insert mode",
})
