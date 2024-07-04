-- nvim-zh/colorful-winsep.nvim:让您的 nvim 窗口分隔符变得丰富多彩。该插件将为活动窗口的边框着色，就像 tmux 对不同窗格所做的那样。
-- nyngwang/NeoZoom.lua: 可以帮助您集中注意力……也许还可以保护您左旋的颈部。浮动窗口的一个简单用例可帮助您集中注意力。

-- 根据提供的代码，这个文件的功能是配置一些插件，以实现丰富多彩的窗口分隔符和浮动窗口的缩放功能。
-- 文件中的代码是一个Lua表，其中包含了两个插件的配置信息。每个插件都由一个包名和一些配置选项组成。
	-- 1. 第一个插件是nvim-zh/colorful-winsep.nvim，它会在活动窗口的边框上添加颜色，类似于tmux对不同窗格所做的效果。该插件的配置选项包括设置为true，以及在WinNew事件发生时触发。
	-- 2. 第二个插件是nyngwang/NeoZoom.lua，它提供了浮动窗口的缩放功能。该插件的配置选项是一个函数，其中包含了一些具体的配置设置。在函数内部，首先通过vim.keymap.set函数设置了一个快捷键映射，当按下<leader>f时，会执行:NeoZoomToggle<CR>命令。然后，通过require('neo-zoom').setup函数对插件进行了更详细的配置。
-- 在插件的配置中，可以看到一些选项的设置，例如popup、exclude_buftypes和winopts等。这些选项可以根据需要进行调整，以满足个人的偏好和需求。
-- 总的来说，这个文件的功能是配置两个插件，使得窗口分隔符变得丰富多彩，并且提供了浮动窗口的缩放功能。通过对插件的配置选项进行设置，可以自定义插件的行为和外观。

return {
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinNew" },
	},
	{
		"nyngwang/NeoZoom.lua",
		config = function()
			vim.keymap.set('n', '<leader>f', ':NeoZoomToggle<CR>', { silent = true, nowait = true })
			require('neo-zoom').setup {
				popup = { enabled = true }, -- this is the default.
				-- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
				-- EXPLAIN: This improves the performance, and you won't see two
				--          identical buffers got updated at the same time.
				-- popup = {
				--   enabled = true,
				--   exclude_filetypes = {},
				--   exclude_buftypes = {},
				-- },
				exclude_buftypes = { 'terminal' },
				-- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
				winopts = {
					offset = {
						-- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
						-- top = 0,
						-- left = 0.17,
						width = 1.0,
						height = 1.0,
					},
					-- NOTE: check :help nvim_open_win() for possible border values.
					border = 'thicc', -- this is a preset, try it :)
				},
				presets = {
					-- {
					-- 	-- NOTE: regex pattern can be used here!
					-- 	filetypes = { 'dapui_.*', 'dap-repl' },
					-- 	winopts = {
					-- 		offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
					-- 	},
					-- },
					{
						filetypes = { 'markdown' },
						callbacks = {
							function() vim.wo.wrap = true end,
						},
					},
				},
			}
		end
	}
}
