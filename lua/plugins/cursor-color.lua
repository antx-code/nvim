-- 适合喜欢冒险的 vim 用户的棱柱线装饰

-- 这个文件的功能是配置一个名为 "mvllow/modes.nvim" 的插件，并在特定事件 "BufEnter" 发生时执行配置。该插件用于设置编辑器中不同模式下的光标颜色、光标行的透明度、光标行的高亮以及行号的高亮等。
-- 具体的实现逻辑如下：
  -- 1. 首先，通过调用 require("modes").setup() 方法来设置插件的配置项。
  -- 2. 在配置项中，通过指定不同模式下的颜色来设置光标的颜色。在这个例子中，"insert" 模式下的光标颜色为 "#75C2F6"，"visual" 模式下的光标颜色为 "#FF2171"。
  -- 3. 通过设置 line_opacity 参数来控制光标行的透明度。在这个例子中，光标行的透明度为 0.3。
  -- 4. 通过设置 set_cursor 参数为 true 来启用光标的高亮。
  -- 5. 通过设置 set_cursorline 参数为 true 来启用光标行的高亮。同时，对于非活动窗口或被忽略的文件类型，光标行的高亮将被禁用。
  -- 6. 通过设置 set_number 参数为 true 来启用行号的高亮。行号的高亮将与光标行的高亮相匹配。
  -- 7. 通过设置 ignore_filetypes 参数来指定在某些文件类型中禁用模式的高亮。在这个例子中，使用了一个名为 require("utils.ft").exclude_ft 的函数来获取需要忽略的文件类型列表。
-- 通过这些配置，插件将根据不同的模式和文件类型来设置编辑器的外观，以提供更好的编辑体验。

return {
  "mvllow/modes.nvim",
  event = "BufEnter",
  enabled = false,
  config = function()
    require("modes").setup({
      colors = {
        insert = "#75C2F6",
        visual = "#FF2171",
      },

      -- Set opacity for cursorline and number background
      line_opacity = 0.3,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore_filetypes = require("utils.ft").exclude_ft,
    })
  end,
}
