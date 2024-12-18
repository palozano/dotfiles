return {
	{
		'tpope/vim-fugitive'
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				-- vim.keymap.set('n', '<leader>gp', function() require('gitsigns').nav_hunk('prev') end, { buffer = bufnr, desc = '[g]o to [p]revious Hunk' })
				-- vim.keymap.set('n', '<leader>gn', function() require('gitsigns').nav_hunk('next') end, { buffer = bufnr, desc = '[g]o to [n]ext Hunk' })
				vim.keymap.set('n', '<leader>ph', function() require('gitsigns').preview_hunk() end,
					{ buffer = bufnr, desc = '[p]review [h]unk' })
			end,
		},
	}
}
