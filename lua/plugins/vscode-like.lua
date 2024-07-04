-- ghillb/cybu.nvim:
  -- Neovim 插件以可自定义通知窗口的形式在循环缓冲区时提供上下文。
  -- Cy[cle]buff[ffer].nvim 提供两种模式。
  -- 第一个本质上是 :bnext 和 :bprevious 的包装，它添加了一个可自定义的通知窗口，显示焦点缓冲区及其邻居，以便在循环缓冲区列表时提供上下文提供插件命令/按键绑定。
  -- 第二种模式添加了提供上下文的相同可定制窗口，但缓冲区列表按上次使用的顺序排列。它更类似于网络浏览器可能提供的 [Ctrl] + [Tab] 功能。

-- wsdjeg/vim-fetch:
  -- 让 Vim 轻松处理文件名中的行号和列号
  -- vim-fetch 使 Vim 能够处理文件路径中的行和列跳转规范，如堆栈跟踪和类似输出中找到的那样。当要求在 Vim 内部或外部或通过 gF 打开这样的文件时，使用 vim-fetch 的 Vim 将跳转到指定的行（和列，如果给定的话），而不是显示一个空的新文件。

-- 根据提供的代码，这个文件似乎是一个 Lua 脚本，用于配置 Neovim 编辑器的插件。它定义了一个 Lua 表（table），其中包含了两个插件的配置信息。
  -- 1. 第一个插件是 "ghillb/cybu.nvim"，它提供了类似于 Visual Studio Code 的标签导航功能。这个插件可以在循环缓冲区（Cycle Buffer）中显示焦点缓冲区及其邻居，以提供上下文。它还添加了一个可自定义的通知窗口，用于显示循环缓冲区列表时的插件命令和按键绑定。该插件的配置函数中，通过调用 cybu.setup() 来设置插件。
  -- 2. 第二个插件是 "wsdjeg/vim-fetch"，它提供了一个命令 :Fetch，用于在编辑器中打开指定路径的文件，并将光标定位到指定的行和列。这个插件的配置中，通过设置 event = "VeryLazy" 来指定插件在编辑器的 "VeryLazy" 事件中被加载。
-- 总体来说，这个文件的功能是配置 Neovim 编辑器的插件，其中包括一个类似于 Visual Studio Code 的标签导航插件和一个文件路径跳转插件。

return {
  -- vscode like tab navigation
  {

    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    -- branch = "v1.x", -- won't receive breaking changes
    requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    config = function()
      local cybu = require("cybu")
      cybu.setup()
      -- vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
      -- vim.keymap.set("n", "J", "<Plug>(CybuNext)")
      vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
      vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
    end,
  },

  -- e path:row:col
  {
    "wsdjeg/vim-fetch",
    event = "VeryLazy",
  },
}
