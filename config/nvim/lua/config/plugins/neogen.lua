return {
	"danymat/neogen",
	version = "*",
	config = function()
		local neogen = require("neogen")
		vim.keymap.set("n", "<leader>gd", function() neogen.generate() end, { desc = "Generate documentation" })
		neogen.setup({})
	end,
}
