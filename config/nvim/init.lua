require("config.lazy")

local opt = vim.opt
--
opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 2
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.hlsearch = false
opt.mouse = 'a'
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 500
opt.completeopt = 'menuone,noselect'
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 5
-- vim.opt.colorcolumn = '120'
opt.cmdheight = 2
opt.confirm = true
-- folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldcolumn = "0"
opt.foldtext = "" -- this syntaxhighlights the line and not just one color
opt.foldlevel = 99
opt.foldlevelstart = 8
opt.foldnestmax = 8

opt.conceallevel = 1


local set = vim.keymap.set
-- better keymaps
set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "jk as <ESC> key" })
set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- lua development
set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
set("n", "<space><space>X", ":.lua<CR>", { desc = "Source current line" })
set("v", "<space><space>X", ":lua<CR>", { desc = "Source current selection" })

-- resize windows
set("n", "<M-Up>", ":resize -5<CR>", { desc = "Resize window up" })
set("n", "<M-Down>", ":resize +5<CR>", { desc = "Resize window down" })
set("n", "<M-Left>", ":vertical resize -5<CR>", { desc = "Resize window left" })
set("n", "<M-Right>", ":vertical resize +5<CR>", { desc = "Resize window right" })

-- quickfix list
set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })
set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })

-- diagnostics
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic message' })
-- removed in favour of <C-w><C-d> or <C-w>d
-- vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'diagnostic float' })
-- remove in favour of trouble's diagnostics
-- vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'diagnostics list' })

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
