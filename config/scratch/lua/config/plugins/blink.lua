return {
	'saghen/blink.cmp',
	lazy = false, -- lazy loading handled internally
	dependencies = 'rafamadriz/friendly-snippets',
	version = 'v0.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = 'default' }, -- default, super-tab, enter, or see default configuration section.
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = 'mono'
		},
		signature = { enabled = true },
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
	},
	opts_extend = { "sources.default" }
}
