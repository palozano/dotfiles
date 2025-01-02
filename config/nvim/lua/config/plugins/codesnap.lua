return {
	"mistricky/codesnap.nvim",
	build = "make",
	opts = {
		has_breadcrumbs = true,
		has_line_number = true,
		bg_color = "#535c68",
		bg_x_padding = 20,
		bg_y_padding = 20,
		watermark = "",
		save_path = "~/Desktop/screenshots",
	},
	-- keys = {
	-- 	{ "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "v", desc = "Snapshot the code (clipboard)" },
	-- 	{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Snapshot the code" },
	-- }
}
