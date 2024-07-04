-- 更具冒险精神的狂野菜单

-- 这个文件是一个 Lua 脚本，它的功能是配置和设置一个叫做 "wilder.nvim" 的 Neovim 插件。该插件提供了一个增强的命令行模式补全功能。
-- 让我们来看一下这个文件的实现逻辑：
	-- 1. 首先，通过 require('wilder') 导入了 wilder 模块。
	-- 2. 然后，调用 wilder.setup 函数来配置插件的行为。在这里，设置了插件只在命令行模式下生效，使用 <Tab> 和 <S-Tab> 键来切换补全项。
	-- 3. 接下来，通过 wilder.set_option 函数设置了插件的选项。这里使用了 wilder.popupmenu_renderer 函数来设置补全菜单的样式和渲染方式。可以看到，菜单的样式包括了边框、左侧图标、右侧滚动条等。
	-- 4. 然后，通过 wilder.set_option 函数设置了插件的管道（pipeline）。这里使用了 wilder.branch 函数来创建一个管道分支，其中包含了两个子管道：wilder.cmdline_pipeline 和 wilder.search_pipeline。wilder.cmdline_pipeline 用于处理命令行输入的补全，而 wilder.search_pipeline 用于处理搜索输入的补全。
	-- 5. 最后，将整个配置封装在一个 Lua 表中，并通过 return 语句返回该表，使其可以被其他 Lua 脚本引用和使用。
-- 总结起来，这个文件的功能是配置和设置 "wilder.nvim" 插件的行为，包括补全菜单的样式、补全的触发方式以及补全的管道处理逻辑。

return {
	'gelguy/wilder.nvim',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local wilder = require('wilder')
		wilder.setup {
			modes = { ':' },
			next_key = '<Tab>',
			previous_key = '<S-Tab>',
		}
		wilder.set_option('renderer', wilder.popupmenu_renderer(
			wilder.popupmenu_palette_theme({
				highlights = {
					border = 'Normal', -- highlight to use for the border
				},
				left = { ' ', wilder.popupmenu_devicons() },
				right = { ' ', wilder.popupmenu_scrollbar() },
				border = 'rounded',
				max_height = '75%',  -- max height of the palette
				min_height = 0,      -- set to the same as 'max_height' for a fixed height window
				prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
				reverse = 0,         -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
			})
		))
		wilder.set_option('pipeline', {
			wilder.branch(
				wilder.cmdline_pipeline({
					language = 'vim',
					fuzzy = 1,
				}), wilder.search_pipeline()
			),
		})
	end
}
