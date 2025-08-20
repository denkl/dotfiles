-- Toggle quickfix window
Config.toggle_quickfix = function()
  local cur_tabnr = vim.fn.tabpagenr()
  for _, wininfo in ipairs(vim.fn.getwininfo()) do
    if wininfo.quickfix == 1 and wininfo.tabnr == cur_tabnr then return vim.cmd('cclose') end
  end
  vim.cmd('copen')
end

-- Copy current buffer relative filepath
Config.copy_path = function()
    local path = vim.fn.expand('%')
    vim.fn.setreg('+', path)
end
