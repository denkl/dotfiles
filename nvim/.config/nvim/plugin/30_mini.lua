local now, later = Config.now, Config.later

now(function() require('mini.icons').setup() end)

now(function()
    require('mini.statusline').setup({
        use_icons = true,
    })
end)

now(function()
    require('mini.hues').setup({
        background = '#151515',
        foreground = '#e1e1e1',
        saturation = 'lowmedium',
    })
end)

now(function()
    require('mini.notify').setup()
    vim.notify = MiniNotify.make_notify()
end)

later(function()
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        { mode = 'i', keys = '<C-x>' },

        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        { mode = 'n', keys = '<C-w>' },

        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        -- mini.bracketed
        { mode = 'n', keys = "[" },
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = "[" },
        { mode = 'x', keys = ']' },
      },

      clues = {
        Config.leader_group_clues,
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })
end)

later(function()
    local minipick = require('mini.pick')

    local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
            anchor = 'NW', height = height, width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end

    minipick.setup(
      { window = { config = win_config } }
    )
    MiniPick.registry.files = function(local_opts)
        local opts = { source = { cwd = local_opts.cwd } }
        local_opts.cwd = nil
        return MiniPick.builtin.files(local_opts, opts)
    end
end)

later(function() require('mini.operators').setup({
    replace = { prefix = 'gX' }
}) end)

local gen_loader = require('mini.snippets').gen_loader
later(function()
    require('mini.snippets').setup({
      snippets = {
        gen_loader.from_lang(),
      },
    })
end)

later(function() require('mini.files').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.completion').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.ai').setup() end)
later(function() require('mini.misc').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.move').setup() end)
later(function() require('mini.cmdline').setup() end)
later(function() require('mini.input').setup() end)
