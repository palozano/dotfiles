return {
  "stevearc/oil.nvim",
  opts = {
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    float = {
      padding = 5,
      border = "rounded",
      win_options = {
        winblend = 10,
      },
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
