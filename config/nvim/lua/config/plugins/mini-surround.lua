return {
	'echasnovski/mini.surround',
	version = '*',
	config = function()
		require('mini.surround').setup({
			highlight_duration = 1000,
		})
	end
}
