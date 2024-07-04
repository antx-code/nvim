-- 用于分割/合并代码块的 Neovim 插件
-- Neovim 插件，用于拆分/连接代码块，如数组、哈希、语句、对象、字典等。

-- 这个文件是一个 Lua 脚本，它定义了一个用于分割和合并代码块的 Neovim 插件。该插件的名称是 "treesj"，它的作用是在编辑器中对代码块进行拆分和连接操作，例如数组、哈希、语句、对象、字典等。
-- 插件的实现逻辑如下：
  -- 1. 首先，它使用了 nvim-treesitter/nvim-treesitter 这个插件作为依赖。nvim-treesitter 是一个强大的语法解析库，可以帮助插件理解和操作代码的结构。
  -- 2. 插件定义了一个 Lua 表（table），其中包含了一个键值对。键是插件的名称 "Wansmer/treesj"，值是一个包含配置选项的 Lua 表。
  -- 3. 配置选项包括：
    -- - keys：定义了一个按键映射，当用户按下 <leader>j 键时，会执行 :TSJToggle<CR> 命令。这个命令用于切换代码块的单行和多行形式。
    -- - dependencies：指定了插件的依赖项，即需要安装和启用的其他插件。
    -- - opts：包含了一些其他的选项配置，例如 use_default_keymaps 表示是否使用默认的按键映射，max_join_length 表示最大的连接长度。
-- 总体来说，这个插件通过使用 nvim-treesitter 插件来解析代码的结构，然后根据用户的操作来拆分和连接代码块。用户可以通过按下 <leader>j 键来切换代码块的单行和多行形式。这个插件提供了一种方便的方式来编辑和组织代码块，提高了代码的可读性和可维护性。

return {
  -- Switch between single-line and multiline forms of code
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", ":TSJToggle<CR>", silent = true },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 999,
    },
  },
}
