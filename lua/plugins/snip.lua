-- 这个文件是一个 Lua 脚本，它返回一个包含多个插件配置的 Lua 表。每个插件配置都是一个 Lua 表，包含插件的名称和一些配置选项。
-- 在这个文件中，有三个插件配置被定义。让我们逐个来看：
  -- 1. "rafamadriz/friendly-snippets" 插件配置：
    -- - enabled 设置为 false，表示该插件当前被禁用。
  -- 2. "Innei/friendly-snippets-fork" 插件配置（被注释掉）：
    -- - 这个插件配置被注释掉了，意味着它当前不会生效。
    -- - 可以看到有一个 config 函数被定义，但是函数体内的代码被注释掉了。
  -- 3. "L3MON4D3/LuaSnip" 插件配置：
    -- - event 设置为 "LazyFile"，表示该插件会在打开文件时进行延迟加载。
    -- - config 函数被定义，函数体内包含了一些配置代码：
    -- - 使用 require("luasnip.loaders.from_vscode").lazy_load() 函数进行插件的懒加载，加载的路径为 "~/.config/nvim/snippets"。
    -- - 使用 require("luasnip").filetype_extend() 函数扩展了一些文件类型的支持，例如将 "typescript" 文件类型扩展为支持 "javascript"。
    -- - 最后，使用 require("luasnip").setup() 函数进行插件的设置，其中包括禁用历史记录和设置区域检查事件为 "CursorHold"。
-- 总体来说，这个文件的功能是配置插件，并根据需要进行插件的加载和设置。不同的插件可以提供不同的功能和特性，这些配置可以根据个人需求进行调整和扩展。

return {
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  -- {
  --   "Innei/friendly-snippets-fork",
  --   -- event = "InsertEnter",
  --   config = function()
  --     -- require("luasnip.loaders.from_vscode").lazy_load()
  --     require("luasnip.loaders.from_vscode").lazy_load({
  --       paths = { "~/.config/nvim/snippets" },
  --     })
  --     require("luasnip").filetype_extend("typescript", { "javascript" })
  --     require("luasnip").filetype_extend("javascriptreact", { "javascript" })
  --     require("luasnip").filetype_extend("typescriptreact", { "javascript" })
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    event = "LazyFile",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/.config/nvim/snippets" },
      })
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require("luasnip").filetype_extend("javascriptreact", { "javascript" })
      require("luasnip").filetype_extend("typescriptreact", { "javascript" })
      require("luasnip").setup({
        history = false,
        region_check_events = { "CursorHold" },
      })
    end,
  },
}
