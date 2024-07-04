-- 轻松添加/更改/删除周围的分隔符对。

-- 根据提供的代码，这个文件似乎是一个 Lua 脚本，用于配置文本编辑器的环绕（surround）功能。环绕功能允许你在编辑文本时，快速添加、替换或删除文本周围的字符或标记。
-- 这个文件中包含了两个环绕功能的配置项。第一个配置项使用了一个名为 "echasnovski/mini.surround" 的插件，但是它的启用状态被设置为 false，所以它目前是禁用的。第二个配置项使用了一个名为 "kylechui/nvim-surround" 的插件，并在 "BufReadPost" 事件触发时加载。这个插件似乎是为了与 Visual Studio Code 编辑器兼容，因为它设置了一个名为 "vscode" 的选项。
-- 在第二个配置项的 config 函数中，使用了 require("nvim-surround").setup() 来设置环绕功能的键绑定。这个函数接受一个包含不同操作的 keymaps 表作为参数。这些操作包括在不同模式下的插入、删除和修改操作，以及在不同模式下的行级别操作。
-- 总的来说，这个文件的功能是配置环绕功能的插件，并设置了相应的键绑定，以便在编辑文本时可以方便地添加、替换或删除文本周围的字符或标记。

return {
  {
    "echasnovski/mini.surround",
    enabled = false,
    opts = {
      mappings = {
        replace = "cs",

        -- add = "gsa",
        -- delete = "gsd",
        -- find = "gsf",
        -- find_left = "gsF",
        -- highlight = "gsh",
        -- update_n_lines = "gsn",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    vscode = true,
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end,
  },
}
