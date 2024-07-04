-- 改进了 Neovim 的 Yank 和 Put 功能

-- 根据提供的代码，这个文件是一个 Lua 模块，用于改进 Neovim 编辑器的 Yank（复制）和 Put（粘贴）功能。它通过使用一个名为 "gbprod/yanky.nvim" 的插件来实现这些功能的增强。
-- 在模块的返回值中，我们可以看到一个包含了多个键值对的表。每个键值对代表一个配置项，用于定义 Yank 和 Put 功能的行为。
  -- 1. 首先，我们可以看到一个名为 "event" 的键值对，它指定了在何时触发这些功能的配置。在这个例子中，配置项是 "BufRead"，表示当打开一个新的缓冲区时触发。
  -- 2. 接下来，我们可以看到一个名为 "dependencies" 的键值对，它指定了插件的依赖项。在这个例子中，依赖项是 "kkharji/sqlite.lua" 插件，并且只有在不是 Windows 操作系统时才启用。
  -- 3. 然后，我们可以看到一个名为 "opts" 的键值对，它是一个函数，用于返回 Yank 和 Put 功能的配置选项。在这个函数中，首先通过引入 "yanky.telescope.mapping" 模块来获取默认的按键映射。然后，将默认的按键映射赋值给变量 "mappings"。接着，将一些特定的按键映射添加到 "mappings" 中，以定制 Yank 和 Put 功能的行为。最后，返回一个包含了各种配置选项的表。
  -- 4. 最后，我们可以看到一个名为 "keys" 的键值对，它包含了一系列按键映射。每个按键映射都有一个触发键、一个处理函数和一些其他的配置选项。这些按键映射定义了在不同的编辑模式下，如何触发 Yank 和 Put 功能以及它们的具体行为。
-- 综上所述，这个文件的功能是通过 "gbprod/yanky.nvim" 插件改进 Neovim 编辑器的 Yank 和 Put 功能。它通过配置选项和按键映射来定义这些功能的行为。

return {
  {

    "gbprod/yanky.nvim",
    event = "BufRead",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = function()
      local mapping = require("yanky.telescope.mapping")
      local mappings = mapping.get_defaults()
      mappings.i["<c-p>"] = nil
      return {
        highlight = { timer = 200 },
        ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = mappings,
          },
        },
      }
    end,
    keys = {
      -- stylua: ignore
      {
        "<leader>y",
        function() require("telescope").extensions.yank_history.yank_history({}) end,
        desc =
        "Open Yank History"
      },
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      {
        "<c-k>",
        "<Plug>(YankyCycleForward)",
        desc = "Cycle forward through yank history",
      },
      {
        "<c-j>",
        "<Plug>(YankyCycleBackward)",
        desc = "Cycle backward through yank history",
      },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        "]P",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[P",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        ">p",
        "<Plug>(YankyPutIndentAfterShiftRight)",
        desc = "Put and indent right",
      },
      {
        "<p",
        "<Plug>(YankyPutIndentAfterShiftLeft)",
        desc = "Put and indent left",
      },
      {
        ">P",
        "<Plug>(YankyPutIndentBeforeShiftRight)",
        desc = "Put before and indent right",
      },
      {
        "<P",
        "<Plug>(YankyPutIndentBeforeShiftLeft)",
        desc = "Put before and indent left",
      },
      {
        "=p",
        "<Plug>(YankyPutAfterFilter)",
        desc = "Put after applying a filter",
      },
      {
        "=P",
        "<Plug>(YankyPutBeforeFilter)",
        desc = "Put before applying a filter",
      },
    },
  },
}
