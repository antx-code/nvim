-- 这个插件是 github/copilot.vim 的纯 lua 替代品。，配有用于与 Github Copilot 交互的 API

-- 根据提供的代码，这个文件是一个 Lua 配置文件，用于配置一个名为 "copilot.lua" 的插件。该插件的功能是提供代码建议和自动补全功能，以提高编码效率。
-- 插件的配置通过调用 require("copilot").setup() 函数来完成。在 setup() 函数中，可以设置各种选项来自定义插件的行为。
-- 在提供的代码中，以下是一些配置选项的说明：
  -- - suggestion.enabled：设置为 true，启用代码建议功能。
  -- - suggestion.auto_trigger：设置为 true，启用自动触发代码建议功能。
  -- - suggestion.debounce：设置为 75，表示在用户输入后的 75 毫秒内，不会触发代码建议。
  -- - suggestion.keymap：定义了一些按键映射，用于接受建议、切换到下一个建议、切换到上一个建议等操作。
-- 通过这些配置选项，可以根据个人喜好和需求来自定义插件的行为。例如，可以更改按键映射，调整自动触发的延迟时间，或者禁用某些功能。
-- 总之，这个 Lua 配置文件用于配置一个名为 "copilot.lua" 的插件，该插件提供代码建议和自动补全功能，并通过配置选项来自定义插件的行为。

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    config = function()
      require("copilot").setup({

        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-c>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
}
