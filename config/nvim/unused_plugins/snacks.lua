return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false },
    dashboard = {
      enabled = true,
      preset = {
        width = 100,
        header = [[
 ███▄    █  ▓█████ ▒█████   ██▒   █▓  ██▓ ███▄ ▄███▓
 ██ ▀█   █  ▓█   ▀▒██▒  ██▒▓██░   █▒▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒ ▒███  ▒██░  ██▒ ▓██  █▒░▒▒██▒▓██    ▓██░
▓██▒  ▐▌██▒ ▒▓█  ▄▒██   ██░  ▒██ █░░░░██░▒██    ▒██
▒██░   ▓██░▒░▒████░ ████▓▒░   ▒▀█░  ░░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░░ ▒░ ░ ▒░▒░▒░    ░ ▐░   ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░░ ░ ░    ░ ▒ ▒░    ░ ░░  ░ ▒ ░░  ░      ░
   ░   ░ ░     ░  ░ ░ ░ ▒        ░  ░ ▒ ░░      ░
         ░ ░   ░      ░ ░        ░    ░         ░
]]
      },
      sections = {
        -- { section = "header" },
        -- {
        --   pane = 2,
        --   section = "terminal",
        --   cmd = "colorscript -e square",
        --   height = 5,
        --   padding = 1,
        -- },
        -- { section = "keys",  gap = 1, padding = 1 },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              icon = " ",
              title = "Git Status",
              cmd = "hub --no-pager diff --stat -B -M -C",
              height = 10,
            },
            {
              title = "Notifications",
              cmd =
              "gh notify -a -s -n5  -e ci_activity -p | sed -e 's/PullRequest/PR/' -e 's/Nuffle-La//' -e 's/..//' -e 's/review_requested/review/'",
              icon = " ",
              height = 10,
              enabled = true,
            },
            {
              title = "Open Issues",
              cmd = "gh issue list -L 3",
              icon = " ",
              height = 10,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              -- pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              -- ttl = 5 * 60,
              indent = 2,
              width = 100,
            }, cmd)
          end, cmds)
        end,
        -- { section = "startup" },
      }
    },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
