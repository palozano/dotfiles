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
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-h>"] = "which_key",
						},
						n = {
							["<C-h>"] = "which_key",
						}
					},
				},
				pickers = {
					buffers = { theme = "ivy", },
					command_history = { theme = "ivy" },
					diagnostics = { theme = "ivy" },
					find_files = { theme = "ivy", },
					git_branches = { theme = "ivy", },
					git_commits = { theme = "ivy" },
					git_files = { theme = "ivy", },
					help_tags = { theme = "ivy" },
					keymaps = { theme = "ivy" },
					lsp_document_symbols = { theme = "ivy" },
					lsp_references = { theme = "ivy" },
					man_pages = { theme = "ivy" },
					marks = { theme = "ivy", },
					oldfiles = { theme = "ivy", },
					registers = { theme = "ivy" },
					search_history = { theme = "ivy" },
				},
				extensions = {
					file_browser = {
						theme = "ivy",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							["i"] = {
								-- your custom insert mode mappings
							},
							["n"] = {
								-- your custom normal mode mappings
							},
						},
					},
				},
			})
			require "config.telescope.multigrep".setup()

			local builtin = require('telescope.builtin')
			local set = vim.keymap.set

			set('n', '<leader>,', builtin.buffers, { desc = 'Telescope existing buffers' })
			set('n', '<leader>.', builtin.oldfiles, { desc = 'Telescope oldfiles' })
			set('n', '<leader>fB', builtin.git_branches, { desc = 'Telescope git branches' })
			set('n', '<leader>fC', builtin.command_history, { desc = 'Telescope command history' })
			set('n', '<leader>fG', builtin.git_files, { desc = 'Telescope git files' })
			set('n', '<leader>fH', builtin.search_history, { desc = 'Telescope search history' })
			set('n', '<leader>fM', builtin.man_pages, { desc = 'Telescope man pages' })
			set('n', '<leader>fb', function() require("telescope").extensions.file_browser.file_browser() end,
				{ desc = 'Telescope file browser' })
			set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope git commits' })
			set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
			set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope all files' })
			set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope keymaps" })
			set('n', '<leader>fm', builtin.marks, { desc = 'Telescope marks' })
			set('n', '<leader>fr', builtin.registers, { desc = 'Telescope registers' })
			set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope symbols' })
			set('n', 'gr', builtin.lsp_references, { desc = 'Telescope to references' })

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

			require('telescope').load_extension('fzf')
			require('telescope').load_extension("ui-select")
			require('telescope').load_extension("file_browser")
		end
	},
}
