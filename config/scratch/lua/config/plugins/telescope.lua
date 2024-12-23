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
			set('n', '<leader>.', builtin.oldfiles, { desc = 'Telescope oldfiles' })
			set('n', '<leader>,', builtin.buffers, { desc = 'Telescope existing buffers' })
			set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope keymaps" })

			-- search the config files from everywhere
			set('n', '<leader>en', function()
				local opts = require('telescope.themes').get_ivy({
					cwd = vim.fn.stdpath('config')
				})
				builtin.find_files(opts)
			end, { desc = "Edit neovim config" })

			-- search the packages from everywhere
			set('n', '<leader>ep', function()
				builtin.find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				}
			end, { desc = "Edit neovim packages" })

			require "config.telescope.multigrep".setup()
		end
	},
}
