-- 一款用于在 Neovim 中转换文本大小写的多合一插件

-- 这个文件是一个 Lua 模块，它返回一个包含配置信息的表。根据代码中的内容，这个模块的功能是配置和设置文本大小写转换的插件。
-- 具体来说，代码中的 require("textcase").setup({}) 表示加载了一个名为 "textcase" 的插件，并调用了它的 setup 函数进行配置。这个插件可能是用来处理文本大小写转换的。
-- 接下来，代码中调用了 require("telescope").load_extension("textcase")，这表示加载了一个名为 "telescope" 的插件，并加载了它的 "textcase" 扩展。这个扩展可能是为了在 "telescope" 插件中添加文本大小写转换的功能。
-- 然后，代码通过 vim.api.nvim_set_keymap 函数设置了一些按键映射。这些按键映射定义了在按下特定按键时执行的命令。例如，vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope" }) 表示在 Normal 模式下按下 "ga." 键时执行命令 "TextCaseOpenTelescopeLSPChange"，该命令可能与文本大小写转换相关。
-- 最后，整个配置被包装在一个匿名函数中，这个函数会在加载模块时被调用，用于执行配置操作。
-- 总结起来，这个文件的功能是配置和设置文本大小写转换的插件，并在 "telescope" 插件中添加了相应的功能。

return {
  "xlboy/text-case.nvim",

  event = "BufRead",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
    vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap(
      "n",
      "gaa",
      "<cmd>TextCaseOpenTelescopeQuickChange<CR>",
      { desc = "Telescope Quick Change" }
    )
  end,
}
