-- 这个文件是一个 Lua 模块，用于配置和设置一些与 Git 相关的插件和扩展。它包含了一个 Lua 表（table），其中每个元素代表一个 Git 相关的插件或扩展。
-- 每个元素都是一个 Lua 表，包含了插件或扩展的相关配置信息。例如，第一个元素表示一个名为 "advanced-git-search.nvim" 的插件，它依赖于 "nvim-telescope/telescope.nvim" 插件，并在 "VeryLazy" 事件触发时加载。它还包含了一个名为 "config" 的函数，用于设置和配置插件。
-- 在这个文件中，还可以看到其他两个插件的配置信息。第二个元素表示一个名为 "neogit" 的插件，它依赖于三个其他插件，并在执行 "Neogit" 命令时加载。第三个元素表示一个名为 "gitsigns.nvim" 的插件，它包含了一些选项的配置函数。
-- 总体来说，这个文件的功能是配置和设置与 Git 相关的插件和扩展，以便在使用 Neovim 编辑器时增强 Git 功能和体验。

return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup({
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            -- fugitive or diffview
            diff_plugin = "diffview",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
            entry_default_author_or_date = "author", -- one of "author" or "date"

            -- Telescope layout setup
            -- telescope_theme = {
            --   function_name_1 = {
            --     -- Theme options
            --   },
            --   function_name_2 = "dropdown"
            --   -- e.g. realistic example
            --   show_custom_functions = {
            --     layout_config = { width = 0.4, height = 0.4 },
            --   },
            -- }
          },
        },
      })

      require("telescope").load_extension("advanced_git_search")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    cmd = { "Neogit" },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opt)
      opt.current_line_blame = true
      opt.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
        relative_time = true,
      }
      opt.current_line_blame_formatter_opts = {
        relative_time = true,
      }

      -- opt.current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>"
      opt.sign_priority = 0
    end,
  },
}
