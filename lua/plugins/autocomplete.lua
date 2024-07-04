-- 用 Lua 编码的 neovim 补全插件。

-- 这个文件是一个 Lua 脚本，用于配置自动补全插件。它使用了 nvim-cmp 插件来实现自动补全功能，并且依赖其他插件来提供更多的补全源和功能。
-- 该脚本定义了一些辅助函数，如 has_words_before 和 limitStr，用于判断光标前是否有单词和限制字符串长度。
-- 接下来，定义了两个比较函数 lspkind_comparator 和 label_comparator，用于排序补全项。
-- 然后，定义了一个 Lua 模块 M，其中包含了配置信息和配置函数。配置信息包括插件名称、加载顺序和依赖插件列表。配置函数 M.configfunc 用于设置自动补全的各种选项，包括预选项、排序、格式化、补全源和按键映射。
-- 最后，返回了配置信息 M.config。
-- 总体来说，这个文件的功能是配置自动补全插件 nvim-cmp，并且通过其他插件提供更多的补全源和功能。

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end

local lspkind_comparator = function(conf)
	local lsp_types = require("cmp.types").lsp
	return function(entry1, entry2)
		if entry1.source.name ~= "nvim_lsp" then
			if entry2.source.name == "nvim_lsp" then
				return false
			else
				return nil
			end
		end
		local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
		local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

		local priority1 = conf.kind_priority[kind1] or 0
		local priority2 = conf.kind_priority[kind2] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority2 < priority1
	end
end

local label_comparator = function(entry1, entry2)
	return entry1.completion_item.label < entry2.completion_item.label
end

local M = {}
M.config = {
	"hrsh7th/nvim-cmp",
	after = "SirVer/ultisnips",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-calc",
		-- "andersevenrud/cmp-tmux",
		{
			"onsails/lspkind.nvim",
			lazy = false,
			config = function()
				require("lspkind").init()
			end,
		},
		{
			"quangnguyen30192/cmp-nvim-ultisnips",
			config = function()
				-- optional call to setup (see customization section)
				require("cmp_nvim_ultisnips").setup({})
			end,
		},
		-- "L3MON4D3/LuaSnip",
	},
}

local setCompHL = function()
	local fgdark = "#2E3440"

	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })

	vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
	vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
	vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

	vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

	vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
	vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
	vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#cccccc" })
	vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
	vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
	vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
	vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end

M.configfunc = function()
	local lspkind = require("lspkind")
	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	local cmp = require("cmp")
	local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
	-- local luasnip = require("luasnip")

	setCompHL()
	cmp.setup({
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				-- luasnip.lsp_expand(args.body)
				vim.fn["UltiSnips#Anon"](args.body)
			end,
		},
		window = {
			completion = {
				-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				col_offset = -3,
				side_padding = 0,
			},
			documentation = cmp.config.window.bordered(),
		},
		sorting = {
			comparators = {
				-- label_comparator,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				lspkind_comparator({
					kind_priority = {
						Field = 3,
						-- Variable = 2,
						-- Property = 11,
						-- Constant = 10,
						-- Enum = 10,
						-- EnumMember = 10,
						-- Event = 10,
						-- Function = 10,
						-- Method = 10,
						-- Operator = 10,
						-- Reference = 10,
						-- Struct = 10,
						-- File = 8,
						-- Folder = 8,
						-- Class = 5,
						-- Color = 5,
						-- Module = 5,
						-- Keyword = 2,
						-- Constructor = 1,
						-- Interface = 1,
						-- Snippet = 0,
						-- Text = 1,
						-- TypeParameter = 1,
						-- Unit = 1,
						-- Value = 1,
					},
				}),
				cmp.config.compare.kind,
			},
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			maxwidth = 60,
			maxheight = 10,
			format = function(entry, vim_item)
				local kind = lspkind.cmp_format({
					mode = "symbol_text",
					symbol_map = { Codeium = "" },
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = " " .. (strings[1] or "") .. " "
				kind.menu = limitStr(entry:get_completion_item().detail or "")

				return kind
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "buffer" },
		}, {
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "calc" },
			-- { name = "luasnip" },
			-- { name = 'tmux',    option = { all_panes = true, } },  -- this is kinda slow
		}),
		mapping = cmp.mapping.preset.insert({
			["<C-o>"] = cmp.mapping.complete(),
			["<c-e>"] = cmp.mapping(function()
				cmp_ultisnips_mappings.compose({ "expand", "jump_forwards" })(function() end)
			end, {
				"i",
				"s", --[[ "c" (to enable the mapping in command mode) ]]
			}),
			["<c-n>"] = cmp.mapping(function(fallback)
				cmp_ultisnips_mappings.jump_backwards(fallback)
			end, {
				"i",
				"s", --[[ "c" (to enable the mapping in command mode) ]]
			}),
			["<c-f>"] = cmp.mapping({
				i = function(fallback)
					cmp.close()
					fallback()
				end,
			}),
			["<c-y>"] = cmp.mapping({
				i = function(fallback)
					fallback()
				end,
			}),
			["<c-u>"] = cmp.mapping({
				i = function(fallback)
					fallback()
				end,
			}),
			["<CR>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
			}),
			["<Tab>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end,
			}),
			["<S-Tab>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					else
						fallback()
					end
				end,
			}),
		}),
	})
end

return M.config
