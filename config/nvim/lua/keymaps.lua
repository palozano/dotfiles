return {
  -- [[ Basic Keymaps ]]
  -- See `:help vim.keymap.set()`
  --
  -- Exit the lazy way
  vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "jk as <ESC> key" }),
  vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" }),

  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }),
  vim.keymap.set({ 'i' }, 'jk', '<Esc>', { silent = true }),

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }),
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }),

  -- Better movement
  vim.keymap.set('n', "<C-u>", "<C-u>zz", { silent = true }),
  vim.keymap.set('n', "<C-d>", "<C-d>zz", { silent = true }),

  -- faster resize windows
  vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { desc = "Resize window up" }),
  vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { desc = "Resize window down" }),
  vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" }),
  vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" }),

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>.', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' }),
  vim.keymap.set('n', '<leader>,', require('telescope.builtin').buffers, { desc = '[,] Find existing buffers' }),
  vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
    { desc = '[/] Fuzzily search in current buffer' }),

  -- [[ g ]]
  --
  -- go to definition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to [d]efinition" }),
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to [D]eclaration" }),
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[g]o to [r]eferences' }),
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[g]o to [I]mplementation' }),
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { desc = '[g]o to [T]ype definition' }),
  -- from here: https://sharksforarms.dev/posts/neovim-rust/
  vim.keymap.set('n', "gW", vim.lsp.buf.workspace_symbol, { desc = "[g]o to [W]orkspace symbol" }),
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "List document symbols" }),

  -- [[ s ]]
  --
  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' }),
  vim.keymap.set('n', '<leader>sG', require('telescope.builtin').git_files, { desc = '[s]earch [G]it files' }),
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' }),
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' }),
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' }),
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' }),
  vim.keymap.set('n', '<leader>sD', require('telescope.builtin').lsp_document_symbols,
    { desc = 'search [D]ocument symbols' }),
  vim.keymap.set('n', '<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = 'search [W]orkspace symbols' }),

  -- [[ d ]]    Diagnostic keymaps
  --
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' }),
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' }),
  vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [d]iagnostic [f]loating message' }),
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostics [l]ist' }),

  -- Code actions
  --
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' }),

  -- Format the current buffer
  --
  vim.keymap.set('n', '<leader>bf', function() vim.lsp.buf.format({ async = true }) end,
    { desc = '[b]uffer: [f]ormat the current buffer' }),

  -- Open/Close the quickfix list
  --
  vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = '[q]uickfix: [o]pen' }),
  vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = '[q]uickfix: [c]lose' }),

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[r]e[n]ame' }),
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' }),

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' }),
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' }),

  -- [[ w ]]
  --
  vim.keymap.set('n', '<leader>wfa', vim.lsp.buf.add_workspace_folder, { desc = '[w]orkspace [f]older [a]dd' }),
  vim.keymap.set('n', '<leader>wfr', vim.lsp.buf.remove_workspace_folder, { desc = '[w]orkspace [f]older [r]emove ' }),
  vim.keymap.set('n', '<leader>wfl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = '[w]orkspace [f]olders [l]ist' }),


  -- [[ Other keymaps ]]
  -- NOTE: `open_float` does not let you open preview with C-p, so now we use `open` and C-c to close Oil.
  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" }),

  -- NOTE: I cannot put this inside the individual plugin file, don't know why. (Maybe lazy loading or something?)
  vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end, { desc = '[t]est neares[t]' }),
  vim.keymap.set('n', '<leader>tT', function() require('neotest').run.run(vim.fn.expand('%')) end,
    { desc = '[t]est all [T]est' }),
  vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run_last() end, { desc = '[t]est p[r]evious' }),

  -- NOTE: I don't know where this comes from
  vim.keymap.set('n', '<leader>qt', ':TodoQuickFix<CR>', { desc = '[q]uickfix list: open the [t]odo items' }),

  -- [[ lua/handmade/quicklist.lua ]]
  vim.keymap.set('n', '<leader>sv', function() require('handmade.quicklist').vimgrep_ui() end,
    { desc = '[s]earch with [v]imgrep' }),

  vim.keymap.set('n', '<leader>qr',
    function() require('handmade.quicklist').replace_in_quickfix_list() end,
    { desc = "[q]uickfix-list's [r]eplace" }),

  vim.keymap.set('n', '<leader>sb', function() require('handmade.git').grep_in_vim() end,
    { desc = "[s]earch across all git [b]ranches" }),

  vim.keymap.set('n', '<leader>qx', function() require('handmade.quicklist').command_to_execute_in_quickfix_list() end,
    { desc = '[q]uickfix: e[x]ecute...' }),
}
