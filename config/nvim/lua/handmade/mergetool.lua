local M = {}

M.select_revision_or_commit = function()
	vim.ui.input({ prompt = "Provide a revision, branch or number (HEAD~X) > " },
		function(input)
			local parsed_input = parse_input(input)
			-- local number = math.floor(tonumber(value) or error())
			if parsed_input == "empty" then
				vim.cmd("DiffviewOpen")
			else
				vim.cmd("DiffviewOpen " .. parsed_input)
			end
		end)
end


function parse_input(value)
	-- Empty value, default to `empty`
	if value == "" or value == nil then return "empty" end
	-- Number, return the integer, since in Lua everything's a float
	local number = tonumber(value)
	if number ~= nil then return math.floor(number) end
	-- Revision
	return value
end

return M
