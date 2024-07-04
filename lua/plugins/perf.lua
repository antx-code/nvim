-- 根据提供的代码，这个文件是一个Lua模块，它返回一个包含配置信息的表。根据配置信息，它似乎是用于性能优化的。
-- 具体来说，这个Lua模块返回一个包含多个配置项的表。每个配置项都是一个包含名称、选项和禁用函数的表。这些配置项用于配置不同的功能和插件。
-- 在这个例子中，配置项包括：
  -- - "LunarVim/bigfile.nvim"：一个名为"LunarVim/bigfile.nvim"的插件，它的lazy选项被设置为false。
  -- - set_filetype_bigfile：一个用于设置文件类型的配置项，它包含一个disable函数，该函数在调用时会将文件类型设置为"bigfile"。
  -- - cmp：一个用于自动完成的配置项，它包含一个disable函数，该函数在调用时会禁用自动完成功能。
  -- - mini_indentscope：一个用于缩进范围的配置项，它包含一个disable函数，该函数在调用时会禁用缩进范围功能。
  -- - 此外，还有其他一些配置项，如filesize、pattern和features。filesize表示文件大小的阈值，pattern表示匹配文件的模式，features是一个包含多个功能名称的数组，用于启用不同的功能和插件。
-- 总体来说，这个文件的功能是根据提供的配置信息来优化编辑器的性能。它通过禁用某些功能和插件，以及根据文件大小和类型来选择性地启用功能，从而提高编辑器的响应速度和效率。

return {
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    opts = function()
      local set_filetype_bigfile = {
        name = "detect_bigfile",
        opts = { defer = true },
        disable = function()
          vim.api.nvim_set_option_value("filetype", "bigfile", { scope = "local" })
        end,
      }

      local cmp = {
        name = "cmp",
        opts = { defer = true },
        disable = function()
          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.setup.buffer({ enabled = false })
          end
        end,
      }

      local mini_indentscope = {
        name = "mini_indentscope",
        opts = { defer = true },
        disable = function()
          vim.b.miniindentscope_disable = true
        end,
      }

      return {
        filesize = 0.5, -- unit MB
        pattern = { "*" },
        features = {
          "treesitter",
          "lsp",
          "illuminate",
          "indent_blankline",
          "syntax",
          "vimopts",
          set_filetype_bigfile,
          cmp,
          mini_indentscope,
        },
      }
    end,
  },
}
