-- Git porcelain, kind of
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit' })

return {
  'NeogitOrg/neogit',
  dependencies = 'nvim-lua/plenary.nvim'
}
