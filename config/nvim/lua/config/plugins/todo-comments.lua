return
{
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Telescope TODO" },
		{ "<leader>qt", "<cmd>TodoQuickFix<cr>",  desc = "Quickfix TODO" },
	},
}
