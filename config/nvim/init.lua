require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.clipboard = "unnamedplus"

-- Absolute numbering in INSERT, relative numbers in everything else
--
-- vim.opt.number = true
-- vim.opt.relativenumber = true
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
	{
		group = numbertoggle,
		callback = function()
			if vim.opt.number:get() and vim.api.nvim_get_mode() ~= "i" then
				vim.opt.relativenumber = true
			end
		end,
	}
)
vim.api.nvim_create_autocmd(
	{ "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
	{
		group = numbertoggle,
		callback = function()
			if vim.opt.number:get() then
				vim.opt.relativenumber = false
				vim.cmd("redraw")
			end
		end,
	}
)

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
-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = "" -- this syntaxhighlights the line and not just one color
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 8
vim.opt.foldnestmax = 8

-- better keymaps
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source current selection" })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "jk as <ESC> key" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- resize windows
vim.keymap.set("n", "<M-Up>", ":resize -5<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<M-Down>", ":resize +5<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<M-Left>", ":vertical resize -5<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<M-Right>", ":vertical resize +5<CR>", { desc = "Resize window right" })

-- quickfix list
-- local function is_quickfix_open()
-- 	for _, win in ipairs(vim.fn.getwininfo()) do
-- 		if win.quickfix == 1 then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
--
-- local function qf_next()
-- 	if is_quickfix_open() then
-- 		vim.cmd("cnext")
-- 	else
-- 		vim.notify("Quickfix not open")
-- 	end
-- end
--
-- local function qf_prev()
-- 	if is_quickfix_open() then
-- 		":cprev<CR>"
-- 	else
-- 		vim.notify("Quickfix not open")
-- 	end
-- end
--
-- vim.keymap.set("n", "<C-j>", ":cnext<CR>", { desc = "Next quickfix list item" })
-- vim.keymap.set("n", "<C-k>", ":cprev<CR>", { desc = "Previous quickfix list item" })
-- vim.keymap.set("n", "<C-j>", function() qf_next() end, { desc = "Next quickfix list item" })
-- vim.keymap.set("n", "<C-k>", function() qf_prev() end, { desc = "Previous quickfix list item" })

vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'diagnostic float' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'diagnostics list' })

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
