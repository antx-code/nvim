-- 这个文件是一个 Lua 模块，它返回一个包含了多个配置项的表格。这些配置项用于设置不同的插件和功能。
-- 具体来说，这个文件中的配置项用于设置代码缩进和高亮显示。它使用了两个插件：shellRaining/hlchunk.nvim 和 lukas-reineke/indent-blankline.nvim。同时，还有一个插件 echasnovski/mini.indentscope，但它被禁用了。
-- 在 init 函数中，通过调用 vim.api.nvim_create_autocmd 函数创建了一个自动命令。这个自动命令在光标移动时触发，并执行 EnableHL 命令。
-- 接下来，调用了 require("hlchunk").setup 函数来设置 hlchunk 插件的配置项。其中，chunk 配置项用于设置代码块的高亮显示，indent 配置项用于设置代码缩进的样式，blank 配置项用于设置空白行的显示，line_num 配置项用于设置行号的样式。
-- 在这些配置项中，还使用了一个名为 utils.ft 的模块，它提供了一些文件类型的排除列表。
-- 总的来说，这个文件的功能是通过配置不同的插件和设置来实现代码缩进和高亮显示的效果。

return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })

      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#91bef0" },
          },
          exclude_filetypes = require("utils.ft").exclude_ft_table,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = "─",
          },
        },
        indent = {
          chars = { "│" },
          use_treesitter = false,

          style = {
            -- { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
            { fg = "#45475a" },
          },
          exclude_filetypes = require("utils.ft").exclude_ft_table,
        },
        blank = {
          enable = false,
        },
        line_num = {
          exclude_filetypes = require("utils.ft").exclude_ft_table,
          use_treesitter = true,
          style = "#91bef0",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },
}
