return {
  enabled = false,
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>S', function() require("spectre").toggle() end, { desc = "Search and replace" })
    vim.keymap.set('n', '<leader>Sw', function() require("spectre").open_visual({ select_word = true }) end,
      { desc = "Search current word" })
    vim.keymap.set('v', '<leader>Sw', function() require("spectre").open_visual() end, { desc = "Search current word" })
  end
}
