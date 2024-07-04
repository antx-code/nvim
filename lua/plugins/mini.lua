-- Neovim Lua 插件，用方括号前进/后退。 “mini.nvim”库的一部分。

return {
  {
    "echasnovski/mini.bracketed",
    version = "*",
    event = "BufReadPost",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
}
