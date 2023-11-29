# kickstart.nvim

forked from `nvim-lua/kickstart.nvim`


### Notes

`nvim-lua/kickstart.nvim` targets *only* the latest ['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. 
If you are experiencing issues, please make sure you have the latest versions.


## Installation

* Backup your previous configuration (if any exists)
* From a terminal cd/dir to:
  * `~/.config/nvim` (MacOS/Linux)
  * `%userprofile%\AppData\Local\nvim\` (Windows)
* run: `git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim` OR: `gh repo clone nvim-lua/kickstart.nvim`
* Run Neovim (from terminal or shortcut) and allow lazy.nvim to download files and set up the basics.
* Once the setup is complete, restart Neovim.
* **You're ready to go!**

### Additional system requirements:

- Make sure to have installed:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
- See [Windows Installation](#Windows-Installation) if you have trouble with `telescope-fzf-native`


## Configuration And Extension

* For adding plugins, there are 3 primary options:
  * Add new configuration in `lua/plugins/*` files, which will be auto sourced (using `lazy.nvim`)
  * Modify `init.lua` with additional plugins
  * Add or modify any keymaps in `lua/plugins/*`

You can also merge updates/changes from the repo back into your fork, to keep up-to-date with any changes for the default configuration.


#### Example: Adding an autopairs plugin

In the file: `lua/plugins/autopairs.lua`, add:

```lua
-- File: lua/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require("nvim-autopairs").setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
```

This will automatically install [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) and enable it on startup. 
For more information, see documentation for [lazy.nvim](https://github.com/folke/lazy.nvim).


#### Example: Adding a file tree plugin

In the file: `lua/plugins/filetree.lua`, add:

```lua
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
```

This will install the tree plugin and add the command `:Neotree` for you. 
You can explore the documentation at [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for more information.


### TODO 

- [ ] Custom language server configuration (null-ls templates)
- [ ] Theming beyond a default colorscheme necessary for LSP highlight groups


### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

