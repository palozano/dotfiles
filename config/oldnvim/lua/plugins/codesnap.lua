return {
  "mistricky/codesnap.nvim",
  build = "make",
  config = function()
    local codesnap = require("codesnap")
    codesnap.setup({
      has_breadcrumbs = true,
      has_line_number = true,
      bg_color = "#535c68",
      bg_x_padding = 20,
      bg_y_padding = 20,
      watermark = "",
      save_path = "~/Desktop/screenshots",
    })
  end
}
