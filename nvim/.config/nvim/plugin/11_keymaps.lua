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
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
}

local nmap_leader = function(suffix, rhs, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

-- f is fuzzy
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('f.', '<Cmd>Pick oldfiles<CR>', 'Recent')
nmap_leader('fs', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Document symbols')
nmap_leader('fl', '<Cmd>Pick buf_lines<CR>', 'Lines (all)')
nmap_leader('fP', function()
    MiniPick.builtin.files(nil, { source = { cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'site') } })
end, 'Plugins')

-- l is LSP
nmap_leader('ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Definition')
nmap_leader('lD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions')
nmap_leader('lo', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', 'Document symbol')

-- e is explore
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>', 'Quickfix')
