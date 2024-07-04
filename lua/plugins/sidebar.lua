-- 根据提供的代码，这个文件的功能是配置一个名为 "sidebar-nvim/sidebar.nvim" 的插件。该插件用于创建一个侧边栏，显示缓冲区、Git 信息、符号、待办事项和文件等不同的部分。
-- 实现逻辑如下：
  -- 1. 首先，通过调用 require("sidebar-nvim").setup() 方法来设置插件的配置。
  -- 2. 在 setup() 方法中，可以传递一个包含各种配置选项的 Lua 表作为参数。
  -- 3. 在提供的代码中，配置选项包括：
    -- - disable_default_keybindings：是否禁用默认的按键绑定。
    -- - bindings：自定义按键绑定。
    -- - open：侧边栏是否默认打开。
    -- - side：侧边栏的位置（左侧或右侧）。
    -- - initial_width：侧边栏的初始宽度。
    -- - hide_statusline：是否隐藏状态栏。
    -- - update_interval：侧边栏内容的更新间隔。
    -- - sections：要显示的侧边栏部分，按照顺序排列。
    -- - section_separator：每个部分之间的分隔符。
    -- - section_title_separator：每个部分标题的分隔符。
    -- - todos：待办事项部分的配置，包括忽略的路径。
  -- 4. 在配置完成后，侧边栏插件将根据提供的配置选项进行初始化，并在编辑器中显示侧边栏。
-- 这个文件的作用是为 "sidebar-nvim/sidebar.nvim" 插件提供配置，以便创建一个自定义的侧边栏来增强编辑器的功能和用户体验。

return {
  {
    "sidebar-nvim/sidebar.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("sidebar-nvim").setup({
        disable_default_keybindings = 0,
        bindings = nil,
        open = true,
        side = "right",
        initial_width = 35,
        hide_statusline = false,
        update_interval = 1000,
        sections = { "buffers", "git", "symbols", "todo", "files" },
        section_separator = { "", "-----", "" },
        section_title_separator = { "" },
        todos = { ignored_paths = { "~" } },
      })
    end,
  },
}
