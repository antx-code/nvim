-- 根据提供的代码，这个文件似乎是一个 Lua 模块，用于配置和初始化一个名为 "joshuto.nvim" 的 Neovim 插件。该插件可能提供了一些功能，用于增强编辑器的体验。
-- 在代码中，我们可以看到一个 Lua 表（table），其中包含了一些键值对。键值对的作用是配置插件的不同选项。让我们逐个解释这些选项的含义：
	-- - "theniceboy/joshuto.nvim"：这是插件的名称或路径。它告诉 Neovim 在安装插件时从哪里获取插件的源代码。
	-- - lazy = true：这个选项告诉 Neovim 在启动时不立即加载插件，而是在需要时再进行加载。这可以提高启动速度，特别是对于大型插件。
	-- - cmd = "Joshuto"：这个选项定义了一个命令，当用户在 Neovim 中执行该命令时，插件将被激活。在这种情况下，当用户执行 :Joshuto 命令时，插件将被激活。
	-- - config = function()：这个选项定义了一个函数，用于配置插件的各种选项。在这个函数中，我们可以看到一些注释掉的代码行，它们可能是插件的默认配置选项。然后，我们可以看到一些使用 vim.g 语法的代码行，它们用于设置全局变量，以配置插件的行为。在这个例子中，我们设置了一些与浮动窗口、缩放因子和 Neovim 远程支持相关的选项。
-- 总的来说，这个文件的功能是配置和初始化 "joshuto.nvim" 插件。它通过设置一些选项来自定义插件的行为，并在需要时激活插件。

return {
	"theniceboy/joshuto.nvim",
	lazy = true,
	cmd = "Joshuto",
	config = function()
		-- let g:joshuto_floating_window_winblend = 0
		-- let g:joshuto_floating_window_scaling_factor = 1.0
		-- let g:joshuto_use_neovim_remote = 1 " for neovim-remote support
		vim.g.joshuto_floating_window_scaling_factor = 1.0
		vim.g.joshuto_use_neovim_remote = 1
		vim.g.joshuto_floating_window_winblend = 0
	end
}
