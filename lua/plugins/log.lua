-- 根据提供的代码，这个文件的功能是配置一个名为"printer"的插件。该插件的作用是在编写特定类型的代码时，自动插入打印语句。
-- 具体实现逻辑如下：
  -- 1. 首先，通过调用require("printer").setup()方法来设置插件的配置。
  -- 2. 在配置中，指定了一个keymap，用于触发插件的功能。在这个例子中，设置为"gl"。
  -- 3. 在配置中，定义了一个formatters表，其中包含了不同类型代码的格式化函数。
  -- 4. 每个格式化函数都接受两个参数：text_inside和text_var。text_inside表示要打印的文本，text_var表示要打印的变量。
  -- 5. 格式化函数使用string.format()方法来生成打印语句，语句的格式为console.log("%s = ", %s)，其中%s表示要打印的文本，%s表示要打印的变量。
-- 总结起来，这个文件的功能是配置一个插件，该插件可以在编写特定类型的代码时，自动插入打印语句。通过设置不同类型代码的格式化函数，可以自定义打印语句的格式和内容。

return {
  "rareitems/printer.nvim",
  event = "VeryLazy",
  config = function()
    require("printer").setup({
      keymap = "gl", -- Plugin doesn't have any keymaps by default
      formatters = {
        typescriptreact = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
        javascriptreact = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
        vue = function(text_inside, text_var)
          return string.format('console.log("%s = ", %s)', text_inside, text_var)
        end,
      },
    })
  end,
}
