-- 使用 ray.so 在 Neovim 中创建代码片段

return {
  "TobinPalmer/rayso.nvim",
  cmd = "Rayso",
  config = function()
    require("rayso").setup({
      open_cmd = "Arc",
    })
  end,
}
