-- 适用于 Neovim 的精美、类似 IDE、高度可定制的 winbar
-- 具有下拉菜单支持和多个后端

-- 这个文件实现了一个名为dropbar的插件的配置。dropbar插件提供了一个下拉菜单，可以从一个选项列表中选择。
-- 该插件通过定义一些按键映射和回调函数来实现交互逻辑。
-- 其中: <Leader>;按键用于打开下拉菜单并选择选项，<CR>按键用于确认选择，<esc>按键用于关闭菜单，q按键用于关闭菜单，n按键用于关闭菜单，<MouseMove>事件用于更新鼠标悬停的选项。此外，还可以通过配置参数来自定义插件的行为。

return {
  "Bekaboo/dropbar.nvim",
  -- commit = "19011d96959cd40a7173485ee54202589760caae",
  event = "VeryLazy",
  enabled = false,
  keys = {
    {
      "<Leader>;",
      function()
        local api = require("dropbar.api")
        api.pick()
      end,
      desc = "Pick from a list of options",
    },
    -- {
    --   "[c",
    --   function()
    --     local api = require("dropbar.api")
    --     api.goto_context_start()
    --   end,
    --   desc = "Go to the start of the current context",
    -- },
    -- {
    --   "]c",
    --   function()
    --     local api = require("dropbar.api")
    --     api.goto_context_end()
    --   end,
    --   desc = "Go to the next context",
    -- },
  },
  config = function()
    local api = require("dropbar.api")
    local confirm = function()
      local menu = api.get_current_dropbar_menu()
      if not menu then
        return
      end
      local cursor = vim.api.nvim_win_get_cursor(menu.win)
      local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
      if component then
        menu:click_on(component)
      end
    end

    local quit_curr = function()
      local menu = api.get_current_dropbar_menu()
      if menu then
        menu:close()
      end
    end

    require("dropbar").setup({
      menu = {
        -- When on, automatically set the cursor to the closest previous/next
        -- clickable component in the direction of cursor movement on CursorMoved
        quick_navigation = true,
        ---@type table<string, string|function|table<string, string|function>>
        keymaps = {
          ["<LeftMouse>"] = function()
            local menu = api.get_current_dropbar_menu()
            if not menu then
              return
            end
            local mouse = vim.fn.getmousepos()
            if mouse.winid ~= menu.win then
              local parent_menu = api.get_dropbar_menu(mouse.winid)
              if parent_menu and parent_menu.sub_menu then
                parent_menu.sub_menu:close()
              end
              if vim.api.nvim_win_is_valid(mouse.winid) then
                vim.api.nvim_set_current_win(mouse.winid)
              end
              return
            end
            menu:click_at({ mouse.line, mouse.column }, nil, 1, "l")
          end,
          ["<CR>"] = confirm,
          ["i"] = confirm,
          ["<esc>"] = quit_curr,
          ["q"] = quit_curr,
          ["n"] = quit_curr,
          ["<MouseMove>"] = function()
            local menu = api.get_current_dropbar_menu()
            if not menu then
              return
            end
            local mouse = vim.fn.getmousepos()
            if mouse.winid ~= menu.win then
              return
            end
            menu:update_hover_hl({ mouse.line, mouse.column - 1 })
          end,
        },
      },
    })
  end,
  -- config = true,
}
