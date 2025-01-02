return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/nvim-nio",
    "rouge8/neotest-rust",
    "jfpedroza/neotest-elixir",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust") {
          args = { "--no-capture" },
          dap_adapter = "lldb",
        },
        require("neotest-elixir") {
          args = { "--trace" },
          write_delay = 1000,
        }
      },
    })
  end
}
