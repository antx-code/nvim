-- 这个文件是一个 Lua 脚本，它的功能是配置自动会话管理和持久化功能。让我们来看一下它的实现逻辑。
-- 首先，这个文件返回了一个 Lua 表（table），其中包含了一些配置项。每个配置项都是一个 Lua 表，表示一个插件或功能的配置。
-- 在这个文件中，我们可以看到两个配置项。第一个配置项是关于自动会话管理的，使用了名为 "auto-session" 的插件。在这个配置项中，我们可以看到一个名为 setup 的函数调用，用于设置自动会话管理的参数。
-- 在 setup 函数中，我们可以看到一些配置参数，比如 log_level 表示日志级别，auto_session_suppress_dirs 表示需要忽略的目录列表。这些参数可以根据需要进行调整。
-- 除了配置参数外，我们还可以看到一些被注释掉的代码块。这些代码块是一些函数定义，用于在保存会话之前执行一些命令（pre_save_cmds）或在恢复会话之后执行一些命令（post_restore_cmds）。这些命令可以根据需要进行自定义。
-- 总结起来，这个文件的功能是配置自动会话管理和持久化功能。它使用了名为 "auto-session" 的插件，并提供了一些配置参数和可自定义的命令执行逻辑。

return {
  {
    "rmagatti/auto-session",
    enabled = false,
    config = function()
      -- local function close_neo_tree()
      --   require("neo-tree.sources.manager").close_all()
      -- end
      --
      -- local function open_neo_tree()
      --   vim.cmd([[<esc>:Neotree reveal<cr>]])
      -- end

      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/LazyVimProjects", "~/Downloads", "/" },
        -- bypass_session_save_file_types = {
        --   "neo-tree",
        --   "tsplayground",
        --   "query",
        -- },
        -- pre_save_cmds = {
        --   close_neo_tree,
        -- },
        -- post_restore_cmds = {
        --   open_neo_tree,
        -- },
      })
    end,
  },
  -- {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre",
  --   opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
  --   config = function()
  --     require("persistence").setup({
  --       options = {
  --         "globals",
  --       },
  --       pre_save = function()
  --         vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
  --       end,
  --     })
  --   end,
  --   keys = {
  --     {
  --       "<leader>qs",
  --       function()
  --         require("persistence").load()
  --       end,
  --       desc = "Restore Session",
  --     },
  --     {
  --       "<leader>ql",
  --       function()
  --         require("persistence").load({ last = true })
  --       end,
  --       desc = "Restore Last Session",
  --     },
  --     {
  --       "<leader>qd",
  --       function()
  --         require("persistence").stop()
  --       end,
  --       desc = "Don't Save Current Session",
  --     },
  --   },
  -- },
}
