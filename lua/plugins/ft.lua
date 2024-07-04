-- 这个文件的功能是配置文件类型识别的插件。它使用了一个叫做"nathom/filetype.nvim"的插件来实现这个功能。
-- 在这个文件中，我们可以看到一个Lua表的定义，它包含了一个配置项的列表。每个配置项都是一个Lua表，包含了插件的相关设置。
-- 在这个配置项中，我们可以看到一个名为"nathom/filetype.nvim"的插件被启用了，通过将enabled设置为false来禁用插件。然后，我们可以看到一个config函数被定义，它接受两个参数，但在这个例子中没有使用到。在config函数中，我们可以看到调用了一个叫做require("filetype").setup()的函数来设置文件类型识别的配置。
-- 在setup函数的参数中，我们可以看到一个名为overrides的表，它包含了文件类型的覆盖设置。在这个例子中，我们可以看到两个部分的设置。第一个部分是extensions，它定义了一些文件扩展名和对应的文件类型。例如，当文件扩展名是"env"时，它将被识别为"sh"类型的文件。第二个部分是complex，它定义了一些复杂的文件类型识别规则。例如，当文件名匹配正则表达式.*git/config时，它将被识别为"gitconfig"类型的文件。
-- 总的来说，这个文件的逻辑是通过配置插件的设置来实现文件类型识别的功能。它可以根据文件的扩展名或者复杂的规则来确定文件的类型，并将其用于后续的操作。

return {
  {
    "nathom/filetype.nvim",
    enabled = false,
    config = function(_, opt)
      require("filetype").setup({
        overrides = {
          extensions = {
            env = "sh",
            mts = "typescript",
            mjs = "javascript",
          },
          complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig", -- Included in the plugin
          },
        },
      })
    end,
  },
}
