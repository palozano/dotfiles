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
					dialyzerEnabled = true,
					enableTestLenses = true,
				},
				on_attach = function(client, bufnr)
					vim.keymap.set("n", "<space>Efp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
					vim.keymap.set("n", "<space>Etp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
					vim.keymap.set("v", "<space>Eem", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
					-- test keymaps
					vim.keymap.set("n", "<leader>rt", "<cmd>lua vim.lsp.codelens.run()<cr>", { buffer = true, noremap = true })
				end,
			},
			projectionist = {
				enable = true
			}
		}
	end,
}
