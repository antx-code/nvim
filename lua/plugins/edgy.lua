-- folke/edgy.nvim: 轻松创建和管理预定义的窗口布局，为您的工作流程带来新优势
-- akinsho/bufferline.nvim: 使用 lua 构建的 Neovim 的时髦💅缓冲线（带有标签页集成）。
-- nvim-neo-tree/neo-tree.nvim: 
  -- Neovim 插件用于管理文件系统和其他树状结构。
  -- Neo-tree 是一个 Neovim 插件，可以以任何适合您的风格浏览文件系统和其他树状结构，包括侧边栏、浮动窗口、netrw 分割样式或同时使用所有这些！

-- 这个文件是一个 Lua 模块，它返回一个包含多个配置项的表。这些配置项用于配置不同的插件和功能。
-- 文件中的每个配置项都是一个包含插件名称、可选项和回调函数的表。这些配置项用于启用、禁用和自定义插件的行为。
-- 让我们逐个解释一下文件中的配置项：
  -- 1. folke/edgy.nvim：这是一个名为 "edgy.nvim" 的插件配置项。它包含了一些键绑定和选项，用于在编辑器中切换和选择窗口。
  -- 2. akinsho/bufferline.nvim：这是一个名为 "bufferline.nvim" 的插件配置项。它包含了一些选项和回调函数，用于自定义缓冲区标签栏的行为。
  -- 3. nvim-neo-tree/neo-tree.nvim：这是一个名为 "neo-tree.nvim" 的插件配置项。它包含了一些选项和回调函数，用于自定义文件树的行为。
-- 每个插件配置项都有一个 opts 回调函数，用于返回该插件的配置选项。这些选项可以是静态的值，也可以是动态的，根据特定的条件进行计算。
-- 总体来说，这个文件的功能是为编辑器提供插件的配置选项，以便用户可以根据自己的需求来启用、禁用和自定义插件的行为。

return {

  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    enabled = false,
    keys = {
      {
        "<leader>ue",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
      -- stylua: ignore
      { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = function()
      local opts = {
        animate = {
          enabled = false,
        },
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "lazyterm",
            title = "LazyTerm",
            size = { height = 0.4 },
            filter = function(buf)
              return not vim.b[buf].lazyterm_cmd
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          -- { ft = "spectre_panel", size = { height = 0.4 } },
          { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
        },
        left = {
          {
            title = "Buffers",
            ft = "neo-tree",
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "buffers"
            end,
            pinned = true,
            open = "Neotree position=top buffers",
            size = { height = 0.2 },
          },

          {
            title = "Files",
            ft = "neo-tree",
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "filesystem"
            end,
            pinned = true,
            open = function()
              vim.api.nvim_input("<esc><space>e")
            end,
            size = { height = 0.8 },
          },
          { title = "Neotest Summary", ft = "neotest-summary" },
          "neo-tree",
        },
        keys = {
          -- increase width
          ["<c-Right>"] = function(win)
            win:resize("width", 2)
          end,
          -- decrease width
          ["<c-Left>"] = function(win)
            win:resize("width", -2)
          end,
          -- increase height
          ["<c-Up>"] = function(win)
            win:resize("height", 2)
          end,
          -- decrease height
          ["<c-Down>"] = function(win)
            win:resize("height", -2)
          end,
        },
      }
      -- local Util = require("lazyvim.util")
      -- if Util.has("symbols-outline.nvim") then
      --   table.insert(opts.right, {
      --     title = "Outline",
      --     ft = "Outline",
      --     pinned = true,
      --     open = "SymbolsOutline",
      --   })
      -- end
      return opts
    end,
  },

  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = " " .. string.rep(" ", sb.bounds.width)
                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                ret[pos .. "_size"] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
}
