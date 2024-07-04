-- 针对拼写错误提出文件建议
-- Typo.nvim 是一个插件，它可以解决在 Neovim 中打开文件时的常见拼写错误，并建议您可能打算加载的文件。

return {
  {
    -- open file typo
    "axieax/typo.nvim",
    config = function()
      require("typo").setup()
    end,
  },
}
