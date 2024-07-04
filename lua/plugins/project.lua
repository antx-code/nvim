-- 这个文件是一个 Lua 脚本，它返回一个 Lua 表（table）。这个表中包含了一些插件的配置信息，用于在 Neovim 编辑器中扩展功能。
-- 这个文件的实现逻辑如下：
  -- 首先，它定义了一个注释块，其中包含了一个名为 "airblade/vim-rooter" 的插件的配置信息。然而，这个插件的初始化函数被注释掉了，因此它不会被执行。
  -- 接下来，它引入了一个名为 "lazyvim.plugins.extras.util.project" 的模块。这个模块可能是自定义的，用于提供额外的项目相关功能。
  -- 然后，它定义了另一个注释块，其中包含了一个名为 "coffebar/neovim-project" 的插件的配置信息。这个插件定义了一些项目路径，并在初始化函数中启用了保存插件状态的功能。
  -- 然后，它定义了一个名为 "ahmedkhalf/project.nvim" 的插件的配置信息。这个插件提供了项目相关的功能，包括手动模式和自动检测项目根目录的方法。它还定义了一些检测根目录的模式，并可以排除某些目录。此外，它还配置了一些其他选项，如是否显示隐藏文件、是否静默更改目录等。
  -- 最后，它定义了一个名为 "imNel/monorepo.nvim" 的插件的配置信息。这个插件用于处理 Monorepo（多仓库）项目的功能，并在配置函数中进行了一些自定义设置。
-- 总的来说，这个文件的功能是配置一些插件，用于增强 Neovim 编辑器的项目相关功能。每个插件都有自己的配置选项和初始化函数，用于定制插件的行为和功能。

return {
  -- {
  --   "airblade/vim-rooter",
  --   init = function()
  --     vim.g.rooter_patterns = { "__vim_project_root", ".git/" }
  --     vim.g.rooter_silent_chdir = true
  --     -- set an autocmd
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       pattern = "*",
  --       callback = function()
  --         -- source .nvim.lua at project root
  --         vim.cmd([[silent! source .vim.lua]])
  --       end,
  --     })
  --   end,
  -- },
  { import = "lazyvim.plugins.extras.util.project" },
  -- {
  --   "coffebar/neovim-project",
  --   opts = {
  --     projects = {
  --       "~/git/*",
  --       "~/.config/nvim",
  --     },
  --   },
  --   init = function()
  --     -- enable saving the state of plugins in the session
  --     vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  --   end,
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
  --     { "Shatur/neovim-session-manager" },
  --   },
  --   lazy = false,
  --   priority = 100,
  -- },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    -- enabled = false,
    opts = {
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = true,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "!>packages", "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      patterns = { ".git", "Makefile", "pnpm-workspace.yaml", "yarn.lock", "pnpm-lock.yaml" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      ignore_lsp = {
        "prismals",
      },

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {},

      -- Show hidden files in telescope
      show_hidden = true,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = false,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "global",

      -- Path where project.nvim will store the project history for use in
      -- telescope
      datapath = vim.fn.stdpath("data"),
    },
  },

  {
    "imNel/monorepo.nvim",
    enabled = false,
    config = function()
      require("monorepo").setup({
        -- Your config here!
      })

      require("telescope").load_extension("monorepo")
    end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
