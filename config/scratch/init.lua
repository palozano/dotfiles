require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
-- vim.opt.colorcolumn = '120'
vim.opt.cmdheight = 2
vim.opt.confirm = true

-- keymaps
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source current selection" })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "jk as <ESC> key" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- faster resize windows
vim.keymap.set("n", "<M-Up>", ":resize -5<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<M-Down>", ":resize +5<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<M-Left>", ":vertical resize -5<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<M-Right>", ":vertical resize +5<CR>", { desc = "Resize window right" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
