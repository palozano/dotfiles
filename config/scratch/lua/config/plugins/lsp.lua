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
		end
		-- config = function()
		-- 	-- autocmd's
		-- 	vim.api.nvim_create_autocmd('LspAttach', {
		-- 		callback = function(args)
		-- 			local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 			if not client then return end
		--
		-- 			if client.supports_method('textDocument/formatting') then
		-- 				vim.api.nvim_create_autocmd('BufWritePre', {
		-- 					buffer = args.buf,
		-- 					callback = function()
		-- 						vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
		-- 					end,
		-- 				})
		-- 			end
		-- 		end,
		-- 	})
		-- 	-- lsp configs
		-- 	require 'lspconfig'.lua_ls.setup {}
		-- 	require 'lspconfig'.rust_analyzer.setup {
		-- 		settings = {
		-- 			['rust-analyzer'] = {
		-- 				diagnostics = {
		-- 					enable = true,
		-- 				}
		-- 			}
		-- 		} }
		-- 	-- keymaps
		-- 	vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format() end)
		-- end
	}
}
