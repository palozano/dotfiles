vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')

return {
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      -- theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_a = { "" },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        {
          "filename",
          file_status = true,
          path = 1, -- 2 = full path, 1 = relative path, 0 = filename only
        },
      },
      lualine_x = {
        { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
      },
      lualine_y = { "diagnostics", "filesize" },
      lualine_z = {},
    },
  },
}
