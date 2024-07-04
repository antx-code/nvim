-- NvChad/nvim-colorizer.lua: 最快的 Neovim 着色器。Neovim 的高性能彩色荧光笔，没有外部依赖！用高性能 Luajit 编写。
-- uga-rosa/ccc.nvim: Neovim 的颜色选择器和荧光笔插件。在 neovim 中创建颜色代码。

-- 这个文件是一个 Lua 脚本，它返回一个包含两个表的表。每个表代表一个插件，并包含了该插件的配置信息和初始化逻辑。
-- 第一个插件是 "NvChad/nvim-colorizer.lua"，它提供了代码着色的功能。在初始化时，它创建了一个自动命令 "LspAttach"，当 LSP 客户端连接时触发。在回调函数中，它检查连接的客户端是否为 "tailwindcss"，如果是，则调用 "ColorizerToggle" 命令来启用代码着色。这个插件还定义了一些其他命令，如 "ColorizerAttachToBuffer"、"ColorizerDetachFromBuffer" 和 "ColorizerReloadAllBuffers"。
-- 第二个插件是 "uga-rosa/ccc.nvim"，它提供了颜色相关的功能。它在初始化时设置了一些选项，并创建了一个自动命令 "LspAttach"，当 LSP 客户端连接时触发。在回调函数中，它统计连接的客户端数量，如果有两个特定的客户端（"tsserver" 和 "tailwindcss"），则执行一系列刷新步骤来更新颜色高亮。这个插件还定义了一些命令，如 "CccPick" 和 "CccConvert"，以及一些按键映射。
-- 总体来说，这个文件的功能是配置和初始化两个插件，分别提供代码着色和颜色相关的功能。它通过创建自动命令和定义命令、按键映射来实现这些功能。

return {
  {
    "NvChad/nvim-colorizer.lua",
    -- event = "VeryLazy",
    lazy = false,
    priority = 9999,

    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    enabled = false,
    init = function()
      local done = false
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.name == "tailwindcss" and done == false then
            vim.cmd("ColorizerToggle")
            done = true
          end
        end,
      })
    end,
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },

  {
    "uga-rosa/ccc.nvim",
    enabled = true,
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
    event = "FileType typescript,typescriptreact,javascript,javascriptreact,json,yaml",
    keys = {
      { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert color" },
      { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick Color" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    config = function(_, opts)
      require("ccc").setup(opts)
      if opts.highlighter and opts.highlighter.auto_enable then
        vim.cmd.CccHighlighterEnable()
        local target_count = 0
        local target_lsp_names = { "tsserver", "tailwindcss" }
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if vim.tbl_contains(target_lsp_names, client.name) then
              target_count = target_count + 1
            end
            if target_count == 2 then
              local refresh_steps = { "<cmd>startinsert<CR>", "<esc><CR>", "<cmd>bufdo e<CR>zz" }
              local refresh_code = vim.api.nvim_replace_termcodes(table.concat(refresh_steps, ""), true, false, true)
              vim.api.nvim_feedkeys(refresh_code, "t", true)
            end
          end,
        })
      end
    end,
  },
}
