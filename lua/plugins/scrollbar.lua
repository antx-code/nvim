-- 这个文件的功能是配置一个名为 nvim-scrollbar 的插件。它是一个用于在 Neovim 编辑器中显示滚动条的插件。该插件的实现逻辑如下：
	-- 1. 首先，它引入了一个名为 kevinhwang91/nvim-hlslens 的依赖插件。
	-- 2. 接下来，它创建了一个名为 scrollbar_set_git_colors 的自动命令组，并将其存储在 group 变量中。
	-- 3. 然后，它创建了一个 BufEnter 自动命令，该命令会在进入缓冲区时触发。它使用了一个通配符模式 * 来匹配所有缓冲区，并指定了一个回调函数。
	-- 4. 在回调函数中，它使用 vim.cmd 函数执行了一系列命令，用于设置滚动条的颜色。这些命令使用了 hi! 命令来定义了一些高亮组，并为每个高亮组指定了前景色。
	-- 5. 接下来，它引入了一些名为 scrollbar.handlers.search、scrollbar.handlers.gitsigns 和 scrollbar 的模块，并调用了它们的 setup 函数进行配置。
	-- 6. 最后，它调用了 scrollbar 模块的 setup 函数，并传入了一个包含各种配置选项的表。这些配置选项包括是否显示滚动条、滚动条的样式、标记的颜色以及各种处理程序的开关。
-- 总体来说，这个文件的作用是配置 nvim-scrollbar 插件，并设置滚动条的颜色、样式和其他相关选项。

return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		local group = vim.api.nvim_create_augroup("scrollbar_set_git_colors", {})
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				vim.cmd([[
        hi! ScrollbarGitAdd guifg=#8CC85F
        hi! ScrollbarGitAddHandle guifg=#A0CF5D
        hi! ScrollbarGitChange guifg=#E6B450
        hi! ScrollbarGitChangeHandle guifg=#F0C454
        hi! ScrollbarGitDelete guifg=#F87070
        hi! ScrollbarGitDeleteHandle guifg=#FF7B7B ]])
			end,
			group = group,
		})
		require("scrollbar.handlers.search").setup({})
		require("scrollbar.handlers.gitsigns").setup()
		require("scrollbar").setup({
			show = true,
			handle = {
				text = " ",
				color = "#928374",
				hide_if_all_visible = true,
			},
			marks = {
				Search = { color = "yellow" },
				Misc = { color = "purple" },
			},
			handlers = {
				cursor = false,
				diagnostic = true,
				gitsigns = true,
				handle = true,
				search = true,
			},
		})
	end,
}
