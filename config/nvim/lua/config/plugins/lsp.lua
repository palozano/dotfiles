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
				ts_ls = {
					filetypes = {
						"javascript",
						"typescript",
					},
				},
				solidity_ls = {
					cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
					filetypes = { 'solidity' },
					-- root_dir = require("lspconfig").util.find_git_ancestor,
					-- single_file_support = true,
				},
			}
		},
		config = function(_, opts)
			local set = vim.keymap.set
			local lsp = vim.lsp

			-- completion with blink.cmp
			local lspconfig = require('lspconfig')
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

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

			if lsp.inlay_hint then
				set('n', '<leader>ih',
					function() lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "Inlay hints" })
			end

			set("n", "<leader>F", lsp.buf.format, { desc = "Format the current file" })
			set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symmbol" })
			set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })


			set("n", "gd", function() lsp.buf.definition() end, { desc = "Go to definition" })
			set("n", "gD", function() lsp.buf.declaration() end, { desc = "Go to declaration" })
			set('n', 'gI', function() lsp.buf.implementation() end, { desc = "Go to implementation" })
			set('n', 'gT', function() lsp.buf.type_definition() end, { desc = "Go to type" })
			set('n', "gW", function() lsp.buf.workspace_symbol() end, { desc = "Go to workspace symbols" })
			set("n", "g0", function() lsp.buf.document_symbol() end, { desc = "Go to document symbol" })
		end,
	}
}
