-- 一次专注于一项功能
-- 有时，处理大量代码可能会让人不知所措，因此一次只关注一项功能即可。 Peepsight 的创建是为了让您能够使用 Treesitter 专注于单个功能。

-- 根据代码的内容，这个文件似乎是一个 Neovim 插件的配置文件。它使用了一个名为 "peepsight.nvim" 的插件，并在 "BufReadPost" 事件发生时进行配置。
-- 该插件的目的是让用户能够使用 Treesitter（一种语法解析器）专注于单个功能。它定义了一个名为 "PeepsightToggle" 的按键映射，当按下 "zp" 键时，会调用 "peepsight" 模块的 "toggle" 函数。
-- 在配置函数中，它设置了一些语法项，包括 Lua 和 TypeScript 中的函数定义、类声明等。最后，它注释掉了 "require("peepsight").enable()" 这行代码，可能是因为它想在需要时手动启用插件。
-- 请注意，这只是根据代码推测的功能和实现逻辑，具体的功能和实现可能需要查看插件的文档或源代码来确认。根据代码的内容，这个文件似乎是一个 Neovim 插件的配置文件。它使用了一个名为 "peepsight.nvim" 的插件，并在 "BufReadPost" 事件发生时进行配置。

return {
  {
    "koenverburg/peepsight.nvim",
    cmd = { "PeepsightEnable", "PeepsightDisable" },
    keys = {
      {
        "zp",
        function()
          require("peepsight").toggle()
        end,
        desc = "PeepsightToggle",
      },
    },
    event = "BufReadPost",
    config = function()
      require("peepsight").setup({
        -- Lua
        "local_function_definition_statement",
        "function_definition_statement",

        -- TypeScript
        "class_declaration",
        "method_definition",
        "arrow_function",
        "function_declaration",
        "generator_function_declaration",
      })
      -- require("peepsight").enable()
    end,
  },
}
