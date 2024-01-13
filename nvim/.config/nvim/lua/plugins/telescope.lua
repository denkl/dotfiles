return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind [f]iles" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[f]ind [g]it files" })
            vim.keymap.set("n", "<leader>fp", builtin.oldfiles, { desc = "[f]ind [p]reviously open files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[f]ind [h]elp" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[f]ind [k]eymaps" })
            vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[f]ind [c]ommands" })
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[f]ind current [w]ord" })
            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "fuzzy find in current buffer" })
            vim.keymap.set("n", "<leader><leader>", builtin.live_grep, { desc = "search for a string live" })
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    }
}
