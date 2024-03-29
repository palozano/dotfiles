return {
  'kevinhwang91/nvim-bqf',
  config = function()
    require('bqf').setup({
      auto_enable = true,
      magic_window = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
      },
      func_map = {
        vsplit = '',
        ptogglemode = 'z,',
        stoggleup = '',
      },
      filter = {
        fzf = {
          action_for = { ['ctrl-s'] = 'split' },
          action_for = { ['ctrl-v'] = 'vsplit' },
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' },
        },
      },
    })
  end,
}
