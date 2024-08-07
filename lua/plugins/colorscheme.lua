-- 这个文件是一个 Lua 脚本，用于配置颜色方案（color scheme）的插件。它定义了一个 Lua 表（table），其中包含了多个颜色方案的配置信息。
-- 每个颜色方案都是一个 Lua 表，包含了插件的名称、优先级、事件触发条件以及配置函数。配置函数会在加载插件时被调用，用于设置颜色方案的具体配置。
-- 在配置函数中，可以设置颜色方案的各种属性，比如主题样式、背景透明度、代码样式、Lualine（状态栏插件）配置等。还可以通过自定义高亮（custom_highlights）函数来设置特定的语法高亮颜色。
-- 此外，还可以配置插件的集成，比如是否与 nvimtree（文件浏览器插件）、gitsigns（Git 标记插件）等进行集成。
-- 总的来说，这个文件的功能是根据用户的配置，为 Neovim 编辑器提供不同的颜色方案，以满足用户对编辑器外观的个性化需求。

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local transparent_background = true
      -- if vim.g.neovide then
      --   transparent_background = false
      -- end
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        no_bold = true,

        custom_highlights = function(colors)
          local macchiato = require("catppuccin.palettes").get_palette("macchiato")

          return {
            Visual = { bg = colors.surface1 },
            CursorLine = { bg = macchiato.crust },
            CursorIM = {
              bg = colors.sky,
              fg = colors.sky,
            },
          }
        end,
        transparent_background = transparent_background, -- disables setting the background color.

        integrations = {
          nvimtree = false,
          neotree = true,
          gitsigns = true,
          illuminate = true,
          bufferline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          mini = true,
          flash = false,
          rainbow_delimiters = false,
          barbar = false,
          dropbar = true,

          -- cmp = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "underdotted" },
            },
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
    end,
    -- enabled = false,
  },
  {
    "navarasu/onedark.nvim",

    event = "VeryLazy",
    enabled = false,
    config = function()
      require("onedark").setup({
        -- Main options --
        style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      })

      require("onedark").load()
    end,
  },
}
