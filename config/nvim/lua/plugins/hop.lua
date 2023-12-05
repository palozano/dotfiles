-- Clever jumps. Check for more: https://github.com/phaazon/hop.nvim

return {
  'smoka7/hop.nvim',
  version = "*",
  opts = {},
  keys = {
    {
      '<leader>f',
      function()
        require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
      end,
      remap = true,
      desc = '[f]: Hop (forwards) to any word'
    },
    {
      '<leader>F',
      function()
        require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
      end,
      remap = true,
      desc = '[F]: Hop (backwards) to any word'
    }
  }
}
