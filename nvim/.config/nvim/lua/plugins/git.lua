return {
    {
        "tpope/vim-fugitive",
        keys = {
            {"<leader>G", "<cmd>Git<cr>", desc = ":Git"},
            {"<leader>gl", "<cmd>Git log<cr>"},
            {"<leader>gb", "<cmd>Git blame<cr>"},
        },
    },
    "tpope/vim-rhubarb",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map({ "n", "v" }, "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "next hunk" })

                map({ "n", "v" }, "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "previous hunk" })

                map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
                map('n', '<leader>hb', function() gs.blame_line { full = false } end, { desc = 'git blame line' })
            end,
        },
    }
}
