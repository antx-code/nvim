-- 根据提供的代码，这个文件似乎是一个 Lua 脚本，用于配置一些与滚动和滚动条相关的插件。它通过调用不同的插件的 setup 函数来配置它们的行为。
-- 具体来说，这个文件配置了以下几个插件：
  -- 1. Aasim-A/scrollEOF.nvim：这个插件用于在文件末尾滚动时自动跳转到下一个文件。它的配置选项包括：
    -- - pattern：用于确定在哪些文件类型中启用滚动到文件末尾的功能。
    -- - insert_mode：确定是否在插入模式下启用滚动到文件末尾的功能。
    -- - disabled_filetypes：禁用滚动到文件末尾功能的文件类型列表。
    -- - disabled_modes：禁用滚动到文件末尾功能的模式列表。
  -- 2. petertriho/nvim-scrollbar：这个插件用于在编辑器中显示滚动条。它的配置选项包括：
    -- - show：确定是否显示滚动条。
    -- - show_in_active_only：确定是否只在活动窗口中显示滚动条。
    -- - set_highlights：确定是否设置滚动条的高亮。
    -- - folds：处理折叠代码的方式，如果缓冲区中的行数超过指定的数量，则禁用折叠。
    -- - max_lines：如果缓冲区中的行数超过指定的数量，则禁用滚动条。
    -- - hide_if_all_visible：如果所有行都可见，则隐藏滚动条。
    -- - throttle_ms：滚动条更新的延迟时间。
    -- - handle：滚动条的样式和颜色配置。
    -- - marks：滚动条上的标记配置。
    -- - excluded_buftypes：禁用滚动条的缓冲区类型列表。
    -- - excluded_filetypes：禁用滚动条的文件类型列表。
    -- - autocmd：触发滚动条更新的自动命令列表。
    -- - handlers：滚动条的事件处理配置。
  -- 3. dstein64/nvim-scrollview：这个插件用于在编辑器中显示一个小窗口，显示当前光标位置在整个文件中的相对位置。它的配置选项包括：
    -- - excluded_filetypes：禁用滚动视图的文件类型列表。
    -- - winblend：滚动视图窗口的透明度。
    -- - signs_on_startup：启动时显示的标记类型列表。
    -- - diagnostics_error_symbol：诊断错误的标记符号。
    -- - diagnostics_warn_symbol：诊断警告的标记符号。
    -- - diagnostics_info_symbol：诊断信息的标记符号。
    -- - diagnostics_hint_symbol：诊断提示的标记符号。
-- 这些插件的配置选项可以根据个人喜好进行调整，以满足不同的需求。

return {
  {
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    config = function()
      require("scrollEOF").setup({
        -- The pattern used for the internal autocmd to determine
        -- where to run scrollEOF. See https://neovim.io/doc/user/autocmd.html#autocmd-pattern
        pattern = "*",
        -- Whether or not scrollEOF should be enabled in insert mode
        insert_mode = false,
        -- List of filetypes to disable scrollEOF for.
        disabled_filetypes = {},
        -- List of modes to disable scrollEOF for. see https://neovim.io/doc/user/builtin.html#mode() for available modes.
        disabled_modes = {},
      })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines = false, -- disables if no. of lines in buffer exceeds this
        hide_if_all_visible = false, -- Hides everything if all lines are visible
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
          color = nil,
          color_nr = nil, -- cterm
          highlight = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Search = {
            text = { "-", "=" },
            priority = 1,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "Search",
          },
          Error = {
            text = { "-", "=" },
            priority = 2,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "-", "=" },
            priority = 3,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "-", "=" },
            priority = 4,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "-", "=" },
            priority = 5,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = "DiagnosticVirtualTextHint",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "cmp_docs",
          "cmp_menu",
          "noice",
          "prompt",
          "TelescopePrompt",
          "lazy",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor = false,
          diagnostic = true,
          gitsigns = false, -- Requires gitsigns
          handle = true,
          search = false, -- Requires hlslens
          ale = false, -- Requires ALE
        },
      })
    end,
  },
  {
    "dstein64/nvim-scrollview",
    enabled = false,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree" },
        -- current_only = true,
        -- base = "buffer",
        -- signs_on_startup = { "all" },
        -- diagnostics_severities = { vim.diagnostic.severity.ERROR },
        winblend = 0,
        signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
        diagnostics_error_symbol = "▎",
        diagnostics_warn_symbol = "▎",
        diagnostics_info_symbol = "▎",

        diagnostics_hint_symbol = "",
      })
    end,
  },
}
