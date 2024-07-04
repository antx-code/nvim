-- 可将活动缓冲区导出到 VS Code的插件
-- 这是一个 Neovim 插件，它将获取所有活动缓冲区并在 VS Code 中将它们作为选项卡打开。它将确保 Neovim 的活动缓冲区是 VS Code 中的活动选项卡，具有相同的行和光标位置焦点。

return {
  {
    "elijahmanor/export-to-vscode.nvim",
    event = "BufReadPost",
    config = function()
      vim.api.nvim_create_user_command("Code", function()
        require("export-to-vscode").launch()
      end, {
        bang = true,
      })
    end,
  },
}
