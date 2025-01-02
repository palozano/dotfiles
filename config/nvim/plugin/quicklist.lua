-- local vimgrep_ui = function()
-- 	vim.ui.input({ prompt = 'Search with vimgrep (**/*) [empty cancels]: ' },
-- 		function(search)
-- 			-- Return early if empty
-- 			if search == "" or search == nil then return end
-- 			-- Use vimgrep to search the input
-- 			vim.cmd("vimgrep /" .. search .. "/gj **/*")
-- 			-- Open the quickfix window
-- 			vim.cmd("copen")
-- 		end)
-- end
--
-- vim.api.nvim_create_user_command("QuickVimGrep", vimgrep_ui, {})
-- vim.keymap.set("n", "<leader>fq", vimgrep_ui, { desc = "vimgrep -> quickfix list" })

local replace_in_quickfix_list_entries = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Replace [empty cancels]: " },
		function(search)
			-- Return early if empty
			if search == "" or search == nil then return end

			vim.ui.input({ prompt = "Replacing in every file '" .. search .. "' with [empty cancels]: " },
				function(replace)
					-- Return early if empty
					if replace == "" or replace == nil then
						return
					end
					-- Replace the search with the replacement
					vim.cmd("cdo %s/" .. search .. '/' .. replace .. "/ge | update")
				end)
		end)
end

vim.api.nvim_create_user_command("QFReplace", replace_in_quickfix_list_entries, {})
vim.keymap.set("n", "<leader>qr", replace_in_quickfix_list_entries, { desc = "Replace in quickfix list entries" })

-------
-------

local replace_in_quickfix_list_files = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Replace [empty cancels]: " },
		function(search)
			-- Return early if empty
			if search == "" or search == nil then return end

			vim.ui.input({ prompt = "Replacing in every file '" .. search .. "' with [empty cancels]: " },
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

vim.api.nvim_create_user_command("QFReplaceInFile", replace_in_quickfix_list_files, {})
vim.keymap.set("n", "<leader>qR", replace_in_quickfix_list_files, { desc = "Replace in quickfix list files" })

-------
-------

local command_to_execute_in_quickfix_list_entries = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Command to do `:cdo ______ | update` -> " },
		function(command)
			-- Return early if empty
			if command == "" or command == nil then return end
			vim.cmd("cdo" .. command .. " | update")
		end)
end

vim.api.nvim_create_user_command("QFExecuteEntries", command_to_execute_in_quickfix_list_entries, {})
vim.keymap.set("n", "<leader>qx", command_to_execute_in_quickfix_list_entries,
	{ desc = "Command to execute in quickfix list entries" })

-------
-------

local command_to_execute_in_quickfix_list_files = function()
	-- Ask for the replacement of the search
	vim.ui.input({ prompt = "Command to do `:cfdo ______ | update` -> " },
		function(command)
			-- Return early if empty
			if command == "" or command == nil then return end
			vim.cmd("cfdo" .. command .. " | update")
		end)
end

vim.api.nvim_create_user_command("QFExecuteFiles", command_to_execute_in_quickfix_list_files, {})
vim.keymap.set("n", "<leader>qX", command_to_execute_in_quickfix_list_files,
	{ desc = "Command to execute in quickfix list files" })
