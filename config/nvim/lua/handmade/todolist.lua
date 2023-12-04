-- You can load your handmade plugins in here too!
vim.keymap.set('n', '<leader>tt', function() require('handmade.todolist').todolist() end,
	{ desc = 'Open [t]odolist' })

local M = {}

M.todolist = function()
	-- TODO: add this query
	local query_fixme = '((comment) @comment (#match? @comment "FIXME"))'
	local query_todo = '((comment) @comment (#match? @comment "TODO"))'
	local parser = require('nvim-treesitter.parsers').get_parser()
	local ok, query = pcall(vim.treesitter.query.parse, parser:lang(), query_todo)
	if not ok then return end
	local tree = parser:parse()[1]
	local qf_list = {}
	for _, n in query:iter_captures(tree:root(), 0) do
		local text = vim.treesitter.get_node_text(n, 0)
		local lnum, col = n:range()
		table.insert(qf_list, {
			bufnr = vim.api.nvim_get_current_buf(),
			text = text,
			lnum = lnum + 1,
			col = col + 1,
		})
	end
	vim.fn.setqflist(qf_list)
	vim.cmd.copen()
end

function query_string()
	local parser = require('nvim-treesitter.parsers').get_parser()
	local ok, query = pcall(vim.treesitter.query.parse, parser:lang(), query_todo)
	if not ok then return end
	local tree = parser:parse()[1]
	local qf_list = {}
	for _, n in query:iter_captures(tree:root(), 0) do
		local text = vim.treesitter.get_node_text(n, 0)
		local lnum, col = n:range()
		table.insert(qf_list, {
			bufnr = vim.api.nvim_get_current_buf(),
			text = text,
			lnum = lnum + 1,
			col = col + 1,
		})
	end
	vim.fn.setqflist(qf_list)
end

return M
