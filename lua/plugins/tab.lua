-- 增强您的工作流程，立即开始从括号、引号和类似上下文中跳出。

-- 这个文件的功能是配置一个叫做"tabout.nvim"的插件。该插件可以在编辑器中按下Tab键时，自动补全一些常见的代码片段，比如引号、括号等。它还提供了一些配置选项，可以根据个人喜好进行自定义。
-- 实现逻辑如下：
  -- 1. 首先，通过require("tabout").setup({...})来设置插件的配置选项。
  -- 2. 在配置选项中，可以设置触发自动补全的按键，比如tabkey表示按下Tab键时触发自动补全，backwards_tabkey表示按下Shift+Tab键时触发自动补全。
  -- 3. 可以设置是否在无法进行自动补全时，将内容向左或向右进行移动，通过act_as_tab和act_as_shift_tab来控制。
  -- 4. 可以设置默认的补全动作，比如在行首按下Tab键时的默认动作，通过default_tab和default_shift_tab来设置。
  -- 5. 可以设置一些特定的代码片段，比如引号、括号等，通过tabouts数组来配置。
  -- 6. 可以设置是否忽略光标位于已填充元素开头时的自动补全，通过ignore_beginning来控制。
  -- 7. 可以设置需要忽略的文件类型，通过exclude数组来配置。
-- 通过这些配置选项，可以根据个人的编码习惯和需求，定制插件的行为。

return {
  {
    "abecodes/tabout.nvim",

    enabled = false,
    event = "VeryLazy",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
  },
}
