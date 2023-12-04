-- From rust.vim plugin, you can run individual tests
vim.keymap.set('n', '<leader>cc', ':RustTest<CR>', { desc = "Run test under cursor" })
vim.keymap.set('n', '<leader>cn', ':RustTest -- --nocapture<CR>',
  { desc = "Run test under cursor with --nocapture" })

return {
  'rust-lang/rust.vim',
  version = '*',
  -- opts = function()
  --   return {
  --     rustfmt_command = "cargo +nightly-2023-09-05 fmt --all",
  --     rustfmt_command = "/Users/palozano/.rustup/toolchains/nightly-2023-09-05-aarch64-apple-darwin/bin/rustfmt",
  --   }
  -- end,
}
