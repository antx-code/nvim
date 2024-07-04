-- 用于嵌入式 lua 引擎的交互式实时 Neovim 便笺本 - 键入并观看！
-- Luapad 在具有覆盖打印功能的上下文中运行您的代码，并将捕获的输入显示为虚拟文本，就在调用它的地方 - 实时

-- 根据提供的代码，这个文件是一个Lua模块，它返回一个包含一个表的表达式。这个表中包含了一个Lua插件的配置信息。
-- 具体来说，这个Lua插件是rafcamlet/nvim-luapad，它提供了一个在Neovim编辑器中运行Lua代码的功能。在配置中，我们可以看到以下几个重要的设置项：
  -- cmd：指定了在Neovim中运行Lua代码的命令，即Lua和Luapad。
  -- config：一个函数，用于配置luapad插件的各种选项。在这个函数中，我们可以看到一些配置项的设置，例如count_limit、error_indicator、eval_on_move等。
  -- on_init：一个回调函数，在luapad插件初始化时被调用。在这个例子中，它会打印出"Hello from Luapad!"的消息。
  -- context：一个表，用于定义在Lua代码中可用的全局变量和函数。在这个例子中，定义了一个名为the_answer的变量，它的值是42，还定义了一个名为shout的函数，它将传入的字符串转换为大写并在末尾添加一个感叹号。
-- 总结起来，这个文件的功能是配置rafcamlet/nvim-luapad插件，包括设置运行Lua代码的命令、配置选项、定义全局变量和函数等。

return {
  {
    "rafcamlet/nvim-luapad",
    cmd = { "Lua", "Luapad" },
    config = function()
      require("luapad").setup({
        count_limit = 150000,
        error_indicator = false,
        eval_on_move = true,
        error_highlight = "WarningMsg",
        split_orientation = "horizontal",
        on_init = function()
          print("Hello from Luapad!")
        end,
        context = {
          the_answer = 42,
          shout = function(str)
            return (string.upper(str) .. "!")
          end,
        },
      })
    end,
  },
}
