-- 一个 neovim lua 插件，帮助轻松管理多个终端窗口
-- 一个 neovim 插件，用于在编辑会话期间保留和切换多个终端

-- 这个文件是一个用于管理多个终端窗口的 neovim lua 插件。它的作用是在编辑会话期间保留和切换多个终端。
-- 插件的实现逻辑如下：
  -- - 首先，通过调用 require("toggleterm").setup() 方法来设置插件的配置。
  -- - 在配置中，设置了一些选项来控制插件的行为，例如：
  -- - insert_mappings：确定是否在插入模式下应用打开终端的映射。
  -- - terminal_mappings：确定是否在已打开的终端中应用打开终端的映射。
  -- - persist_size：确定是否记住终端窗口的大小。
  -- - persist_mode：确定是否记住上一个终端模式。
  -- - direction：确定终端窗口的排列方向，可以是水平、垂直、选项卡或浮动。
  -- - auto_scroll：确定是否在终端输出时自动滚动到底部。
  -- - open_mapping：设置打开终端的映射键，这里使用的是 <c-``>
-- 通过这些配置，插件可以提供方便的终端管理功能，使得在编辑会话期间可以轻松地切换和管理多个终端窗口。

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = "horizontal", --   direction = 'vertical' | 'horizontal' | 'tab' | 'float',
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        open_mapping = [[<c-`>]],
      })
    end,
  },
}
