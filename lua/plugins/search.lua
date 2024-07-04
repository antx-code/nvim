-- 根据提供的代码，这个文件似乎是一个Lua模块，返回一个包含多个插件配置的表。每个插件配置都包含插件名称、配置函数以及其他可选的键值对。
-- 这个文件的功能是配置一些插件，以增强编辑器的功能。每个插件都有自己的配置函数，用于设置插件的行为和快捷键绑定。
-- 让我们逐个插件来看一下：
	-- 1. kevinhwang91/nvim-hlslens 插件配置：
		--  - 在 build_position_cb 函数中，当光标移动到匹配项时，调用 scrollbar.handlers.search 模块的 show 函数来显示匹配项的位置。
		-- - 设置了一些快捷键绑定，用于在搜索匹配项时启动 hlslens 插件。
	-- 2. pechorin/any-jump.vim 插件配置：
		-- - 设置了 j 键的快捷键绑定，用于执行 AnyJump 命令。
		-- - 设置了 j 键在可视模式下的快捷键绑定，用于执行 AnyJumpVisual 命令。
		-- - 禁用了插件的默认快捷键绑定。
		-- - 设置了弹出窗口的宽度和高度比例。
	-- 3. nvim-pack/nvim-spectre 插件配置：
		-- - 定义了一个键值对，键是 <leader>F，值是一个包含了模式、函数和描述的表。
		-- - 当按下 <leader>F 键时，调用 spectre 模块的 open 函数，打开项目查找和替换的界面。
-- 总的来说，这个文件的目的是配置这些插件的行为和快捷键绑定，以增强编辑器的搜索、跳转和查找替换功能。

return {
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require('hlslens').setup({
				build_position_cb = function(plist, _, _, _)
					require("scrollbar.handlers.search").handler.show(plist.start_pos)
				end,
			})
			local kopts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap('n', '=',
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts)
			vim.api.nvim_set_keymap('n', '-',
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts)
			vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '<Leader><CR>', '<Cmd>noh<CR>', kopts)
		end
	},
	{
		"pechorin/any-jump.vim",
		config = function()
			vim.keymap.set("n", "j", ":AnyJump<CR>", { noremap = true })
			vim.keymap.set("x", "j", ":AnyJumpVisual<CR>", { noremap = true })
			vim.g.any_jump_disable_default_keybindings = true
			vim.g.any_jump_window_width_ratio = 0.9
			vim.g.any_jump_window_height_ratio = 0.9
		end
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>F",
				mode = "n",
				function()
					require("spectre").open()
				end,
				desc = "Project find and replace"
			}
		}
	}
}
