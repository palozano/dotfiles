return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>op", "<cmd>OutputPanel<cr>", desc = "[O]pen/Toggle LSP out[p]ut" },
  },
  config = function()
    require("output_panel").setup()
  end,
}
