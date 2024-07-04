-- 根据提供的代码，这个文件的功能是配置一个名为"better-escape"的插件。该插件的作用是在按下特定的按键组合时，将其映射为Esc键，以实现更方便的退出操作。
-- 具体实现逻辑如下：
  -- 1. 首先，通过调用require("better_escape").setup()函数来设置插件的配置。
  -- 2. 在配置函数中，通过传递一个包含按键映射的表（mapping）来指定按键组合。在这个例子中，按键组合为"jk"、"jj"和"kk"。
  -- 3. 通过将timeout设置为vim.o.timeoutlen，插件将使用Vim的timeoutlen选项来确定按键组合的超时时间。这意味着按键组合必须在一定的时间内完成，否则将不会触发映射。
  -- 4. clear_empty_lines选项设置为false，表示在按下按键组合后，如果当前行只包含空白字符，则不会清除该行。
  -- 5. 最后，将按键映射设置为"<Esc>"，即将按键组合映射为Esc键。
-- 通过这些配置，插件将会在按下指定的按键组合时，将其替换为Esc键，从而实现更方便的退出操作。

return {

  "max397574/better-escape.nvim",
  -- enabled = false,
  vscode = true,
  config = function()
    require("better_escape").setup({
      mapping = { "jk", "jj", "kk" }, -- a table with mappings to use
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
      keys = "<Esc>",
    })
  end,
}
