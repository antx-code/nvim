-- akinsho/bufferline.nvim: 使用 lua 构建的 Neovim 的时髦💅缓冲线（带有标签页集成）。
-- romgrk/barbar.nvim: 
-- barbar.nvim 是一个选项卡插件，具有可重新排序、自动调整大小、可点击选项卡、图标、漂亮的突出显示、排序命令和神奇的跳转到缓冲区模式。另外，当两个文件名匹配时，选项卡名称将变得唯一。
-- 在跳转到缓冲区模式下，选项卡显示目标字母而不是图标。只需输入目标字母即可跳转到任何缓冲区。更好的是，目标字母在缓冲区的生命周期内保持不变，因此如果您正在处理一组文件，您甚至可以从内存中提前键入字母。

-- 这个文件是一个 Lua 模块，它返回一个包含两个配置的表。每个配置都是一个插件的配置，用于管理编辑器中的缓冲区（buffer）。
-- 第一个配置是 akinsho/bufferline.nvim 插件的配置。该插件提供了一个缓冲区标签栏，可以方便地切换和管理打开的缓冲区。在这个配置中，定义了一组按键映射，用于执行不同的操作，例如删除其他缓冲区、选择缓冲区等。这些按键映射使用了 Vim 命令和 Lua 函数来实现相应的功能。此外，还定义了一些插件的选项，用于自定义标签栏的外观和行为。
-- 第二个配置是 romgrk/barbar.nvim 插件的配置。该插件也提供了一个缓冲区标签栏，类似于第一个插件，但具有不同的外观和功能。在这个配置中，同样定义了一组按键映射和插件选项，用于自定义标签栏的行为和外观。这个插件还支持显示诊断信息，例如错误和警告。
-- 总体来说，这个文件的功能是配置两个缓冲区标签栏插件，以便在编辑器中更方便地管理和切换打开的缓冲区。通过定义按键映射和插件选项，可以自定义标签栏的行为和外观，以满足个人的需求和偏好。

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = true,
    keys = {
      {
        "<leader>bq",
        function()
          local buffers = vim.fn.getbufinfo({ buflisted = true })
          local changed_buffers = vim.tbl_filter(function(buf)
            return buf.changed == 1
          end, buffers)
          if #changed_buffers == 0 then
            vim.cmd([[BufferLineCloseOthers]])
          else
            vim.notify("There are unsaved buffers", vim.log.levels.WARN)
          end
        end,
        desc = "Delete other buffers",
      },
      {
        "Q",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<C-q>",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },
      {
        "<D-w>",
        function()
          require("mini.bufremove").delete(nil, false)
        end,
        desc = "Delete buffer",
      },

      {
        "<leader>bs",
        function()
          vim.cmd([[BufferLinePick]])
        end,

        desc = "Pick buffer",
      },

      {
        "<leader>bS",
        function()
          vim.cmd([[BufferLinePickClose]])
        end,
        desc = "Pick buffer and close",
      },
    },

    config = function()
      vim.cmd([[
  nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
  nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
  nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
  nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
  nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
  nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
  nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
  nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
  nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>
  ]])

      vim.o.mousemoveevent = true
      require("bufferline").setup({

        options = {

          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
          always_show_bufferline = true,
          indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "underline",
          },
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- only show warning and error
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              s = s .. sym .. n
            end
            return s
          end,
          hover = {

            delay = 36,
            reveal = { "close" },
            enabled = true,
          },
          style_preset = "slant",
        },
      })
    end,
  },
  {
    "romgrk/barbar.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<leader>bq", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Delete other buffers" },
      {
        "Q",
        "<cmd>BufferClose<cr>",
        desc = "Delete buffer",
      },
      {
        "<C-q>",
        "<cmd>BufferClose<cr>",

        desc = "Delete buffer",
      },
    },
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
      map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
      map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
      map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
      map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
      map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
      map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
      map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
      map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

      vim.g.barbar_auto_setup = false -- disable auto-setup

      require("barbar").setup({
        highlight_alternate = false,

        -- Disable highlighting file icons in inactive buffers
        highlight_inactive_file_icons = false,

        -- Enable highlighting visible buffers
        highlight_visible = true,
        -- animation = false,
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = nil}
          NvimTree = true,
          -- Or, specify the text used for the offset:
          undotree = { text = "undotree" },
          -- Or, specify the event which the sidebar executes when leaving:
          -- ["neo-tree"] = { event = "BufWipeout" },
          ["neo-tree"] = true,
          -- Or, specify both
          Outline = { event = "BufWinLeave", text = "symbols-outline" },
        },
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

        icons = {
          button = "×",
          separator = { left = "▎", right = "" },
          modified = { button = "●" },
          pinned = { button = "", filename = true },

          highlight_inactive_file_icons = true,
        },
        diagnostic = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
        },
        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,
        -- Enable/disable current/total tabpages indicator (top right corner)

        tabpages = true,
      })
    end,
  },
}
