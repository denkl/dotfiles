local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local load = function(spec, opts)
    return function()
        opts = opts or {}
        local slash = string.find(spec, "/[^/]*$") or 0
        local name = opts.init or string.sub(spec, slash + 1)
        require(name)
        if opts.setup then require(name).setup(opts.setup) end
    end
end

now(load("opts"))
now(load("keymaps"))
now(load("autocmds"))

now(load('mini.statusline', { setup = {} }))
now(load('mini.notify', { setup = {} }))
now(load('mini.jump2d', { setup = {} }))
-- why doesn't it work without this line
vim.notify = MiniNotify.make_notify()

now(load('mini.hues', { setup = { background = '#151515', foreground = '#e1e1e1', saturation = 'lowmedium' } }))
