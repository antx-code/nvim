-- rainbowhxch/accelerated-jk.nvim: 一个加速上下移动的 neovim 插件！
-- jghauser/mkdir.nvim: 这个 neovim 插件在保存时会创建丢失的文件夹。（类似于 Linux 上的 mkdir -p ）
-- willothy/flatten.nvim: 从当前 neovim 实例中的 wezterm、kitty 和 neovim 终端打开文件和命令输出
-- sontungexpt/url-open: 该插件使您能够轻松地在 Neovim 中打开光标下的 URL，绕过 netrw 的需要，而是利用系统的默认浏览器。它提供了自动检测和突出显示文本内容中的所有 URL 的便利。

return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
    vscode = true,
  },
  -- {
  --   "tpope/vim-sleuth",
  --   event = "InsertEnter",
  -- },

  -- save if not folder exists
  {
    "jghauser/mkdir.nvim",
    event = "VeryLazy",
  },
  -- open in current nvim if open file in float terminal
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },

  {
    "https://git.sr.ht/~reggie/licenses.nvim",
    cmd = {
      "LicenseInsert",
      "LicenseFetch",
      "LicenseUpdate",
      "LicenseWrite",
    },
    config = function()
      require("licenses").setup({
        copyright_holder = "antx-code",
        email = "wkaifeng2007@gmail.com",
        license = "MIT",
      })
    end,
  },

  {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({})
      vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")
    end,
  },
}
