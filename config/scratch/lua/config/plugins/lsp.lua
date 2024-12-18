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
			{ 'sagen/blink.cmp' },
		},
		opts = {
			servers = {
				lua_ls = {},
				rust_analyzer = {
					diagnostics = {
						enable = true,
					}
				},
			}
		},
		config = function(_, opts)
			local set = vim.keymap.set 

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
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					if client.supports_method('textDocument/formatting') then
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end,
			})

			if vim.lsp.inlay_hint then
				set('n', '<leader>ih',
					function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "Inlay hints" })
			end

			set("n", "<leader>F", function() vim.lsp.buf.format() end, { desc = "Format the current file" })

			set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })


			set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
			set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
			set('n', 'gI', function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
			set('n', 'gT', function() vim.lsp.buf.type_definition() end, { desc = "Go to type" })
			set('n', "gW", function() vim.lsp.buf.workspace_symbol() end, { desc = "Go to workspace symbols" })
			set("n", "g0", function() vim.lsp.buf.document_symbol() end, { desc = "Go to document symbol" })
		end,
	}
}
