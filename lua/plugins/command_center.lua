-- 以更有组织的方式创建和管理键绑定和命令，并通过 Telescope 快速搜索它们。
-- 以更有条理的方式创建和管理键盘映射和命令。

-- 这个文件是一个 Lua 脚本，它定义了一个 Lua 表（table），该表包含了一个命令中心（Command Center）的配置信息和功能。
-- 命令中心是一个用于集中管理和执行各种命令的工具。它可以帮助你快速执行常用的操作，如复制文件路径、重启 LSP 服务器、重新加载缓冲区等。
-- 在这个文件中，命令中心的配置信息被定义在一个 Lua 表中。该表包含了以下几个字段：
  -- - dependencies：一个包含依赖插件名称的数组，这些插件需要在命令中心启用之前被安装。
  -- - keys：一个包含按键映射的数组，每个按键映射都包含一个按键序列和一个对应的函数。当用户按下指定的按键序列时，对应的函数将被执行。
  -- - lazy：一个布尔值，表示是否延迟加载命令中心。如果设置为 true，则命令中心将在第一次使用时才被加载。
  -- - config：一个函数，用于配置和初始化命令中心的各个组件和选项。
-- 在 config 函数中，命令中心的配置和初始化工作被执行。首先，通过 require("commander") 导入命令中心的模块。然后，使用 command_center.add() 方法添加各个命令的配置信息，每个命令都包含一个描述（desc）和一个对应的命令（cmd）。
-- 其中，命令可以是一个字符串，表示一个 Vim 命令，也可以是一个函数，表示一个 Lua 函数。对于字符串命令，可以使用 <CMD> 前缀来表示一个 Vim 命令。对于 Lua 函数命令，可以直接定义一个 Lua 函数。
-- 除了添加命令，还可以通过设置 components、sort_by、separator 等选项来自定义命令中心的外观和行为。
-- 最后，通过调用 command_center.setup() 方法来完成命令中心的设置和初始化。
-- 总结起来，这个文件定义了一个命令中心的配置信息和功能，通过配置和初始化命令中心的各个组件和选项，使得用户可以方便地执行各种命令操作。

return {

  {
    "FeiyouG/command_center.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<D-S-p>",
        function()
          vim.cmd([[Telescope commander]])
        end,
        desc = "Command Center",
      },
    },

    lazy = true,
    config = function()
      local command_center = require("commander")
      command_center.add({
        {
          desc = "Copy current file path (absolute)",
          cmd = function()
            local file_path = vim.api.nvim_buf_get_name(0)
            vim.fn.system("echo -n" .. file_path .. " | pbcopy")
          end,
        },
        {
          desc = "Copy current file path & line (relative to cwd)",
          cmd = function()
            local file_path = vim.api.nvim_buf_get_name(0)
            local relative_path = vim.fn.fnamemodify(file_path, ":~:." .. vim.fn.getcwd() .. ":.")
            local current_line = vim.api.nvim_win_get_cursor(0)[1]
            local file_path_and_line = relative_path .. "#" .. current_line
            vim.fn.system("echo -n " .. file_path_and_line .. " | pbcopy")
          end,
        },
        {
          desc = "Restart LSP server",
          cmd = function()
            vim.cmd([[LspStop]])
            vim.cmd([[LspStart]])
          end,
        },
        {
          desc = "Reload Buffer",
          cmd = "<CMD>bufdo e<CR>zz",
        },
        {
          desc = "Reload Window",
          cmd = "<CMD>windo e<CR>zz",
        },
        {
          desc = "Advanced git search",
          cmd = "<CMD>AdvancedGitSearch<CR>",
        },
        {
          desc = "Neogit",
          cmd = "<CMD>Neogit<CR>",
        },
        {
          desc = "Refresh TSHighlight",
          cmd = function()
            vim.cmd([[TSDisable highlight]])
            vim.cmd([[TSEnable highlight]])
          end,
        },
        {
          desc = "Open the specified file (relative to cwd)",
          cmd = function()
            require("utils.others.open-file").open_file()
          end,
        },
        -- {
        --   desc = "Reload plugins host",
        --   cmd = function()
        --     local plugins = require("lazy").plugins()
        --
        --     for _, plugin in ipairs(plugins) do
        --       vim.cmd("Lazy reload " .. plugin.name)
        --     end
        --   end,
        -- },
      })

      command_center.setup({
        components = {
          "DESC",
          "KEYS",
          "CAT",
        },
        sort_by = {
          "DESC",
          "KEYS",
          "CAT",
          "CMD",
        },
        -- Change the separator used to separate each component
        separator = " ",

        -- When set to true,
        -- The desc component will be populated with cmd if desc is empty or missing.
        auto_replace_desc_with_cmd = true,

        -- Default title of the prompt
        prompt_title = "Commander",
        integration = {
          telescope = {
            enable = true,
          },
          lazy = {
            enable = true,
          },
        },
      })
      -- telescope.setup({
      --   extensions = {
      --     command_center = {
      --       components = {
      --         command_center.component.DESC,
      --         command_center.component.KEYS,
      --       },
      --       auto_replace_desc_with_cmd = false,
      --     },
      --   },
      -- })

      -- telescope.load_extension("command_center")
    end,
  },
}
