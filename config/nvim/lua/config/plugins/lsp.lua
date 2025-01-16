return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {},
        rust_analyzer = {
          diagnostics = {
            enable = true,
          }
        },
        pylsp = {},
        ts_ls = {
          filetypes = {
            "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx",
          },
        },
        solidity_ls = {
          cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
          filetypes = { 'solidity' },
          -- root_dir = require("lspconfig").util.find_git_ancestor,
          -- single_file_support = true,
        },
        emmet_language_server = {},
      }
    },
    config = function(_, opts)
      local set = vim.keymap.set
      local lsp = vim.lsp
      local lspconfig = require('lspconfig')

      -- completion with blink.cmp
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- emmet completion (e.g.: div.loader<TAB> -> <div class="loader"></div>)
      lspconfig.emmet_language_server.setup({
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        filetypes = {
          "html", "css", "less", "sass", "scss",
          "javascriptreact", "typescriptreact",
          "elixir", "heex"
        },
      })

      -- auto format on save
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      -- toggle inlay hints
      if lsp.inlay_hint then
        set('n', '<leader>ih',
          function() lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "Inlay hints" })
      end

      -- keymaps
      set("n", "<leader>F", lsp.buf.format, { desc = "Format the current file" })
      set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symmbol" })
      set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
      set('n', 'gI', function() lsp.buf.implementation() end, { desc = "Go to implementation" })
      -- default ones are:
      -- set("n", "grn", lsp.buf.rename, { desc = "Rename symmbol" })
      -- set("n", "gra", lsp.buf.code_action, { desc = "Code action" })
      -- set('n', 'gri', function() lsp.buf.implementation() end, { desc = "Go to implementation" })
      set('i', '<C-s>', function() lsp.buf.signature_help() end, { desc = "Trigger signature help" })


      set("n", "gd", function() lsp.buf.definition() end, { desc = "Go to definition" })
      set("n", "gD", function() lsp.buf.declaration() end, { desc = "Go to declaration" })
      set('n', 'gT', function() lsp.buf.type_definition() end, { desc = "Go to type" })
      set('n', "gW", function() lsp.buf.workspace_symbol() end, { desc = "Go to workspace symbols" })
      set("n", "g0", function() lsp.buf.document_symbol() end, { desc = "Go to document symbol" })
    end,
  }
}
