-- return {
--   'simrat39/rust-tools.nvim',
--   dependencies = {
--     'neovim/nvim-lspconfig',
--     'nvim-lua/plenary.nvim',
--   },
-- }


local extension_path = "/Users/palozano/.local/share/nvim/mason/packages/codelldb/extension" .. "/extension"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

return {
  "mrcjkb/rustaceanvim",
  event = "BufReadPost",
  version = "^3", -- Recommended
  -- ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      -- tools = {},
      -- LSP configuration
      server = {
        -- on_attach = function(client, bufnr)
        --   -- you can also put keymaps in here
        --   vim.lsp.inlay_hint(bufnr, true)
        -- end,
        --     settings = {
        --       -- rust-analyzer language server configuration
        --       ["rust-analyzer"] = {},
        --     },
        --   },
        -- DAP configuration
      },
      dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
    vim.keymap.set("n", "<leader>RD", "<cmd>RustLsp debuggables<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Rr", "<cmd>RustLsp runnables<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Re", "<cmd>RustLsp explainError<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Rd", "<cmd>RustLsp renderDiagnostic<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>Rc", "<cmd>RustLsp openCargo<cr>", { noremap = true, silent = true })
  end,
}
