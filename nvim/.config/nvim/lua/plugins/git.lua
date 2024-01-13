return {
    {
        "tpope/vim-fugitive",
        options = function()
            vim.keymap.set("n", "<leader>G", "<cmd>Git<cr>")
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log<cr>")
            vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
        end
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
                vim.keymap.set("n", "<leader>gp", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "[G]o to [p]revious hunk" })
                vim.keymap.set("n", "<leader>gn", require("gitsigns").next_hunk, { buffer = bufnr, desc = "[G]o to [n]ext hunk" })
                vim.keymap.set("n", "<leader>ph", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "[P]review [h]unk" })
            end,
        },
    }
}
