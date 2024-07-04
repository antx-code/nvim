-- ChatGPT Neovim 插件：使用 OpenAI 的 ChatGPT API 轻松生成自然语言
-- ChatGPT 是一个 Neovim 插件，可让您轻松利用 OpenAI ChatGPT API，使您能够直接在编辑器中从 OpenAI 的 ChatGPT 生成自然语言响应，以响应您的查询。

-- 这个文件是一个Lua模块，它返回一个包含配置信息的表。根据提供的代码，这个文件的功能是设置ChatGPT.nvim插件的配置。
-- 在这个文件中，首先通过调用require("chatgpt").setup()函数来设置ChatGPT插件的配置。setup()函数接受一个包含配置选项的表作为参数。在这个例子中，配置选项被定义在openai_params字段中。
-- openai_params字段是一个包含了ChatGPT插件与OpenAI API交互所需的参数的表。这些参数包括模型名称、频率惩罚、存在惩罚、最大令牌数、温度、top-p值和n值。
-- 在这个例子中，模型名称被设置为"gpt-3.5-turbo"，频率惩罚和存在惩罚被设置为0，最大令牌数被设置为4095，温度被设置为0.2，top-p值被设置为0.1，n值被设置为1。
-- 此外，还可以看到在配置中引入了一些依赖项，如"MunifTanjim/nui.nvim"、"nvim-lua/plenary.nvim"和"nvim-telescope/telescope.nvim"。这些依赖项可能是ChatGPT插件所需的其他Lua模块或插件。
-- 总结起来，这个文件的功能是设置ChatGPT.nvim插件的配置，包括与OpenAI API的交互参数和其他依赖项的引入。

return {

    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      commit = "2107f7037c775bf0b9bff9015eed68929fcf493e",
      config = function()
        local home = vim.fn.expand("$HOME")
        require("chatgpt").setup({
          api_key_cmd = "cat " .. home .. "/.openai.key",
          openai_params = {
            -- NOTE: model can be a function returning the model name
            -- this is useful if you want to change the model on the fly
            -- using commands
            -- Example:
            -- model = function()
            --     if some_condition() then
            --         return "gpt-4-1106-preview"
            --     else
            --         return "gpt-3.5-turbo"
            --     end
            -- end,
            model = "gpt-3.5-turbo",
            frequency_penalty = 0,
            presence_penalty = 0,
            max_tokens = 4095,
            temperature = 0.2,
            top_p = 0.1,
            n = 1,
          }
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
  }
  