return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make'
			},
		},
		config = function()
			require('telescope').load_extension('fzf')

			local builtin = require('telescope.builtin')
			local set = vim.keymap.set

			set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

			-- search the config files from everywhere
			set('n', '<leader>en', function()
				local opts = require('telescope.themes').get_ivy({
					cwd = vim.fn.stdpath('config')
				})
				builtin.find_files(opts)
			end)

			set('n', '<leader>ep', function()
				builtin.find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				}
			end)
		end
	},
}
