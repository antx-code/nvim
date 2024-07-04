-- 一个用 Lua 编写的 Neovim 全局文件存储书签插件。

-- 根据提供的代码，这个文件是一个 Lua 模块，用于配置和设置书签（bookmarks）功能。它使用了一个名为 "tomasky/bookmarks.nvim" 的插件，并在配置中指定了一些依赖项，如 "nvim-telescope/telescope.nvim"。
-- 在配置函数中，它调用了 require("bookmarks").setup() 方法来设置书签的一些参数，比如保存书签的文件路径、关键字和相应的图标。它还定义了一些按键映射，用于在当前行添加或删除书签、添加或编辑标注、清除所有标记以及在本地缓冲区中跳转到下一个或上一个标记。最后，它加载了一个名为 "telescope" 的扩展，以支持书签的搜索和展示。
-- 总的来说，这个文件的功能是配置和设置书签插件，并提供了一些快捷键映射，方便用户在编辑器中管理和导航书签。

return {
  {
    "tomasky/bookmarks.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("bookmarks").setup({
        save_file = vim.fn.expand("$HOME/.local/share/nvim/bookmarks"), -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require("bookmarks")
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
        end,
      })

      require("telescope").load_extension("bookmarks")
    end,
  },
}
