-- Know what you did

return {
  'mbbill/undotree',
  keys = {
    {
      '<leader>u',
      function() vim.cmd('UndotreeToggle') end,
      desc = '[u]ndotree (toggle)'
    }
  }
}
