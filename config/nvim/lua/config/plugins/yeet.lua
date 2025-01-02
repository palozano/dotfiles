return {
	"samharju/yeet.nvim",
	-- dependencies = {
	--     "stevearc/dressing.nvim", -- optional, provides sane UX
	-- },
	version = "*",
	cmd = "Yeet",
	opts = {},
	keys = {
		{
			"<leader><BS>",
			function() require("yeet").list_cmd() end,
		}
	},
}
