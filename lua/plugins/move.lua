-- 根据提供的代码，这个文件似乎是一个 Lua 脚本，用于配置 fedepujol/move.nvim 插件。这个插件提供了一些命令，可以在 Vim 或 Neovim 编辑器中移动行或块。
-- 在这个配置中，通过设置 event = "VeryLazy"，将配置应用于 VeryLazy 事件。然后，在 config 函数中，定义了一些按键映射，用于触发移动命令。
-- 具体来说，以下是按键映射的含义：
  -- 在普通模式下：
    -- <A-k> 键绑定到 :MoveLine(-1)<CR>，表示向上移动一行。
    -- <A-j> 键绑定到 :MoveLine(1)<CR>，表示向下移动一行。
  -- 在可视模式下：
    -- <A-j> 键绑定到 :MoveBlock(1)<CR>，表示向下移动一个块。
    -- <A-k> 键绑定到 :MoveBlock(-1)<CR>，表示向上移动一个块。
-- 这样，当用户在 Vim 或 Neovim 编辑器中按下相应的快捷键时，就会触发对应的移动命令，从而实现行或块的移动功能。

return {
  {
    "fedepujol/move.nvim",
    event = "VeryLazy",
    config = function()
      local opts = { noremap = true, silent = true }
      -- Normal-mode commands
      vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
      vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)

      -- Visual-mode commands
      vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
      vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
    end,
  },
}
