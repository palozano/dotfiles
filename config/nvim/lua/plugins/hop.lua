-- Clever jumps. Check for more: https://github.com/phaazon/hop.nvim
vim.keymap.set('n', '<leader>f', function()
  require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
end, { remap = true, desc = '[f]: Hop (forwards) to any word' })

vim.keymap.set('n', '<leader>F', function()
  require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
end, { remap = true, desc = '[F]: Hop (backwards) to any word' })

return {
  'smoka7/hop.nvim',
  version = "*",
  opts = {},
}
