return {
  {
    enabled = false,
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- rust
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust") {
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }
        }
      })

      vim.keymap.set("n", "<leader>tr", "<cmd>Neotest run<cr>", { desc = "Run the test" })
      vim.keymap.set("n", "<leader>tw", "<cmd>Neotest watch<cr>", { desc = "Watch for test changes" })
      vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary<cr>", { desc = "Tests summary" })
      vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<cr>", { desc = "Tests output" })
      vim.keymap.set("n", "<leader>tp", "<cmd>Neotest output-panel<cr>", { desc = "Tests output panel" })
    end,
  },
}
