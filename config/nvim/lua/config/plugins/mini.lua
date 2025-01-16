return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- improve editing experience
    require("mini.align").setup()
    require("mini.pairs").setup()
    -- require("mini.operators").setup()
    require("mini.surround").setup()
    -- improve UI
    require("mini.cursorword").setup()
  end,
}
