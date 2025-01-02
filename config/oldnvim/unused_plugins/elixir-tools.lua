return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup {
      nextls = { enable = true },
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>xfp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<leader>xtp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<leader>xem", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
        end,
      },
      projectionist = {
        enable = true
      }
    }
  end,
}
