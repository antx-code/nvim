-- 根据提供的代码片段，这个文件似乎是一个Lua模块，用于配置和设置Markdown预览功能。它使用了一个名为iamcco/markdown-preview.nvim的插件来实现Markdown预览。
-- 代码中的return语句返回了一个包含一个表的表达式。这个表中有一个元素，是一个包含了一些键值对的表。其中，cmd键对应的值是一个包含了三个字符串的数组，分别是"MarkdownPreview"、"MarkdownPreviewStop"和"MarkdownPreviewToggle"。这些字符串表示了在插件中可用的命令。
-- 另外，config键对应的值是一个函数。这个函数使用了vim.fn["mkdp#util#install"]()来安装Markdown预览所需的工具。
-- 总的来说，这个文件的功能是配置Markdown预览插件，并定义了一些可用的命令和安装所需工具的函数。

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    ft = { "markdown" },
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
