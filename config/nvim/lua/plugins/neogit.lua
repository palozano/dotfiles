-- Git porcelain, kind of

return {
  'NeogitOrg/neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>gg', ':Neogit<CR>', desc = 'Open Neogit' },
  },
}
