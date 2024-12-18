return {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gp', require('gitsigns').nav_hunk('prev'),
        { buffer = bufnr, desc = '[g]o to [p]revious Hunk' })
      vim.keymap.set('n', '<leader>gn', require('gitsigns').nav_hunk('next'),
        { buffer = bufnr, desc = '[g]o to [n]ext Hunk' })
      vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = '[p]review [h]unk' })
    end,
  },
}
