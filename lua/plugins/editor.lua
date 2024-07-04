-- 这个文件是用于配置 Neovim 编辑器的插件。它包含了一些插件的配置信息和初始化代码。
-- 具体来说，这个文件做了以下几件事情：
	-- 1. 定义了一个函数 s:MakePair()，用于在编辑器中自动补全一些字符对，比如在输入分号或逗号后自动补全相应的分号或逗号。
	-- 2. 定义了一个键盘映射，将 <c-u> 绑定到调用 s:MakePair() 函数的操作。
	-- 3. 配置了插件 "RRethy/vim-illuminate"，并设置了一些参数和样式。
	-- 4. 配置了插件 "dkarter/bullets.vim"，并指定了一些文件类型。
	-- 5. 配置了插件 "NvChad/nvim-colorizer.lua"，并设置了一些选项。
	-- 6. 配置了插件 "theniceboy/antovim"，并定义了一些键盘映射。
	-- 7. 配置了插件 "gcmt/wildfire.vim"。
	-- 8. 配置了插件 "fedepujol/move.nvim"，并定义了一些键盘映射。
	-- 9. 配置了插件 "gbprod/substitute.nvim"，并定义了一些键盘映射。
	-- 10. 配置了插件 "kevinhwang91/nvim-ufo"，并设置了一些选项。
	-- 11. 配置了插件 "windwp/nvim-autopairs"。
-- 这些配置和初始化代码会在 Neovim 启动时被执行，以便插件能够正常工作和提供相应的功能。

vim.cmd([[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]])

return {
	{
		"RRethy/vim-illuminate",
		config = function()
			require('illuminate').configure({
				providers = {
					-- 'lsp',
					-- 'treesitter',
					'regex',
				},
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
		end
	},
	{
		"dkarter/bullets.vim",
		lazy = false,
		ft = { "markdown", "txt" },
	},
	-- {
	-- 	"psliwka/vim-smoothie",
	-- 	init = function()
	-- 		vim.cmd([[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]])
	-- 		vim.cmd([[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]])
	-- 	end
	-- },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,       -- #RGB hex codes
				RRGGBB = true,    -- #RRGGBB hex codes
				names = true,     -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		}
	},
	{ 'theniceboy/antovim', lazy = false, },
	{ 'gcmt/wildfire.vim',  lazy = false, },
	{
		"fedepujol/move.nvim",
		config = function()
			local opts = { noremap = true, silent = true }
			-- Normal-mode commands
			vim.keymap.set('n', '<c-y>', ':MoveLine(1)<CR>', opts)
			vim.keymap.set('n', '<c-l>', ':MoveLine(-1)<CR>', opts)

			-- Visual-mode commands
			vim.keymap.set('v', '<c-e>', ':MoveBlock(1)<CR>', opts)
			vim.keymap.set('v', '<c-u>', ':MoveBlock(-1)<CR>', opts)
		end
	},
	{
		"gbprod/substitute.nvim",
		config = function()
			local substitute = require("substitute")
			substitute.setup({
				on_substitute = require("yanky.integration").substitute(),
				highlight_substituted_text = {
					enabled = true,
					timer = 200,
				},
			})
			vim.keymap.set("n", "s", substitute.operator, { noremap = true })
			vim.keymap.set("n", "sh", function() substitute.operator({ motion = "e" }) end, { noremap = true })
			vim.keymap.set("x", "s", require('substitute.range').visual, { noremap = true })
			vim.keymap.set("n", "ss", substitute.line, { noremap = true })
			vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
			vim.keymap.set("x", "s", substitute.visual, { noremap = true })
		end
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async", },
		config = function() require('ufo').setup() end
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
}
