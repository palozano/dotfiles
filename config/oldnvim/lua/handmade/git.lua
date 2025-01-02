-- Show file at commit
vim.keymap.set('n', '<leader>gs', function() require('handmade.git').git_show_file_at_commit() end,
	{ desc = "[s]how commit at revision" })

local M = {}

M.grep_in_vim = function()
	vim.ui.input({ prompt = '(git) Grep in all git branches [empty cancels] > ' },
		function(search)
			-- Return early if empty
			if search == "" or search == nil then return end
			-- Use vimgrep to search the input
			-- vim.cmd('!git grep "' .. search .. '" $(git rev-list --all)')
			vim.cmd("cexpr system('git grep " .. search .. " $(git rev-list --all)') | copen")
		end)
end

M.git_show_file_at_commit = function()
	vim.ui.input({ prompt = 'Git show (revision:file) > ' },
		function(search_term)
			-- Return early if empty
			if search_term == "" or search_term == nil then return end
			-- Use vimgrep to search the input
			vim.cmd("!git show " .. search_term)
		end)
end

return M
