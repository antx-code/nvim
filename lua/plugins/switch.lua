-- 一个简单的 Vim 插件，用于使用预定义的替换来切换文本段

-- 根据代码，这个文件的功能是配置一些插件，并定义了一些按键绑定和配置选项。具体来说：
  -- 1. 第一个插件是 "AndrewRadev/switch.vim"，它在 Visual Studio Code 中启用了一个名为 "Switch" 的命令。按下 <leader>sx 键会调用 vim.cmd("Switch") 来执行该命令。
  -- 2. 第二个插件是 "mizlan/iswap.nvim"，它提供了一些交换文本的功能。通过调用 require("iswap").setup({...}) 来配置插件的选项。
  -- 3. 第三个插件是 "Wansmer/sibling-swap.nvim"，它提供了一些交换代码行的功能。通过调用 require("sibling-swap").setup({...}) 来配置插件的选项。
-- 总体来说，这个文件的目的是为了增强编辑器的功能，使得在编写代码时更加方便和高效。

return {
  {
    "AndrewRadev/switch.vim",
    vscode = true,
    keys = {
      {
        "<leader>sx",
        function()
          vim.cmd("Switch")
        end,
        desc = "Switch",
      },
    },

    config = function()
      vim.g.switch_mapping = ""
    end,
  },
  {
    "mizlan/iswap.nvim",
    cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith" },
    config = function()
      require("iswap").setup({
        -- The keys that will be used as a selection, in order
        -- ('asdfghjklqwertyuiopzxcvbnm' by default)
        keys = "asdfghjklqwertyuiop123456",

        -- Grey out the rest of the text when making a selection
        -- (enabled by default)
        -- grey = "enabled",

        -- Highlight group for the sniping value (asdf etc.)
        -- default 'Search'
        hl_snipe = "ErrorMsg",

        -- Highlight group for the visual selection of terms
        -- default 'Visual'
        hl_selection = "WarningMsg",

        -- Highlight group for the greyed background
        -- default 'Comment'
        hl_grey = "LineNr",

        -- Post-operation flashing highlight style,
        -- either 'simultaneous' or 'sequential', or false to disable
        -- default 'sequential'
        flash_style = false,

        -- Highlight group for flashing highlight afterward
        -- default 'IncSearch'
        hl_flash = "ModeMsg",

        -- Move cursor to the other element in ISwap*With commands
        -- default false
        move_cursor = true,

        -- Automatically swap with only two arguments
        -- default nil
        autoswap = true,

        -- Other default options you probably should not change:
        debug = nil,
        hl_grey_priority = "1000",
      })
    end,
  },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "<leader>s.",
        function()
          require("sibling-swap").swap_with_right_with_opp()
        end,
        desc = "Swap with right with opp",
      },
      {
        "<leader>s,",
        function()
          require("sibling-swap").swap_with_left_with_opp()
        end,
        desc = "Swap with left with opp",
      },
      {
        "<C-.>",
        function()
          require("sibling-swap").swap_with_right()
        end,
        desc = "Swap with right",
      },
      {
        "<C-,>",
        function()
          require("sibling-swap").swap_with_left()
        end,
        desc = "Swap with left",
      },
    },
    config = function()
      require("sibling-swap").setup({
        allowed_separators = {
          ",",
          ";",
          "and",
          "or",
          "&&",
          "&",
          "||",
          "|",
          "==",
          "===",
          "!=",
          "!==",
          "-",
          "+",
          ["<"] = ">",
          ["<="] = ">=",
          [">"] = "<",
          [">="] = "<=",
        },
        use_default_keymaps = true,
        -- Highlight recently swapped node. Can be boolean or table
        -- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
        -- `hl_opts` is a `val` from `nvim_set_hl()`
        highlight_node_at_cursor = false,
        -- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
        keymaps = {
          ["<C-.>"] = "swap_with_right",
          ["<C-,>"] = "swap_with_left",
          ["<leader>s."] = "swap_with_right_with_opp",
          ["<leader>s,"] = "swap_with_left_with_opp",
        },
        ignore_injected_langs = false,
        -- allow swaps across lines
        allow_interline_swaps = true,
        -- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
        interline_swaps_witout_separator = false,
      })
    end,
  },
}
