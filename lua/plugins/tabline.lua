-- 使用 lua 构建的 Neovim 的时髦缓冲线（带有标签页集成）

-- 根据提供的代码，这个文件的功能是配置 akinsho/bufferline.nvim 插件的选项。bufferline.nvim 是一个用于在 Neovim 编辑器中显示缓冲区标签的插件。
-- 在这个文件中，我们返回一个 Lua 表，其中包含了配置选项。这些选项将被传递给 bufferline.nvim 插件，以定制标签栏的外观和行为。
-- 让我们逐个解释这些选项的含义和实现逻辑：
	-- version = "*"：指定 bufferline.nvim 插件的版本为最新版本。
	-- dependencies = 'nvim-tree/nvim-web-devicons'：指定 bufferline.nvim 插件的依赖项为 nvim-tree/nvim-web-devicons 插件。这个插件用于在标签栏中显示文件图标。
	-- opts：这是一个包含选项的 Lua 表。
		-- options：这是一个包含更多选项的 Lua 表。
			-- mode = "tabs"：设置标签栏的显示模式为 "tabs"，即以标签页的形式显示缓冲区。
			-- diagnostics = "nvim_lsp"：设置诊断信息的来源为 Neovim 的内置 LSP（Language Server Protocol）。这将允许在标签栏中显示与代码错误和警告相关的诊断信息。
			-- diagnostics_indicator：这是一个函数，用于自定义诊断信息指示器的显示。根据诊断信息的级别，它会显示不同的图标。
			-- indicator：这是一个包含指示器选项的 Lua 表。
				-- icon = '▎'：设置指示器的图标为一个竖线。
				-- style = "icon"：设置指示器的样式为图标样式。
			-- show_buffer_close_icons = false：禁用显示缓冲区关闭图标。
			-- show_close_icon = false：禁用显示标签页关闭图标。
			-- enforce_regular_tabs = true：强制使用普通的标签页而不是分离的标签页。
			-- show_duplicate_prefix = false：禁用显示重复缓冲区的前缀。
			-- tab_size = 16：设置标签页的宽度为 16 个字符。
			-- padding = 0：设置标签页的内边距为 0。
			-- separator_style = "thick"：设置分隔符的样式为粗线样式。
-- 通过这些选项的配置，我们可以自定义 bufferline.nvim 插件的行为，以满足我们的需求并改善编辑器的用户体验。

return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	opts = {
		options = {
			mode = "tabs",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			indicator = {
				icon = '▎', -- this should be omitted if indicator style is not 'icon'
				-- style = 'icon' | 'underline' | 'none',
				style = "icon",
			},
			show_buffer_close_icons = false,
			show_close_icon = false,
			enforce_regular_tabs = true,
			show_duplicate_prefix = false,
			tab_size = 16,
			padding = 0,
			separator_style = "thick",
		}
	}
}
