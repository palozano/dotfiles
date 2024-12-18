return {
	"folke/snacks.nvim",
	enabled = false,
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		animate = { enabled = false },
		bigfile = { enabled = true },
		bufdelete = { enabled = false },
		dashboard = { enabled = true },
		debug = { enabled = false },
		dim = { enabled = false },
		git = { enabled = false },
		gitbrowse = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = false },
		notifier = { enabled = true },
		profiler = { enabled = false },
		quickfile = { enabled = true },
		rename = { enabled = false },
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		toggle = { enabled = false },
		win = { enabled = false },
		words = { enabled = true },
		zen = { enabled = false },
	},
	keys = {
		{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse",                  mode = { "n", "v" } },
		{ "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line" },
		{ "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Current File History" },
		{ "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
		{ "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
		{ "<leader>+",  function() Snacks.terminal() end,              desc = "Toggle Terminal" },
	}
}
