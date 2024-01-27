-- Clever jumps. Check for more: https://github.com/phaazon/hop.nvim

return {
  'smoka7/hop.nvim',
  version = "*",
  opts = {},
  keys = {
    {
      -- Previous
      -- '<leader>f',
      's',
      function()
        require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
      end,
      remap = true,
      desc = '[s]: Hop (forwards) to any word'
    },
    {
      -- Previous
      -- '<leader>F',
      'S',
      function()
        require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
      end,
      remap = true,
      desc = '[S]: Hop (backwards) to any word'
    }
  }
}
