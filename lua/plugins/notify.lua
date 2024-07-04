-- 这个文件是一个 Lua 模块，它返回一个包含两个表的表。每个表都包含了一些配置和初始化函数。
  -- 1. 第一个表是 "rcarriga/nvim-notify"，它使用了一个叫做 notify 的插件，并设置了一些参数，比如帧率、渲染方式、超时时间等。这个表还定义了一个 init 函数，用于在 noice.nvim 插件未启用时安装 notify。
  -- 2. 第二个表是 "folke/noice.nvim"，它使用了另一个叫做 noice.nvim 的插件，并设置了一些选项和预设。这个表还定义了一些过滤器和路由，用于控制在不同事件发生时如何显示通知。
-- 总体来说，这个文件的功能是配置和初始化两个插件，以实现在 Neovim 中显示通知的功能。

return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        fps = 60,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 5000,
        max_width = 80,
        max_height = 20,
      })
    end,
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("lazyvim.util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      -- cmdline = {
      --   -- enabled = true, -- enables the Noice cmdline UI
      --   view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      --   opts = {}, -- global options for the cmdline. See section on views
      --   ---@type table<string, CmdlineFormat>
      --   format = {
      --     -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      --     -- view: (default is cmdline view)
      --     -- opts: any options passed to the view
      --     -- icon_hl_group: optional hl_group for the icon
      --     -- title: set to anything or empty string to hide
      --     cmdline = { pattern = "^:", icon = "", lang = "vim" },
      --     search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      --     search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      --     filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      --     lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      --     help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      --     -- lua = false, -- to disable a format, set to `false`
      --   },
      -- },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        mini = {
          win_options = { winblend = 0 },
        },
      },
      routes = {
        {
          filter = {
            event = "notify",
            any = {
              -- Neo-tree
              { find = "Toggling hidden files: true" },
              { find = "Toggling hidden files: false" },
              { find = "Operation canceled" },

              -- Telescope
              { find = "Nothing currently selected" },
              {
                find = "No information available",
              },
              {
                find = "Highlight group",
              },
              {
                find = "no manual entry for",
              },
              {
                find = "not have parser for",
              },

              -- ts
              {
                find = "_ts_parse_query",
              },
            },
          },
          opts = { skip = true },
        },
        -- {
        --   filter = {
        --     event = "msg_show",
        --     kind = { "echo" },
        --   },
        --   opts = { skip = true },
        -- },
        {
          filter = {
            event = "msg_show",
            kind = "",
            any = {
              -- Save
              { find = " bytes written" },

              -- Redo/Undo
              { find = " changes; before #" },
              { find = " changes; after #" },
              { find = "1 change; before #" },
              { find = "1 change; after #" },

              -- Yank
              { find = " lines yanked" },

              -- Move lines
              { find = " lines moved" },
              { find = " lines indented" },

              -- Bulk edit
              { find = " fewer lines" },
              { find = " more lines" },
              { find = "1 more line" },
              { find = "1 line less" },

              -- General messages
              { find = "Already at newest change" },
              { find = "Already at oldest change" },
              { find = "E21: Cannot make changes, 'modifiable' is off" },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "lsp",
            any = {
              { find = "formatting" },
              { find = "Diagnosing" },
              { find = "Diagnostics" },
              { find = "diagnostics" },
              { find = "code_action" },
              { find = "Processing full semantic tokens" },
              { find = "symbols" },
              { find = "completion" },
            },
          },
          opts = { skip = true },
        },
      },
    },
  },
}
