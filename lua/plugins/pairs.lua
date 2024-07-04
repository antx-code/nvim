-- 这个文件是一个 Lua 脚本，它返回一个包含多个键值对的表格。每个键值对表示一个插件及其相关配置。
-- 该脚本的实现逻辑如下：
  -- - 首先，它定义了一个包含多个插件配置的表格。
  -- - 每个插件配置都是一个包含插件名称和其他属性的表格。
  -- - 插件名称是一个字符串，表示插件的名称或路径。
  -- - 其他属性包括事件（event）、选项（opts）、是否启用（enabled）和配置函数（config）等。
  -- - 事件属性指定了触发插件功能的事件。
  -- - 选项属性是一个表格，用于配置插件的选项。
  -- - 是否启用属性指定了插件是否处于启用状态。
  -- - 配置函数是一个 Lua 函数，用于设置插件的特定配置。
-- 总体来说，该脚本的目的是为了管理多个插件及其相关配置。通过返回一个包含插件配置的表格，其他代码可以根据需要使用这些配置来加载和配置插件。

return {
  {
    "m4xshen/autoclose.nvim",
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("autoclose").setup({
        keys = {
          ["("] = { escape = false, close = true, pair = "()", disabled_filetypes = {} },
          ["["] = { escape = false, close = true, pair = "[]", disabled_filetypes = {} },
          ["{"] = { escape = false, close = true, pair = "{}", disabled_filetypes = {} },

          [">"] = { escape = true, close = false, pair = "<>", disabled_filetypes = {} },
          [")"] = { escape = true, close = false, pair = "()", disabled_filetypes = {} },
          ["]"] = { escape = true, close = false, pair = "[]", disabled_filetypes = {} },
          ["}"] = { escape = true, close = false, pair = "{}", disabled_filetypes = {} },

          ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = {} },
          ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = {} },
          ["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = {} },
        },
        options = {
          -- disabled_filetypes = require("util.ft").exclude_ft,
          disable_when_touch = false,
          touch_regex = "[%w(%[{]",
          pair_spaces = false,
          auto_indent = true,
        },
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    -- opts = {},
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "LazyFile",
    opts = {}, -- this is equalent to setup({}) function
    enabled = true,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = true,
    event = "FileType typescriptreact,javascriptreact,vue,html,xml,astro",
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },

  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    enabled = false,
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      })
    end,
  },
}
