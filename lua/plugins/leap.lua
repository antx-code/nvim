-- 根据代码的结构和注释，这个文件似乎是一个Neovim插件的配置文件，用于实现一些闪烁和跳转的功能。具体来说，它使用了一个名为"folke/flash.nvim"的插件，并定义了一些选项和按键绑定来配置插件的行为。
-- 该插件的功能包括：
	-- 1. 在文本中闪烁标签，以突出显示匹配项。
	-- 2. 在文本中跳转到标签位置。
	-- 3. 在搜索中闪烁标签，以突出显示匹配项。
	-- 4. 在搜索中跳转到标签位置。
	-- 5. 在Treesitter语法树中闪烁标签，以突出显示匹配项。
	-- 6. 在Treesitter语法树中跳转到标签位置。
-- 通过按键绑定，用户可以触发这些功能。
-- 需要注意的是，代码中有一些被注释掉的部分，这些部分可能是以后要添加或修改的功能。

local labels = "arstneiowfuydh"
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			labels = labels,
			-- search = {
			-- 	-- search/jump in all windows
			-- 	multi_window = true,
			-- 	-- search direction
			-- 	forward = true,
			-- 	-- when `false`, find only matches in the given direction
			-- 	wrap = true,
			-- 	---@type Flash.Pattern.Mode
			-- 	-- Each mode will take ignorecase and smartcase into account.
			-- 	-- * exact: exact match
			-- 	-- * search: regular search
			-- 	-- * fuzzy: fuzzy search
			-- 	mode = "fuzzy",
			-- },
			jump = {
				jumplist = true,
				pos = "start", ---@type "start" | "end" | "range"
				history = false,
				register = false,
				nohlsearch = false,
				autojump = false,
				inclusive = nil, ---@type boolean?
			},
			label = {
				uppercase = false,
				exclude = "",
				current = false,
				-- show the label after the match
				after = true, ---@type boolean|number[]
				-- show the label before the match
				before = false, ---@type boolean|number[]
				-- position of the label extmark
				style = "inline", ---@type "eol" | "overlay" | "right_align" | "inline"
				-- flash tries to re-use labels that were already assigned to a position,
				-- when typing more characters. By default only lower-case labels are re-used.
				reuse = "all", ---@type "lowercase" | "all"
				-- for the current window, label targets closer to the cursor first
				distance = true,
				-- minimum pattern length to show labels
				-- Ignored for custom labelers.
				min_pattern_length = 0,
				-- Enable this to use rainbow colors to highlight labels
				-- Can be useful for visualizing Treesitter ranges.
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 8,
				},
			},
			-- 	highlight = {
			-- 		-- show a backdrop with hl FlashBackdrop
			-- 		backdrop = true,
			-- 		-- Highlight the search matches
			-- 		matches = true,
			-- 		-- extmark priority
			-- 		priority = 5000,
			-- 	},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false,
				},
				treesitter = {
					labels = labels,
					jump = { pos = "range" },
					search = { incremental = false },
					label = { before = true, after = true, style = "inline" },
					highlight = {
						backdrop = false,
						matches = false,
					},
				},
				treesitter_search = {
					jump = { pos = "range" },
					search = { multi_window = true, wrap = true, incremental = false },
					remote_op = { restore = true },
					label = { before = true, after = true, style = "inline" },
				},
				-- options used for remote flash
				remote = {
					remote_op = { restore = true, motion = true },
				},
			},
			prompt = {
				enabled = true,
				prefix = { { "⚡", "FlashPromptIcon" } },
				win_config = {
					relative = "editor",
					width = 1, -- when <=1 it's a percentage of the editor width
					height = 1,
					row = -1, -- when negative it's an offset from the bottom
					col = 0, -- when negative it's an offset from the right
					zindex = 1000,
				},
			},
		},
		keys = {
			{
				"<ESC>",
				mode = { "n" },
				function()
					require("flash").jump({
						remote_op = {
							restore = true,
							motion = true,
						},
					})
				end,
				desc = "Flash",
			},
			{
				"tt",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			-- {
			-- 	"r",
			-- 	mode = "o",
			-- 	function()
			-- 		require("flash").remote()
			-- 	end,
			-- 	desc = "Remote Flash",
			-- },
			{
				"/",
				mode = { "o", "x" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Treesitter Search",
			},
			-- {
			-- 	"<c-s>",
			-- 	mode = { "c" },
			-- 	function()
			-- 		require("flash").toggle()
			-- 	end,
			-- 	desc = "Toggle Flash Search",
			-- },
		},
	}
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	config = function()
	-- 		local leap = require('leap')
	-- 		vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
	-- 		-- vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bold = true, nocombine = true, })
	-- 		-- Of course, specify some nicer shades instead of the default "red" and "blue".
	-- 		-- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'red', bold = true, nocombine = true, })
	-- 		-- vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = 'blue', bold = true, nocombine = true, })
	-- 		-- Try it without this setting first, you might find you don't even miss it.
	-- 		leap.opts.highlight_unlabeled_phase_one_targets = true
	-- 		leap.opts.safe_labels = {}
	-- 		leap.opts.labels = { 'a', 'r', 's', 't', 'n', 'e', 'i', 'o', 'w', 'f', 'u', 'y', 'd', 'h' }
	-- 		vim.keymap.set("n", "<ESC>", function()
	-- 			local current_window = vim.fn.win_getid()
	-- 			leap.leap { target_windows = { current_window } }
	-- 		end)
	-- 	end
	-- }
}
