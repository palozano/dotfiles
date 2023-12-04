-- Custom plugin to grep and replace
vim.keymap.set('n', '<leader>sV', function() require('handmade.quicklist').vimgrep_ui() end,
	{ desc = '[s]earch with [V]imgrep' })
vim.keymap.set('n', '<leader>sR',
	function() require('handmade.quicklist').replace_in_quickfix_list() end,
	{ desc = 'in quickfix list [s]earch, replace' })
-- Search across branches
vim.keymap.set('n', '<leader>sB', function() require('handmade.git').grep_in_vim() end,
	{ desc = "[s]earch across all git [B]ranches" })
vim.keymap.set('n', '<leader>qx', function() require('handmade.quicklist').command_to_execute_in_quickfix_list() end,
	{ desc = '[q]uickfix: e[x]ecute...' })

local M = {}

M.vimgrep_ui = function()
	vim.ui.input({ prompt = 'Search with vimgrep (**/*) [empty cancels]: ' },
		function(search)
			-- Return early if empty
			if search == "" or search == nil then return end
			-- Use vimgrep to search the input
			vim.cmd("vimgrep /" .. search .. "/gj **/*")
			-- Open the quickfix window
			vim.cmd("copen")
		end)
end

M.replace_in_quickfix_list = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Replace [empty cancels]: " },
		function(search)
			-- Return early if empty
			if search == "" or search == nil then return end

			vim.ui.input({ prompt = "Replacing '" .. search .. "' with [empty cancels]: " },
				function(replace)
					-- Return early if empty
					if replace == "" or replace == nil then
						return
					end
					-- Replace the search with the replacement
					vim.cmd("cfdo %s/" .. search .. '/' .. replace .. "/ge | update")
				end)
		end)
end

M.command_to_execute_in_quickfix_list = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Command to do `| update` with >  :cfdo " },
		function(command)
			-- Return early if empty
			if command == "" or command == nil then return end
			vim.cmd("cfdo" .. command .. " | update")
		end)
end

return M
