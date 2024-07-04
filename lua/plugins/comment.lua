-- 一个可扩展和通用的评论 vim 插件，还可以处理嵌入的文件类型

-- 根据提供的代码，这个文件是一个 Lua 模块，它返回一个包含配置信息的表。根据代码中的注释，这个模块的功能是为 Vim 编辑器添加注释功能。
-- 在配置函数 config 中，有几个关键的设置被执行了：
	-- 1. vim.g.tcomment_maps = true：这行代码设置了一个全局变量 tcomment_maps 的值为 true。根据这个设置，Vim 将会为注释功能创建一些键盘映射。
	-- 2. vim.g.tcomment_textobject_inlinecomment = ''：这行代码设置了一个全局变量 tcomment_textobject_inlinecomment 的值为空字符串。这个设置可能会影响注释功能的行为，但是在提供的代码中没有给出具体的说明。
	-- 3. vim.cmd([[...]])：这个函数调用执行了一系列 Vim 命令。在这个例子中，它执行了一些键盘映射的设置。这些键盘映射将 <LEADER>cn 映射到 g>c，<LEADER>cu 映射到 g<c，<LEADER>cn 映射到 g>，<LEADER>cu 映射到 g<。这些映射可能会在编辑器中触发注释功能。
-- 总的来说，这个文件的目的是为 Vim 编辑器添加注释功能，并通过一些键盘映射来触发这些功能。

return {
	"tomtom/tcomment_vim",
	event = "BufRead",
	config = function()
		vim.g.tcomment_maps = true
		vim.g.tcomment_textobject_inlinecomment = ''

		vim.cmd([[
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<
unmap ic
		]])
	end
}
