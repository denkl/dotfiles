return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            local theme = require("telescope.themes").get_dropdown()
            local picker = function(func)
                return function() func(theme) end
            end

            vim.keymap.set("n", "<leader>ff", picker(builtin.find_files), { desc = "[f]ind [f]iles" })
            vim.keymap.set("n", "<leader>fo", picker(builtin.oldfiles), { desc = "[f]ind [o]ld files" })
            vim.keymap.set("n", "<leader>fg", picker(builtin.git_files), { desc = "[f]ind [g]it files" })
            vim.keymap.set("n", "<leader>,", picker(builtin.buffers), { desc = "list open buffers" })
            vim.keymap.set("n", "<leader>/", picker(builtin.current_buffer_fuzzy_find), { desc = "fuzzy find in current buffer" })
            vim.keymap.set("n", "<leader><leader>", picker(builtin.live_grep), { desc = "live grep" })
            vim.keymap.set("n", "<leader>fw", picker(builtin.grep_string), { desc = "[f]ind [w]ord under cursor" })
            vim.keymap.set("n", "<leader>fh", picker(builtin.help_tags), { desc = "[f]ind [h]elp" })
            vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "[f]ind [c]ommand history" })
            vim.keymap.set("n", "<leader>fC", builtin.commands, { desc = "[f]ind [c]ommand" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[f]ind [k]eymaps" })
            vim.keymap.set("n", "<leader>f,", builtin.resume, { desc = "[f]ind resume" })
            vim.keymap.set("n", "<leader>fd", picker(builtin.diagnostics), { desc = "[f]ind diagnostics" })
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
