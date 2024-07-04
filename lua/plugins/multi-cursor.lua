-- 根据代码的内容，这个文件是用来配置多光标插件的。它使用了两个不同的多光标插件：mg979/vim-visual-multi和smoka7/multicursors.nvim。
  -- 1. 第一个插件mg979/vim-visual-multi在初始化时设置了一些按键映射。这些映射定义了如何触发多光标操作，例如查找下一个匹配项、查找上一个匹配项、删除选区等。
  -- 2. 第二个插件smoka7/multicursors.nvim在初始化时定义了一些按键映射和选项。这些映射和选项用于在普通模式和插入模式下触发多光标操作。例如，按下<C-d>会创建一个选区来选择光标下的单词。
-- 总的来说，这个文件的功能是配置多光标插件的行为和按键映射，以便在编辑器中使用多光标操作

return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.cmd([[
  let g:VM_maps                       = {}
  let g:VM_maps['Find Under']         = '<C-d>'
  let g:VM_maps['Find Subword Under'] = '<C-d>'
  let g:VM_maps['Find Next']          = 'n'
  let g:VM_maps['Find Prev']          = 'p'
  let g:VM_maps['Remove Region']      = '<backspace>'
  let g:VM_maps['Skip Region']        = 'q'
  let g:VM_maps["Undo"]               = 'u'
  let g:VM_maps["Redo"]               = 'r'
  ]])
    end,
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "smoka7/hydra.nvim",
    },
    opts = function()
      local N = require("multicursors.normal_mode")
      local I = require("multicursors.insert_mode")
      return {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          [","] = {
            -- assigning nil to method exits from multi cursor mode
            method = N.clear_others,
            -- you can pass :map-arguments here
            opts = { desc = "Clear others" },
          },
        },
        insert_keys = {
          -- to change default lhs of key mapping change the key
          ["<CR>"] = {
            -- assigning nil to method exits from multi cursor mode
            method = I.Cr_method,
            -- you can pass :map-arguments here
            opts = { desc = "New line" },
          },
        },
      }
    end,
    keys = {
      {
        "<C-d>",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
}
