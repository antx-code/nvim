-- 用于对齐线的 NeoVim 的最小插件

-- 这个文件的功能是配置一个名为 "align.nvim" 的插件。该插件用于在编辑器中对文本进行对齐操作。它提供了几个不同的对齐方式，包括按字符对齐、按字符串对齐以及按正则表达式对齐。
-- 在这个文件中，通过设置不同的按键映射，定义了几个对齐操作的函数。这些函数会调用 "align" 模块中的相应方法来执行对齐操作。这些方法接受不同的参数，例如对齐长度、是否显示预览以及是否使用正则表达式等。
-- 通过这些按键映射，用户可以在编辑器中使用不同的快捷键来执行对齐操作。例如，按下 "aa" 可以将选中的文本按照长度为1的字符进行对齐，按下 "ad" 可以将选中的文本按照长度为2的字符进行对齐，并显示预览。
-- 此外，还定义了两个示例的按键映射，分别是 "gaw" 和 "gaa"。这些按键映射用于在普通模式下执行对齐操作，而不需要先选中文本。这些示例演示了如何使用 "align" 模块中的操作符方法来执行对齐操作。
-- 总之，这个文件的目的是配置 "align.nvim" 插件，并定义了一些按键映射来方便用户执行不同类型的对齐操作。

return {
  "Vonr/align.nvim",
  event = "BufRead",
  branch = "v2",
  config = function()
    local NS = { noremap = true, silent = true }

    -- Aligns to 1 character
    vim.keymap.set("x", "aa", function()
      require("align").align_to_char({
        length = 1,
      })
    end, NS)

    -- Aligns to 2 characters with previews
    vim.keymap.set("x", "ad", function()
      require("align").align_to_char({
        preview = true,
        length = 2,
      })
    end, NS)

    -- Aligns to a string with previews
    vim.keymap.set("x", "aw", function()
      require("align").align_to_string({
        preview = true,
        regex = false,
      })
    end, NS)

    -- Aligns to a Vim regex with previews
    vim.keymap.set("x", "ar", function()
      require("align").align_to_string({
        preview = true,
        regex = true,
      })
    end, NS)

    -- Example gawip to align a paragraph to a string with previews
    vim.keymap.set("n", "gaw", function()
      local a = require("align")
      a.operator(a.align_to_string, {
        regex = false,
        preview = true,
      })
    end, NS)

    -- Example gaaip to align a paragraph to 1 character
    vim.keymap.set("n", "gaa", function()
      local a = require("align")
      a.operator(a.align_to_char)
    end, NS)
  end,
}
