-- 根据提供的代码，这个文件是一个 Lua 配置文件，用于配置一个叫做 lualine.nvim 的 Neovim 插件。lualine.nvim 是一个用于美化状态栏的插件，它可以在状态栏中显示各种信息，如编辑模式、分支名称、文件名、文件类型、进度等。
-- 这个配置文件中的代码定义了 lualine.nvim 的配置选项和各个部分的内容。让我们逐步分析一下代码的实现逻辑：
  -- 1. 首先，配置了一些全局选项，如主题、组件分隔符和节分隔符等。
  -- 2. 接下来，定义了各个部分的内容。例如，lualine_a 部分显示编辑模式，lualine_b 部分显示分支名称、文件差异和诊断信息，lualine_c 部分显示文件名，lualine_x 部分显示文件类型和 Copilot 的状态信息，lualine_y 部分显示进度，lualine_z 部分显示光标位置和选择计数。
  -- 3. 最后，配置了一些扩展，如 neo-tree。
-- 这个配置文件的目的是为了定制 lualine.nvim 插件的外观和功能，以满足用户的需求。通过修改这个配置文件，用户可以自定义状态栏的显示内容和样式，以及添加额外的扩展功能。
-- 需要注意的是，这个配置文件中还使用了其他的 Lua 模块和函数，如 lazyvim.config、copilot.api、lazyvim.util、lualine.components.location 和 lualine.components.selectioncount。这些模块和函数可能是自定义的或者来自其他插件，它们提供了额外的功能和数据，用于定制状态栏的显示内容。

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { left = "", right = "" },
        globalstatus = true,
        ignore_focus = {
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
        },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          "filetype",
          {
            function()
              local icon = require("lazyvim.config").icons.kinds.Copilot
              local status = require("copilot.api").status.data
              return icon .. (status.message or "")
            end,
            cond = function()
              if not package.loaded["copilot"] then
                return
              end
              local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
              if not ok then
                return false
              end
              return ok and #clients > 0
            end,
            color = function()
              if not package.loaded["copilot"] then
                return
              end
              local Util = require("lazyvim.util")
              local colors = {
                [""] = Util.ui.fg("Special"),
                ["Normal"] = Util.ui.fg("Special"),
                ["Warning"] = Util.ui.fg("DiagnosticError"),
                ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
              }
              local status = require("copilot.api").status.data
              return colors[status.status] or colors[""]
            end,
          },
        },
        lualine_y = { "progress" },
        lualine_z = {
          {
            function()
              local loc = require("lualine.components.location")()
              local sel = require("lualine.components.selectioncount")()
              if sel ~= "" then
                loc = loc .. " (" .. sel .. " sel)"
              end
              return loc
            end,
            separator = { right = "" },
            left_padding = 2,
          },
        },
      },
      extensions = { "neo-tree" },
    },
  },
}
