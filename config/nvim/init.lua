--[[

Based on kickstart.nvim, which is *not* a distribution.
Read through a guide: https://learnxinyminutes.com/docs/lua/
Then you can explore or search through `:help lua-guide`.

--]]


-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Yet another package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--  a s they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = true },
    },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Types in the way
      -- {
      --   'simrat39/inlay-hints.nvim',
      --   config = function()
      --     require('inlay-hints').setup()
      --   end,
      -- }
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp s ource
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {}
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[g]o to [p]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
          { buffer = bufnr, desc = '[g]o to [n]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[p]review [h]unk' })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { "" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1, -- 2 = full path, 1 = relative path, 0 = filename only
          },
        },
        lualine_x = { "diagnostics" },
        lualine_y = { "filesize" },
        lualine_z = {},
      },
    },
  },

  --{
  --  -- See `:help indent_blankline.txt`
  --  -- Add indentation guides even on blank lines
  --  'lukas-reineke/indent-blankline.nvim',
  --  main = "ibl",
  --  opts = {
  --  },
  --},

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your heovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  --
  -- require 'plugins.autoformat',
  -- require 'plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'plugins' },
  { import = 'keymaps' },
}, {})

-- [[ Settings options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Show the current line
vim.o.cursorline = true

-- Some scroll off when moving around
vim.o.scrolloff = 3

-- Sometimes this is handy
-- vim.o.colorcolumn = '120'

-- Make it a bit taller
vim.o.cmdheight = 2

-- Confirm certain things
vim.o.confirm = true

-- Configure the undo tree
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SplitWidth = 40
vim.g.undotree_DiffpanelHeight = 20


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- NOTE: Really do see `:help telescope` and `:help telescope.setup()`,
-- all the info you need is there.
require('telescope').setup {
  defaults = {
    sorting_strategy = 'descending',
    layout_strategy = 'center',
    layout_config = {
      anchor = 'S',
      prompt_position = 'bottom',
      width = 0.8,
      height = 0.25,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'bash', 'c', 'lua', 'rust',
    'vimdoc', 'vim', 'html', 'http', 'css',
    'json', 'yaml', 'toml',
    -- 'elixir', 'python', 'go'
  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>ta'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>tA'] = '@parameter.inner',
      },
    },
  },
}

-- -- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[g]o to [d]efinition')
--   nmap('gD', vim.lsp.buf.declaration, '[g]o to [D]eclaration')
--   nmap('gr', require('telescope.builtin').lsp_references, '[g]o to [r]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[g]o to [I]mplementation')
--   nmap('gT', vim.lsp.buf.type_definition, '[g]o to [T]ype definition')
--   nmap('<leader>sD', require('telescope.builtin').lsp_document_symbols, 'search [D]ocument symbols')
--   nmap('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'search [W]orkspace symbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('<leader>wfa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [f]older [a]dd')
--   nmap('<leader>wfr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [f]older [r]emove ')
--   nmap('<leader>wfl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[w]orkspace [f]olders [l]ist')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {
  --   ['rust-analyzer'] = {
  --     checkOnSave = {
  --       -- command = "+nightly-2023-09-05 fmt --all",
  --       command = "+nightly-2023-09-05 clippy",
  --       command = "clippy",
  --     },
  --     -- cargo = {
  --     --   loadOutDirsFromCheck = true,
  --     -- },
  --     -- procMacro = {
  --     --   enable = true,
  --     -- },
  --   },
  -- },
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true }
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  -- installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'crates' }
  },
}


-- Magit for vim
-- For more, see: https://github.com/NeogitOrg/neogit
local neogit = require('neogit')
neogit.setup {}


-- Nice rusty tools
-- require('rust-tools').setup {
--   tools = {
--     autoSetHints = true,
--
--     runnables = {
--       use_telescope = true,
--     },
--
--     debuggables = {
--       use_telescope = true,
--     },
--
--     -- how to execute terminal commands; options right now: termopen / quickfix
--     executor = require("rust-tools/executors").quickfix,
--
--     -- callback to execute once rust-analyzer is done initializing the workspace
--     -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
--     on_initialized = nil,
--
--     -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
--     reload_workspace_from_cargo_toml = true,
--
--     -- These apply to the default RustSetInlayHints command
--     inlay_hints = {
--       -- automatically set inlay hints (type hints); default: true
--       auto = true,
--       -- Only show inlay hints for the current line
--       only_current_line = false,
--       -- whether to show parameter hints with the inlay hints or not; default: true
--       show_parameter_hints = true,
--       -- prefix for parameter hints; default: "<-"
--       parameter_hints_prefix = "<- ",
--       -- prefix for all the other hints (type, chaining); default: "=>"
--       other_hints_prefix = "=> ",
--       -- whether to align to the lenght of the longest line in the file
--       max_len_align = false,
--       -- padding from the left if max_len_align is true
--       max_len_align_padding = 1,
--       -- whether to align to the extreme right or not
--       right_align = false,
--       -- padding from the right if right_align is true
--       right_align_padding = 7,
--       -- The color of the hints
--       highlight = "Comment",
--     },
--
--     -- options same as lsp hover / vim.lsp.util.open_floating_preview()
--     hover_actions = {
--
--       -- the border that is used for the hover window
--       -- see vim.api.nvim_open_win()
--       border = {
--         { "╭", "FloatBorder" },
--         { "─", "FloatBorder" },
--         { "╮", "FloatBorder" },
--         { "│", "FloatBorder" },
--         { "╯", "FloatBorder" },
--         { "─", "FloatBorder" },
--         { "╰", "FloatBorder" },
--         { "│", "FloatBorder" },
--       },
--
--       -- whether the hover action window gets automatically focused; default: false
--       auto_focus = false,
--     },
--
--     server = {
--       -- on_attach = function(_, bufnr)
--       -- on_attach(_, bufnr)
--       -- -- Hover actions
--       -- vim.keymap.set('n', '<M-space>', '<cmd>:RustHoverActions<CR>', { buffer = bufnr })
--       -- -- Code action groups
--       -- vim.keymap.set('n', '<leader>cA', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = bufnr })
--       -- end,
--
--       -- standalone file support; setting it to false may improve startup time
--       standalone = true,
--       settings = {
--         ["rust-analyzer"] = {
--           imports = {
--             granularity = {
--               group = "module",
--             },
--             prefix = "self",
--           },
--           cargo = {
--             buildScripts = {
--               enable = true,
--             },
--           },
--           procMacro = {
--             enable = true,
--           },
--           checkOnSave = {
--             command = "clippy",
--           },
--         },
--       },
--
--       -- debugging
--       -- dap = { },
--     },
--   }
-- }

-- all the mini.nvim plugins require activation
require('mini.cursorword').setup()
require('mini.surround').setup()
require('mini.trailspace').setup()
require('mini.ai').setup()

-- indent blank line
-- require("ibl").setup()

-- Toggle inlay hints
if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>ih',
    function() vim.lsp.inlay_hint.enable(0, not (vim.lsp.inlay_hint.is_enabled(0))) end,
    { desc = '[i]nlay [h]int toggle' })
end



-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
