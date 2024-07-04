-- Neovim 的调试适配器协议客户端实现

-- 这个文件是一个Lua模块，用于配置和设置调试器插件。它使用了nvim-dap插件和其他相关插件来提供调试功能。
-- 实现逻辑如下：
	-- 1. 首先，定义了一个名为compile的函数，用于保存当前文件并根据文件类型编译C或C++文件。
	-- 2. 然后，返回一个包含插件配置的表。
	-- 3. 在配置表中，首先配置了mfussenegger/nvim-dap插件，并指定了一些依赖插件。
	-- 4. 在config函数中，首先引入了dap和dapui模块，并调用了它们的setup函数进行初始化。
	-- 5. 接下来，配置了一些按键映射，用于调用调试器的不同功能，如设置断点、继续执行、单步跳过等。
	-- 6. 然后，设置了一些高亮和符号定义，用于在编辑器中显示调试相关的信息。
	-- 7. 配置了dap.adapters.codelldb，指定了调试器的类型和端口，并设置了调试器的可执行文件路径。
	-- 8. 最后，配置了不同文件类型的调试配置，如C、C++和Rust，并使用dap-install模块进行配置。
-- 总体来说，这个文件的功能是配置和设置调试器插件，以便在Neovim编辑器中进行代码调试。

local compile = function()
	vim.cmd("write")
	local filetype = vim.bo.filetype
	if filetype == "cpp" or filetype == "c" then
		os.execute("gcc " .. vim.fn.expand("%") .. " -g -o " .. vim.fn.expand("%<"))
	end
end
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"ravenxrz/DAPInstall.nvim",
				config = function()
					local dap_install = require("dap-install")
					dap_install.setup({
						installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
					})
				end
			},
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

			local m = { noremap = true }
			vim.keymap.set("n", "<leader>'t", dap.toggle_breakpoint, m)
			vim.keymap.set("n", "<leader>'v", require('dap.ui.widgets').hover, m)
			vim.keymap.set("n", "<leader>'n", function()
				compile()
				dap.continue()
			end, m)
			vim.keymap.set("n", "<leader>'s", dap.step_over, m)
			local widgets = require('dap.ui.widgets')
			vim.keymap.set("n", "<leader>'q", dap.terminate, m)
			vim.keymap.set("n", "<leader>'u", dapui.toggle, m)

			vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#ffffff', bg = '#FE3C25' })

			vim.fn.sign_define('DapBreakpoint',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointCondition',
				{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointRejected',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapLogPoint', {
				text = '',
				texthl = 'DapLogPoint',
				linehl = 'DapLogPoint',
				numhl = 'DapLogPoint'
			})
			vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

			dap.adapters.codelldb = {
				type = 'server',
				port = "${port}",
				executable = {
					command = vim.g.codelldb_path,
					args = { "--port", "${port}" },
				}
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						local exe = vim.g.c_debug_program or vim.fn.expand("%:r")
						return vim.fn.getcwd() .. '/' .. exe
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			local dap_install = require("dap-install")
			dap_install.config("codelldb", {})
		end
	}
}
