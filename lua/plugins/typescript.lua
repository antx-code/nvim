-- jose-elias-alvarez/typescript.nvim: 一个用TypeScript编写的Lua插件，用于编写TypeScript（Lua可选）。
-- 一个最小的 typescript-language-server 集成插件，用于通过 nvim-lspconfig 设置语言服务器并添加命令以方便使用。用 TypeScript 编写并使用 TypeScriptToLua 转换为 Lua。

-- 这个文件是一个Lua脚本，用于配置和设置一个名为typescript.nvim的插件。该插件是用TypeScript编写的，用于在Neovim编辑器中编写TypeScript代码（也可以是Lua代码）。
-- 该文件的实现逻辑如下：
  -- 1. 首先，通过一个条件判断if true then来创建一个匿名函数，然后立即返回一个空的Lua表{}。这样做的目的是为了确保在条件为真时返回一个空表，以避免在后续代码中出现错误。
  -- 2. 接下来，返回一个包含插件配置的Lua表。该表中包含一个插件的名称jose-elias-alvarez/typescript.nvim，以及一个名为config的函数。
  -- 3. 在config函数中，调用了一个名为require的Lua函数，用于加载名为typescript的模块，并调用其setup函数进行配置。
  -- 4. 在setup函数的参数中，设置了一个名为server的表，其中包含了一个on_attach字段。on_attach字段是一个函数，当LSP客户端与缓冲区（文件）关联时被调用。在这个函数中，可以执行一些与LSP客户端关联的操作。
  -- 5. 在on_attach函数中，调用了vim.lsp.buf.inlay_hint函数，用于在编辑器中显示类型提示。
  -- 6. 在server表中，还设置了一个名为settings的表，用于配置LSP服务器的行为。在settings表中，分别为javascript和typescript设置了一些特定的配置项，包括是否显示类型提示等。
-- 总结起来，这个文件的功能是配置和设置typescript.nvim插件，以便在Neovim编辑器中编写TypeScript代码时提供类型提示和其他功能。

if true then
  return {}
end
return {
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            -- your other on_attach stuff here if you have any
            -- ...
            vim.lsp.buf.inlay_hint(bufnr, true)
          end,
          settings = {
            -- specify some or all of the following settings if you want to adjust the default behavior
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
      })
    end,
  },
}
