-- 这个文件是一个 Lua 脚本，它返回一个 Lua 表（table）。这个表中包含了一些配置信息和设置函数。
-- 这个 Lua 脚本的功能是配置和设置一个叫做 "mason" 的插件。它使用了两个插件：williamboman/mason.nvim 和 williamboman/mason-lspconfig.nvim。
	-- 1. 首先，它设置了 "mason" 插件的 UI 配置，其中包含了一些图标的定义。这些图标用于表示软件包的安装状态，分别是已安装、待安装和未安装。
	-- 2. 接下来，它使用了 "mason-lspconfig" 插件，并进行了一些配置。这个插件用于自动安装和配置一些语言服务器（Language Server），以提供代码补全、语法检查等功能。它指定了一些语言服务器的名称，如 "lua_ls"、"bashls"、"jsonls" 等，并设置了自动安装的选项。
-- 总的来说，这个 Lua 脚本的作用是配置和设置 "mason" 插件以及相关的语言服务器插件，以提供更好的编辑器功能和开发体验。

return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim", build = ":MasonUpdate" },
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				}
			}
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"ast_grep",
				"bashls",
				"clangd",
				"cmake",
				"dockerls",
				"docker_compose_language_service",
				"gopls",
				"rome",
				"tailwindcss",
				"ltex",
				"lua_ls",
				"grammarly",
				"matlab_ls",
				"textlsp",
				"pyright",
				"ruff",
				"rust_analyzer",
				"tsserver",
				"taplo",
				"yamlls",
			},
			automatic_installation = true,
		})
	end,
}
