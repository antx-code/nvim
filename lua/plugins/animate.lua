-- 当使用 % 或 <c-f> 、 <c-b> 等命令时，很容易丢失当前光标位置。这个插件添加子光标来显示滚动方向！

-- 根据提供的代码选择，这个文件是一个 Lua 脚本，用于配置和初始化一些插件。具体来说，它配置了两个插件：mini.animate 和 SmoothCursor.nvim。
-- 首先，我们来看一下被注释掉的部分。这部分代码配置了 mini.animate 插件，并定义了一个名为 VeryLazy 的事件。在 config 函数中，通过调用 require("mini.animate").setup() 来设置插件的参数。其中，scroll 参数启用了滚动动画，并定义了一个 timing 函数，用于计算滚动动画的时长。
-- 接下来，我们看到一个未被注释的代码块，它配置了 SmoothCursor.nvim 插件。在 config 函数中，通过调用 require("smoothcursor").setup() 来设置插件的参数。这个插件的功能是改变光标的外观。
-- 在配置中，我们可以看到以下参数设置：
  -- cursor：设置光标的样式，这里设置为 "ω"。
  -- priority：设置光标标记的优先级。
  -- fancy：设置光标的复杂样式。其中，head 定义了光标的头部样式，body 定义了光标的身体样式，tail 定义了光标的尾部样式。
  -- disable_float_win：禁用浮动窗口。
  -- disabled_filetypes：定义了一些文件类型，在这些文件类型中禁用插件的功能。
  -- 最后，我们可以看到 event 参数设置为 "BufRead"，表示在读取缓冲区时触发插件的配置。
-- 总结起来，这个文件的功能是配置和初始化两个插件：mini.animate 和 SmoothCursor.nvim。其中，mini.animate 插件用于实现滚动动画，而 SmoothCursor.nvim 插件用于改变光标的外观。

return {
  -- {
  --   "echasnovski/mini.animate",
  --   version = "*",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.animate").setup({
  --       scroll = {
  --         enable = true,
  --         timing = function(_, n)
  --           return 150 / n
  --         end,
  --       },
  --       cursor = {
  --         enable = false,
  --       },
  --     })
  --   end,
  -- },
  {
    "gen740/SmoothCursor.nvim",
    enabled = true,
    config = function()
      require("smoothcursor").setup({
        cursor = "ω",

        priority = 1, -- set marker priority
        fancy = {
          enable = true,
          head = { cursor = "ಥ", texthl = "SmoothCursor", linehl = nil },
          body = {
            --            (•̀ᴗ• ) ̑̑
            { cursor = "♡", texthl = "SmoothCursorRed" },
            { cursor = "•̀", texthl = "SmoothCursorOrange" },
            { cursor = "ᴗ", texthl = "SmoothCursorYellow" },
            { cursor = "•", texthl = "SmoothCursorGreen" },
            { cursor = "ɷ", texthl = "SmoothCursorAqua" },
            { cursor = "ᴥ", texthl = "SmoothCursorBlue" },
            { cursor = "ω", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        disable_float_win = true,

        disabled_filetypes = require("utils.ft").exclude_ft, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
      })
    end,
    event = "BufRead",
  },
}
