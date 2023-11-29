return {
  -- [[ Basic Keymaps ]]
  -- Exit the lazy way
  vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "jk as <ESC> key" }),
  vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" }),

  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }),
  vim.keymap.set({ 'i' }, 'jk', '<Esc>', { silent = true }),

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }),
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }),

  -- Oil for the machine's folders (file browser)
  -- NOTE: `open_float` does not let you open preview with C-p, so now we use `open` and C-c to close Oil.
  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" }),

  -- [[ g ]]
  --
  -- go to definition and declaration
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to [d]efinition" }),
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to [D]eclaration" }),
  -- open definition in split (horizontal and vertical)
  -- vim.keymap.set("n", "gHd", ":split<CR>gd",
  --   { noremap = true, silent = true, desc = "[g]o to, in [H]orizontal split, to the [d]efinition" }),
  -- vim.keymap.set("n", "gVd", ":vsplit<CR>gd",
  --   { noremap = true, silent = true, desc = "[g]o to, in [V]ertical split, to the [d]efinition" }),
  -- vim.keymap.set("n", "gHD", ":split<CR>gd",
  --   { noremap = true, silent = true, desc = "[g]o to, in [H]orizontal split, to the [D]eclaration" }),
  -- vim.keymap.set("n", "gVD", ":vsplit<CR>gd",
  --   { noremap = true, silent = true, desc = "[g]o to, in [V]ertical split, to the [D]eclaration" }),

  -- [[ s ]]
  --
  vim.keymap.set('n', '<leader>sG', require('telescope.builtin').git_files, { desc = '[s]earch [G]it files' }),
  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' }),
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' }),
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' }),
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' }),
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' }),
  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>.', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' }),
  vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' }), -- space space
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' }),
  -- Custom plugin to grep and replace
  vim.keymap.set('n', '<leader>sV', function() require('handmade.quicklist').vimgrep_ui() end,
    { desc = '[s]earch with [V]imgrep' }),
  vim.keymap.set('n', '<leader>sR',
    function() require('handmade.quicklist').replace_in_quickfix_list() end,
    { desc = 'in quickfix list [s]earch, replace' }),
  -- Search across branches
  vim.keymap.set('n', '<leader>sB', function() require('handmade.git').grep_in_vim() end,
    { desc = "[s]earch across all git [B]ranches" }),
  -- Structural search and replace: https://github.com/cshuaimin/ssr.nvim
  vim.keymap.set({ "n", "x" }, "<leader>ssr", function() require("ssr").open() end,
    { desc = '[s]tructural [s]earch and [r]eplace' }),

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' }),
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' }),
  vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [d]iagnostic [f]loating message' }),
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostics [l]ist' }),

  -- Code actions
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' }),

  -- Git porcelain, kind of
  vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit' }),

  -- Format the current buffer
  vim.keymap.set('n', '<leader>bf', function() vim.lsp.buf.format({ async = true }) end,
    { desc = '[b]uffer: [f]ormat the current buffer' }),

  -- You can load your handmade plugins in here too!
  vim.keymap.set('n', '<leader>tt', function() require('handmade.todolist').todolist() end,
    { desc = 'Open [t]odolist' }),

  -- Clever jumps. Check for more: https://github.com/phaazon/hop.nvim
  vim.keymap.set('n', '<leader>f', function()
    require('hop').hint_words({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })
  end, { remap = true, desc = '[f]: Hop (forwards) to any word' }),
  vim.keymap.set('n', '<leader>F', function()
    require('hop').hint_words({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })
  end, { remap = true, desc = '[F]: Hop (backwards) to any word' }),

  -- Know what you did
  vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = '[u]ndotree (toggle)' }),

  -- Show file at commit
  vim.keymap.set('n', '<leader>gs', function() require('handmade.git').git_show_file_at_commit() end,
    { desc = "[s]how commit at revision" }),

  -- Open/Close the quickfix list
  vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = '[q]uickfix: [o]pen' }),
  vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = '[q]uickfix: [c]lose' }),
  vim.keymap.set('n', '<leader>qx', function() require('handmade.quicklist').command_to_execute_in_quickfix_list() end,
    { desc = '[q]uickfix: e[x]ecute...' }),

  -- Merge tool
  vim.keymap.set('n', '<leader>mt', function() require('handmade.mergetool').select_revision_or_commit() end,
    { desc = '[m]erge [t]ool' }),

  -- Ported keymaps from init.lua file
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[r]e[n]ame' }),
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' }),

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[g]o to [d]efinition' }),
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[g]o to [D]eclaration' }),
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[g]o to [r]eferences' }),
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[g]o to [I]mplementation' }),
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { desc = '[g]o to [T]ype definition' }),
  vim.keymap.set('n', '<leader>sD', require('telescope.builtin').lsp_document_symbols,
    { desc = 'search [D]ocument symbols' }),
  vim.keymap.set('n', '<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = 'search [W]orkspace symbols' }),

  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' }),
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' }),

  -- Lesser used LSP functionality
  vim.keymap.set('n', '<leader>wfa', vim.lsp.buf.add_workspace_folder, { desc = '[w]orkspace [f]older [a]dd' }),
  vim.keymap.set('n', '<leader>wfr', vim.lsp.buf.remove_workspace_folder, { desc = '[w]orkspace [f]older [r]emove ' }),
  vim.keymap.set('n', '<leader>wfl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = '[w]orkspace [f]olders [l]ist' }),
  --

  -- From rust.vim plugin, you can run individual tests
  vim.keymap.set('n', '<leader>cc', ':RustTest<CR>', { desc = "Run test under cursor" }),
  vim.keymap.set('n', '<leader>cn', ':RustTest -- --nocapture<CR>',
    { desc = "Run test under cursor with --nocapture" }),

  -- from here: https://sharksforarms.dev/posts/neovim-rust/
  vim.keymap.set('n', "gW", vim.lsp.buf.workspace_symbol, { desc = "[W]orkspace symbol" }),
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "Document symbol" }),

  -- faster resize windows
  vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { desc = "Resize window up" }),
  vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { desc = "Resize window down" }),
  vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" }),
  vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" }),

  -- crates.nvim

  vim.keymap.set('n', '<leader>ct', require('crates').toggle, { silent = true, desc = 'Toggle crates' }),
  vim.keymap.set('n', '<leader>cr', require('crates').reload, { silent = true, desc = 'Reload crates' }),

  vim.keymap.set('n', '<leader>cv', require('crates').show_versions_popup,
    { silent = true, desc = 'Show versions popup' }),
  vim.keymap.set('n', '<leader>cf', require('crates').show_features_popup,
    { silent = true, desc = 'Show features popup' }),
  vim.keymap.set('n', '<leader>cd', require('crates').show_dependencies_popup,
    { silent = true, desc = 'Show dependencies popup' }),

  vim.keymap.set('n', '<leader>cu', require('crates').update_crate, { silent = true, desc = 'Update crate' }),
  vim.keymap.set('v', '<leader>cu', require('crates').update_crates, { silent = true, desc = 'Update crates' }),
  vim.keymap.set('n', '<leader>ca', require('crates').update_all_crates, { silent = true, desc = 'Update all crates' }),
  vim.keymap.set('n', '<leader>cU', require('crates').upgrade_crate, { silent = true, desc = 'Upgrade crate' }),
  vim.keymap.set('v', '<leader>cU', require('crates').upgrade_crates, { silent = true, desc = 'Upgrade crates' }),
  vim.keymap.set('n', '<leader>cA', require('crates').upgrade_all_crates, { silent = true, desc = 'Upgrade all crates' }),
  vim.keymap.set('n', '<leader>ce', require('crates').expand_plain_crate_to_inline_table,
    { silent = true, desc = 'Expand plain crate to inline table' }),
  vim.keymap.set('n', '<leader>cE', require('crates').extract_crate_into_table,
    { silent = true, desc = 'Extract crate into table' }),

  vim.keymap.set('n', '<leader>cH', require('crates').open_homepage, { silent = true, desc = 'Open homepage' }),
  vim.keymap.set('n', '<leader>cR', require('crates').open_repository, { silent = true, desc = 'Open repository' }),
  vim.keymap.set('n', '<leader>cD', require('crates').open_documentation,
    { silent = true, desc = 'Open documentation' }),
  vim.keymap.set('n', '<leader>cC', require('crates').open_crates_io, { silent = true, desc = 'Open crates.io' }),
}
