-- 根据提供的代码，这个文件的功能是配置一个名为"NvChad/nvim-colorizer.lua"的插件。该插件用于在编辑器中对不同文件类型的颜色进行着色。
-- 代码中的返回值是一个包含配置信息的Lua表。该表中有一个元素，它是一个包含插件配置的Lua表。配置中包含了一些选项，用于定义插件的行为。
-- 插件的配置选项包括：
  -- - filetypes：一个包含文件类型的列表，表示要对哪些文件类型进行颜色着色。在这个例子中，"*"表示对所有文件类型进行着色。
  -- - user_default_options：一个包含用户自定义选项的Lua表，用于指定颜色着色的具体行为。这些选项包括对不同类型的颜色代码的支持，如RGB、RRGGBB、AARRGGBB等，以及对CSS样式的支持。
  -- - mode：一个字符串，表示颜色着色的显示模式。在这个例子中，使用了"virtualtext"模式，表示使用虚拟文本的方式显示颜色着色。
  -- - tailwind：一个布尔值，表示是否启用Tailwind CSS的颜色支持。
  -- - sass：一个包含enable字段的Lua表，表示是否启用Sass的颜色支持。
  -- - virtualtext：一个字符串，表示虚拟文本的显示样式。在这个例子中，使用了"■"作为虚拟文本的显示符号。
-- 通过这些配置选项，插件可以根据用户的需求对不同文件类型进行颜色着色，并以虚拟文本的形式在编辑器中显示着色结果。

return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
}
