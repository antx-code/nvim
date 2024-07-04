-- 根据提供的代码，这个文件似乎是一个 Lua 表（table），其中包含了一些插件的配置信息。每个插件都表示为一个 Lua 表的元素，包含了插件的名称、按键绑定、配置函数等。
-- 让我们逐个解释这个文件的功能和实现逻辑：
  -- 1. 第一个插件是 "Eandrju/cellular-automaton.nvim"，它的按键绑定是 <leader>rr。在配置函数中，它使用 vim.keymap.set 函数将 <leader>rr 绑定到命令 <cmd>CellularAutomaton make_it_rain<CR>。这意味着当用户按下 <leader>rr 时，会执行名为 CellularAutomaton make_it_rain 的命令。
  -- 2. 第二个插件是 "tamton-aquib/duck.nvim"，它有两个按键绑定。第一个按键绑定是 <leader>dd，当用户按下该按键时，会执行一个函数 require("duck").hatch()。第二个按键绑定是 <leader>dk，当用户按下该按键时，会执行另一个函数 require("duck").cook()。这两个函数都属于 "duck" 模块，并且它们的描述都是 "Duck"。
  -- 3. 第三个插件是 "tamton-aquib/zone.nvim"，但是它被设置为禁用状态（enabled = false）。它还定义了一个事件 "VeryLazy"，但是没有给出具体的处理逻辑。在配置函数中，它调用了 require("zone").setup() 函数，可能是用来设置 "zone" 插件的配置。
-- 总的来说，这个文件的功能是配置一些插件，并为它们定义按键绑定和其他相关的配置。当用户按下相应的按键时，会执行相应的函数或命令。

return {
  {
    "Eandrju/cellular-automaton.nvim",
    keys = "<leader>rr",
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>dd",
        function()
          require("duck").hatch()
        end,
        desc = "Duck",
      },
      {
        "<leader>dk",
        function()
          require("duck").cook()
        end,
        desc = "Duck",
      },
    },
  },
  {
    "tamton-aquib/zone.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("zone").setup()
    end,
  },
}
