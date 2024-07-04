-- 适用于 Neovim 的精美、类似 IDE、高度可定制的 winbar
-- 具有下拉菜单支持和多个后端

-- 根据代码的注释和内容，这个文件实现了一个适用于 Neovim 的精美、类似 IDE、高度可定制的 winbar（窗口栏）插件。它具有下拉菜单支持和多个后端。
	-- 在 config 函数中，通过调用 require("dropbar.api") 来获取 api 模块，并设置了一些按键映射。其中，<Leader>; 绑定了 api.pick 函数，[c 绑定了 api.goto_context_start 函数，]c 绑定了 api.select_next_context 函数。
	-- 此外，还定义了一些辅助函数，如 confirm 和 quit_curr，用于处理点击和关闭操作。
	-- 最后，调用了 require("dropbar").setup() 来配置插件的参数，包括菜单的快速导航、按键映射等。
-- 总体来说，这个文件实现了一个功能强大且高度可定制的窗口栏插件，可以提供类似 IDE 的体验。根据代码的注释和内容，这个文件实现了一个适用于 Neovim 的精美、类似 IDE、高度可定制的 winbar（窗口栏）插件。它具有下拉菜单支持和多个后端。

return {
	"Bekaboo/dropbar.nvim",
	commit = "19011d96959cd40a7173485ee54202589760caae",
	config = function()
		local api = require("dropbar.api")
		vim.keymap.set('n', '<Leader>;', api.pick)
		vim.keymap.set('n', '[c', api.goto_context_start)
		vim.keymap.set('n', ']c', api.select_next_context)

		local confirm = function()
			local menu = api.get_current_dropbar_menu()
			if not menu then
				return
			end
			local cursor = vim.api.nvim_win_get_cursor(menu.win)
			local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
			if component then
				menu:click_on(component)
			end
		end

		local quit_curr = function()
			local menu = api.get_current_dropbar_menu()
			if menu then
				menu:close()
			end
		end

		require("dropbar").setup({
			menu = {
				-- When on, automatically set the cursor to the closest previous/next
				-- clickable component in the direction of cursor movement on CursorMoved
				quick_navigation = true,
				---@type table<string, string|function|table<string, string|function>>
				keymaps = {
					['<LeftMouse>'] = function()
						local menu = api.get_current_dropbar_menu()
						if not menu then
							return
						end
						local mouse = vim.fn.getmousepos()
						if mouse.winid ~= menu.win then
							local parent_menu = api.get_dropbar_menu(mouse.winid)
							if parent_menu and parent_menu.sub_menu then
								parent_menu.sub_menu:close()
							end
							if vim.api.nvim_win_is_valid(mouse.winid) then
								vim.api.nvim_set_current_win(mouse.winid)
							end
							return
						end
						menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
					end,
					['<CR>'] = confirm,
					['i'] = confirm,
					['<esc>'] = quit_curr,
					['q'] = quit_curr,
					['n'] = quit_curr,
					['<MouseMove>'] = function()
						local menu = api.get_current_dropbar_menu()
						if not menu then
							return
						end
						local mouse = vim.fn.getmousepos()
						if mouse.winid ~= menu.win then
							return
						end
						menu:update_hover_hl({ mouse.line, mouse.column - 1 })
					end,
				},
			},
		})
	end
}
