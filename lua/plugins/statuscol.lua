-- 状态列插件，提供可配置的“状态列”和单击处理程序。
-- 状态列包含没有折叠深度数字的折叠列、仅显示诊断标志的自定义标志段、具有右对齐相对数字的数字列以及仅 1 个单元格宽的显示所有其他标志的标志段。

-- 根据提供的代码，这个文件的功能是配置一个名为"statuscol.nvim"的插件。该插件用于自定义状态栏的外观和行为。
-- 实现逻辑如下：
  -- 1. 首先，通过require("statuscol.builtin")引入了一个名为"builtin"的模块。
  -- 2. 然后，调用require("statuscol").setup({...})方法来设置插件的配置选项。
  -- 3. 在配置选项中，有一些属性被设置为特定的值，例如lazy = false表示插件不是延迟加载的，enabled = true表示插件是启用的。
  -- 4. ft_ignore属性设置为require("utils.ft").exclude_ft，这里可能是引入了一个名为"utils.ft"的模块，并使用了它的exclude_ft函数。
  -- 5. bt_ignore属性设置为一个包含字符串元素的数组，表示在状态栏中忽略的缓冲区类型。
  -- 6. relculright属性设置为true，表示状态栏中的相对行号显示在右侧。
  -- 7. segments属性是一个包含多个段落的数组，每个段落都有不同的显示内容和点击行为。
    -- - 第一个段落使用了sign属性，其中name属性设置为{ "smoothcursor*" }，表示显示名为"smoothcursor*"的符号。
    -- - 第二个段落使用了text属性，其中builtin.foldfunc是一个函数，表示显示自定义的折叠函数。
    -- - 第三个段落只显示一个空格。
    -- - 第四个段落使用了sign属性，其中name属性设置为{ "Diagnostic" }，表示显示名为"Diagnostic"的符号。
    -- - 第五个段落使用了sign属性，其中name属性设置为{ ".*" }，表示显示任意名字的符号。
    -- - 第六个段落使用了text属性，其中builtin.lnumfunc是一个函数，表示显示自定义的行号函数。
    -- - 第七个段落只显示一个空格。
    -- - 第八个段落使用了sign属性，其中name属性设置为{ ".*" }，namespace属性设置为{ "gitsigns_extmark_signs_" }，表示显示任意名字的符号，并且限定了命名空间为"gitsigns_extmark_signs_"。
    -- - 最后一个段落被注释掉了，可能是暂时不需要使用。
-- 总体来说，这个文件的功能是配置"statuscol.nvim"插件的外观和行为，通过设置不同的段落来显示不同的内容，并且可以通过点击行为执行相应的操作。

return {
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    enabled = true,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        ft_ignore = require("utils.ft").exclude_ft,
        bt_ignore = { "terminal", "nofile" },
        relculright = true,
        segments = {
          {
            sign = {
              name = { "smoothcursor*" },
              auto = false,
              wrap = true,
              maxwidth = 1,
              colwidth = 1,
            },
          },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa", auto = false },
          { text = { " " } },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 1, colwidth = 0, auto = true },
            click = "v:lua.ScSa",
          },
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, wrap = true, auto = true },
            click = "v:lua.ScSa",
          },

          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", auto = true, wrap = true },

          {
            text = { " " },
          },
          {
            sign = {
              name = { ".*" },
              namespace = { "gitsigns_extmark_signs_" },
              text = { ".*" },
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          -- {
          --   sign = {
          --     name = { "GitSigns*" },
          --     auto = false,
          --   },
          --   click = "v:lua.ScSa",
          -- },
        },
      })
    end,
  },
}
