-- 这个文件是一个 Lua 脚本，用于配置和设置 Swift 语言的开发环境。它使用了一个名为 xbase 的插件，并配置了一些 LSP（Language Server Protocol）功能，以提供代码补全、跳转到定义、重命名等功能。
-- 让我们逐步分析这个文件的实现逻辑：
  -- 1. 首先，Lua 脚本返回了一个包含一个表的表达式，这个表包含了配置信息和设置。
  -- 2. 在这个表中，我们可以看到 ft 键，它的值是一个包含字符串 "swift" 的表。这表明这个配置适用于 Swift 文件。
  -- 3. 接下来，我们看到了 run 键，它的值是一个字符串 "make install"。这表示在配置完成后，执行命令 make install 来安装相关的依赖。
  -- 4. 在 dependencies 键中，我们可以看到一个包含字符串的表，这些字符串是其他插件的名称。这些插件是 neovim/nvim-lspconfig、nvim-telescope/telescope.nvim、nvim-lua/plenary.nvim 和 stevearc/dressing.nvim。这些插件是可选的，可以根据需要进行安装。
  -- 5. 在 config 键中，我们可以看到一个函数。这个函数用于配置 LSP 和其他相关设置。
  -- 6. 在 config 函数中，首先调用了 require("xbase").setup({})，这是一个用于设置 xbase 插件的函数调用。它可能包含一些默认配置。
  -- 7. 接下来，通过调用 require("cmp_nvim_lsp").default_capabilities()，获取了 LSP 的默认能力。
  -- 8. 然后定义了一个名为 on_attach 的函数，它会在 LSP 客户端连接到缓冲区时被调用。在这个函数中，定义了一系列键映射，用于绑定不同的 LSP 功能。
  -- 9. 在 on_attach 函数中，使用了 vim.lsp.buf 对象来调用不同的 LSP 功能，例如重命名、代码操作、跳转到定义等。
  -- 10. 在 on_attach 函数的末尾，还定义了一些较少使用的 LSP 功能，例如跳转到声明、类型定义等。
  -- 11. 最后，在 lspconfig 模块中调用了 sourcekit.setup 函数，用于设置 Swift 的 LSP 配置。这个函数接受一个包含能力和根目录的表作为参数。
-- 总结起来，这个文件的功能是配置 Swift 语言的开发环境，包括安装依赖、设置 LSP 功能和键映射。它使用了一些插件和库来提供更好的开发体验和功能支持。

return {
  {
    "xbase-lab/xbase",
    ft = { "swift" },
    run = "make install", -- or "make install && make free_space" (not recommended, longer build time)
    dependencies = {
      "neovim/nvim-lspconfig",
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "nvim-lua/plenary.nvim", -- optional/requirement of telescope.nvim
      -- "stevearc/dressing.nvim", -- optional (in case you don't use telescope but something else)
    },
    config = function()
      require("xbase").setup({}) -- see default configuration bellow
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        nmap("gh", vim.lsp.buf.hover, "Hover Documentation")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
      end

      local lspconfig = require("lspconfig")

      lspconfig.sourcekit.setup({
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern("Package.swift", "*.xcodeproj", ".git"),
      })
    end,
  },
}
