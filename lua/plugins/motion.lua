-- 根据提供的代码，这个文件名为 motion.lua，它似乎是一个 Lua 脚本文件。根据代码的结构和注释，可以猜测这个文件的功能是配置一个名为 flash.nvim 的插件。
-- 这个插件似乎是用于在编辑器中进行闪烁高亮的工具，可以用于快速定位和可视化文本中的特定位置。根据代码中的配置，这个插件提供了不同的模式和选项，以适应不同的使用场景。
-- 在代码中，我们可以看到一个 Lua 表（table）的定义，其中包含了多个配置项。每个配置项都是一个 Lua 表，用于配置插件的不同功能和选项。
-- 例如，代码中的 char 配置项定义了一个名为 char 的模式，用于处理字符级别的闪烁高亮。在这个模式下，可以配置自动隐藏、跳转标签、多行支持、按键映射等选项。
-- 除了模式配置外，代码还定义了一些按键映射，用于触发插件的不同功能。例如，按下 s 键可以触发 flash.nvim 的 jump 函数，而按下 S 键可以触发 flash.nvim 的 treesitter 函数。
-- 总的来说，这个文件的功能是配置 flash.nvim 插件的不同模式和选项，以及定义按键映射来触发插件的功能。通过这些配置，可以实现在编辑器中进行闪烁高亮的功能，以提高编辑效率和可视化体验。

return {
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        -- mode = "fuzzy",
      },
      label = {
        uppercase = false,
      },
      modes = {

        char = {
          enabled = true,
          -- dynamic configuration for ftFT motions
          config = function(opts)
            -- autohide flash when in operator-pending mode
            opts.autohide = vim.fn.mode(true):find("no") and vim.v.operator == "y"

            -- disable jump labels when enabled and when using a count
            opts.jump_labels = opts.jump_labels and vim.v.count == 0

            -- Show jump labels only in operator-pending mode
            -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
          end,
          -- hide after jump when not using jump labels
          autohide = false,
          -- show jump labels
          jump_labels = false,
          -- set to `false` to use the current line only
          multi_line = true,
          -- When using jump labels, don't use these keys
          -- This allows using those keys directly after the motion
          -- label = { exclude = "hjkliardc" },
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", "t", "T" },
          -- The direction for `prev` and `next` is determined by the motion.
          -- `left` and `right` are always left and right.
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = { register = false },
        },
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = false,
        },
      },
    },
    keys = function()
      return {
        {
          "s",
          -- mode = { "n" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
        {
          "S",
          -- mode = { "n" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
      }
    end,
  },
}
