-- 根据提供的代码，这个文件似乎是一个 Lua 脚本，用于配置一些插件的功能和快捷键绑定。具体来说，它配置了两个插件：nvim-pack/nvim-spectre 和 cshuaimin/ssr.nvim。
-- 首先，代码使用了 Lua 的表（table）来组织配置信息。每个插件都表示为一个表项，包含插件的名称和其他配置选项。例如，第一个插件 "nvim-pack/nvim-spectre" 配置了一个命令 cmd = "Spectre"，以及一些选项 opts 和快捷键绑定 keys。
-- 在 keys 中，有两个快捷键绑定的定义。第一个绑定 <leader>sr 是一个函数，当按下该快捷键时，会调用 require("spectre").open() 函数，打开一个文件替换的界面。第二个绑定 <leader>sp 也是一个函数，当按下该快捷键时，会调用 require("spectre").open_file_search({ select_word = true }) 函数，在当前文件中进行搜索。
-- 第二个插件 "cshuaimin/ssr.nvim" 配置了一个快捷键绑定 <M-f>，当按下该快捷键时，会调用 require("ssr").open() 函数，打开一个搜索和替换的界面。此外，还定义了一个可选的配置函数 config，在该函数中对插件进行了进一步的配置，包括界面的样式和按键映射等。
-- 总的来说，这个文件的功能是配置两个插件的功能和快捷键绑定。第一个插件提供了文件替换和文件搜索的功能，而第二个插件提供了搜索和替换的功能。通过定义快捷键绑定，用户可以方便地调用这些功能。

return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
      {
        "<leader>sp",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search on current file",
      },
    },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<M-f>",
        function()
          require("ssr").open()
        end,
        desc = "Search and replace",
      },
    },
    -- Calling setup is optional.
    config = function()
      require("ssr").setup({
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      })
    end,
  },
}
