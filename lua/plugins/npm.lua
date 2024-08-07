-- 根据提供的代码，这个文件的功能是配置和设置一些与包管理器和依赖项相关的信息。它使用了两个插件：vuki656/package-info.nvim和nvim-telescope/telescope.nvim。
-- 首先，通过调用require("package-info").setup({...})来设置package-info插件的配置选项。这些选项包括包管理器类型、颜色设置和图标设置等。然后，通过调用require("telescope").setup({...})来设置telescope插件的配置选项。这些选项包括扩展和主题设置等。
-- 接下来，通过调用require("telescope").load_extension("package_info")来加载telescope插件的package_info扩展。
-- 然后，通过调用vim.keymap.set({...})来设置一些按键映射。这些按键映射定义了一些操作，如更新依赖项、删除依赖项、安装新的依赖项和安装不同版本的依赖项。
-- 总结起来，这个文件的功能是配置和设置包管理器和依赖项相关的信息，并提供了一些按键映射来执行相应的操作。

return {
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("package-info").setup({
        package_manager = "pnpm",
        colors = {
          up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
          outdated = "#d19a66", -- Text color for outdated dependency virtual text
        },
        icons = {
          enable = true, -- Whether to display icons
          style = {
            up_to_date = "|  ", -- Icon for up to date dependencies
            outdated = "|  ", -- Icon for outdated dependencies
          },
        },
        autostart = true, -- Whether to autostart when `package.json` is opened
        hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
        hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      })

      require("telescope").setup({
        extensions = {
          package_info = {
            -- Optional theme (the extension doesn't set a default theme)
            theme = "ivy",
          },
        },
      })

      require("telescope").load_extension("package_info")

      -- Update dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nu",
        require("package-info").update,
        { silent = true, noremap = true, desc = "Update dependency on the line" }
      )

      -- Delete dependency on the line
      vim.keymap.set(
        { "n" },
        "<LEADER>nd",
        require("package-info").delete,
        { silent = true, noremap = true, desc = "Delete dependency on the line" }
      )

      -- Install a new dependency
      vim.keymap.set(
        { "n" },
        "<LEADER>ni",
        require("package-info").install,
        { silent = true, noremap = true, desc = "Install a new dependency" }
      )

      -- Install a different dependency version
      vim.keymap.set(
        { "n" },
        "<LEADER>np",
        require("package-info").change_version,
        { silent = true, noremap = true, desc = "Install a different dependency version" }
      )
    end,
  },
}
