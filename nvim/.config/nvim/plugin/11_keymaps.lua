-- make it centered
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "g;", "g;zz")
vim.keymap.set("n", "g,", "g,zz")

-- preserve cursor position on lines join
vim.keymap.set("n", "J", "mzJ`z")

-- undo break points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- copy/paste with system clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- paste in Visual with `P` to not copy selected text
vim.keymap.set("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- normal mode in terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>a', desc = '+Action' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Fuzzy' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
}

local nmap_leader = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- f is fuzzy
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
nmap_leader('fl', '<Cmd>Pick buf_lines<CR>', 'Lines (all)')
nmap_leader('fp',function()
    MiniPick.builtin.files(nil, { source = { cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'site') } })
end, 'Plugins')
nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
nmap_leader('fs', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Document symbols')
nmap_leader('fw', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep <cword>')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('f.', '<Cmd>Pick oldfiles<CR>', 'Recent')
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')

-- l is LSP
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions')
nmap_leader('lD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration')
nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Definition')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
nmap_leader('lo', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', 'Document symbol')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

-- e is explore
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>', 'Quickfix')

-- g is git
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')
xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')

-- a is action
nmap_leader('ac', '<Cmd>close<CR>', ':close')
nmap_leader('ap', '<Cmd>lua Config.copy_path()<CR>', 'Copy buffer path')
nmap_leader('az', '<Cmd>lua MiniMisc.zoom()<CR>', 'Zoom')
