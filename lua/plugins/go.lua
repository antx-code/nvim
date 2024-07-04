-- 这个文件是一个 Lua 脚本，它返回一个 Lua 表（table）。这个表中包含了一个配置项，用于设置 Go 开发环境的相关配置。
-- 首先，这个配置项使用了 ray-x/go.nvim 插件，它是一个用于提供 Go 开发支持的 Neovim 插件。在这个配置项中，还可以选择性地添加一些依赖包，例如 ray-x/guihua.lua、neovim/nvim-lspconfig 和 nvim-treesitter/nvim-treesitter。
-- 接下来，配置项中定义了一个 config 函数。这个函数用于设置 Go 插件的配置。在这个例子中，require("go").setup({}) 被调用，用于初始化 Go 插件的设置。
-- 然后，使用 vim.api.nvim_create_augroup 函数创建了一个名为 "GoImport" 的自动命令组。接着，使用 vim.api.nvim_create_autocmd 函数创建了一个自动命令。这个自动命令在保存 Go 文件（后缀名为 .go）之前触发，并调用了 require("go.format").goimport() 函数，用于自动导入 Go 文件中缺失的包。
-- 最后，配置项中定义了一个 ft 字段，它是一个包含了字符串 "go" 和 "gomod" 的数组。这表示这个配置项适用于 Go 和 Go Modules 文件。
-- 此外，还定义了一个 build 字段，它的值是一个字符串 ':lua require("go.install").update_all_sync()'。这个字符串表示在需要安装或更新所有 Go 相关的二进制文件时，可以执行这个命令。
-- 总结起来，这个文件的功能是配置 Go 开发环境，包括安装插件、设置自动命令以及定义适用的文件类型。

return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({})

      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
