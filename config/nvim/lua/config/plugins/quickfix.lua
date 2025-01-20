return {
  -- Errors in the quickfix list
  {
    "folke/trouble.nvim",
    opts = {},
    modes = {
      test = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },

    cmd = "Trouble",
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- TODO in the quickfix (and telescope)
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      signs = false, -- icons in the signs column
    },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Telescope TODO" },
      { "<leader>qt", "<cmd>TodoQuickFix<cr>",                             desc = "Quickfix TODO" },
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Next TODO comment" },
    },
  },

  -- better quickfix
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('bqf').setup({
        auto_enable = true,
        magic_window = true,
        auto_resize_height = false,
        previous_winid_ft_skip = false,
        preview = {
          auto_preview = false,
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
        },
        func_map = {
          vsplit = '',
          ptogglemode = 'z,',
          stoggleup = '',
        },
        filter = {
          fzf = {
            action_for = {
              ['ctrl-s'] = 'split',
              ['ctrl-v'] = 'vsplit'
            },
            extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' },
          },
        },
      })
    end,
  }
}
