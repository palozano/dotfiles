-- Know what you did
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = '[u]ndotree (toggle)' })

return {
  'mbbill/undotree',
}
