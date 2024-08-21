-- 根据提供的代码，这个文件是一个 Lua 脚本，用于配置和设置 fzf-lua 插件。fzf-lua 是一个在 Vim 编辑器中使用 fzf（模糊查找工具）的插件，它提供了在文件、缓冲区和其他内容中进行快速模糊搜索的功能。
-- 这个 Lua 脚本定义了一个名为 m 的变量，它是一个包含 noremap = true 键值对的表。然后，它返回一个包含配置信息的表。
-- 在配置表中，首先指定了要使用的插件名称 "ibhagwan/fzf-lua"，并将其设置为禁用状态（enabled = false）。然后，定义了触发模糊搜索的按键 <c-r>。
-- 接下来，定义了两个按键映射函数，分别用于在普通模式和可视模式下触发模糊搜索。这些函数使用了 fzf-lua 提供的 fzf.grep 和 fzf.grep_visual 方法来执行模糊搜索操作。
-- 在配置表的其余部分，设置了一些全局选项和按键映射。其中，winopts 表定义了 fzf 窗口的选项，如高度、宽度、预览布局等。keymap 表定义了按键映射，包括内置按键映射和 fzf 按键映射。
-- 最后，配置了预览器选项，包括头部预览器、git 差异预览器、man 页面预览器和内置预览器。还配置了文件和缓冲区选项，包括文件搜索选项和缓冲区搜索选项。
-- 总体来说，这个 Lua 脚本通过配置 fzf-lua 插件的各种选项和按键映射，实现了在 Vim 编辑器中使用 fzf 进行模糊搜索的功能。

local m = { noremap = true }
return {
  "ibhagwan/fzf-lua",
  enabled = true,
  keys = { "<c-r>" },
  config = function()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<c-r>", function()
      -- fzf.live_grep_resume({ multiprocess = true, debug = true })
      fzf.grep({ search = "", fzf_opts = { ["--layout"] = "default" } })
    end, m)
    vim.keymap.set("x", "<c-r>", function()
      -- fzf.live_grep_resume({ multiprocess = true, debug = true })
      fzf.grep_visual({ fzf_opts = { ["--layout"] = "default" } })
    end, m)
    fzf.setup({
      global_resume = true,
      global_resume_query = true,
      winopts = {
        height = 1,
        width = 1,
        preview = {
          layout = "vertical",
          scrollbar = "float",
        },
        fullscreen = true,
        vertical = "down:45%", -- up|down:size
        horizontal = "right:60%", -- right|left:size
        hidden = "nohidden",
      },
      keymap = {
        builtin = {
          ["<c-f>"] = "toggle-fullscreen",
          ["<c-r>"] = "toggle-preview-wrap",
          ["<c-p>"] = "toggle-preview",
          ["<c-y>"] = "preview-page-down",
          ["<c-l>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["esc"] = "abort",
          ["ctrl-h"] = "unix-line-discard",
          ["ctrl-k"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-n"] = "beginning-of-line",
          ["ctrl-a"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
          ["ctrl-e"] = "down",
          ["ctrl-u"] = "up",
        },
      },
      previewers = {
        head = {
          cmd = "head",
          args = nil,
        },
        git_diff = {
          cmd_deleted = "git diff --color HEAD --",
          cmd_modified = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
          -- pager        = "delta",      -- if you have `delta` installed
        },
        man = {
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
        },
      },
      files = {
        -- previewer      = "bat",          -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt = "Files❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
      },
    })
  end,
}
