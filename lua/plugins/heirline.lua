-- Heirline.nvim 是一个严肃的 Neovim Statusline 插件，围绕递归继承而设计，速度非常快且用途广泛。

-- 这个文件是一个 Lua 脚本，它实现了一个名为 "heirline" 的插件。该插件用于定制和美化状态栏（statusline）和状态列（statuscolumn）。
-- 该插件的实现逻辑如下：
  -- 1. 首先，定义了一系列的局部函数和变量，用于实现状态栏和状态列的各个组件。
  -- 2. 然后，定义了一些状态栏和状态列的组件，比如文件图标、文件名、文件类型、Git 状态等。
  -- 3. 接着，定义了一些辅助函数，用于获取颜色配置、设置状态栏和状态列的样式等。
  -- 4. 最后，通过调用 require("heirline").setup(config) 来设置状态栏和状态列的样式和行为。
-- 总体来说，该插件的功能是为状态栏和状态列提供了一套可定制的组件和样式，使用户能够根据自己的需求来美化和定制状态栏和状态列的显示。

return {
  "rebelot/heirline.nvim",
  enabled = false,
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    --- Blend two rgb colors using alpha
    ---@param color1 string | number first color
    ---@param color2 string | number second color
    ---@param alpha number (0, 1) float determining the weighted average
    ---@return string color hex string of the blended color
    local function blend(color1, color2, alpha)
      if color1 == nil then
        return
      end
      color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
      color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
      local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
      local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")
      local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
      local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
      local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
      return "#"
        .. string.format("%02x", math.min(255, math.max(r, 0)))
        .. string.format("%02x", math.min(255, math.max(g, 0)))
        .. string.format("%02x", math.min(255, math.max(b, 0)))
    end

    local function dim(color, n)
      return blend(color, "#000000", n)
    end

    local icons = {
      -- ✗   󰅖 󰅘 󰅚 󰅙 󱎘 
      close = "󰅙 ",
      dir = "󰉋 ",
      lsp = " ", --   
      vim = " ",
      debug = " ",
    }

    local function setup_colors()
      return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,

        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
      }
    end

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,
      static = {
        mode_names = {
          n = "N",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "V",
          vs = "Vs",
          V = "V_",
          Vs = "Vs",
          ["\22"] = "^V",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "I",
          ic = "Ic",
          ix = "Ix",
          R = "R",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "C",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
      },
      provider = function(self)
        return icons.vim .. "%2(" .. self.mode_names[self.mode] .. "%)"
      end,
      --    
      hl = function(self)
        local color = self:mode_color()
        return { fg = color, bold = true }
      end,
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
      init = function(self)
        self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
        if self.lfilename == "" then
          self.lfilename = "[No Name]"
        end
        if not conditions.width_percent_below(#self.lfilename, 0.27) then
          self.lfilename = vim.fn.pathshorten(self.lfilename)
        end
      end,
      hl = function()
        if vim.bo.modified then
          return { fg = utils.get_highlight("Directory").fg, bold = true, italic = true }
        end
        return "Directory"
      end,
      flexible = 2,
      {
        provider = function(self)
          return self.lfilename
        end,
      },
      {
        provider = function(self)
          return vim.fn.pathshorten(self.lfilename)
        end,
      },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = " ● ", --[+]",
        hl = { fg = "green" },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
      },
    }

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
      FileIcon,
      FileName,
      unpack(FileFlags),
    }

    local FileType = {
      provider = function()
        return string.upper(vim.bo.filetype)
      end,
      hl = "Type",
    }

    local FileEncoding = {
      provider = function()
        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= "utf-8" and enc:upper()
      end,
    }

    local FileFormat = {
      provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= "unix" and fmt:upper()
      end,
    }

    local FileSize = {
      provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { "b", "k", "M", "G", "T", "P", "E" }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize <= 0 then
          return "0" .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
      end,
    }

    local FileLastModified = {
      provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
        return (ftime > 0) and os.date("%c", ftime)
      end,
    }

    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      provider = "%7(%l/%3L%):%2c %P",
    }

    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { "LspAttach", "LspDetach", "WinEnter" },
      provider = icons.lsp .. "LSP",
      -- provider  = function(self)
      --     local names = {}
      --     for i, server in pairs(vim.lsp.bufget_clients({ bufnr = 0 })) do
      --         table.insert(names, server.name)
      --     end
      --     return " [" .. table.concat(names, " ") .. "]"
      -- end,
      hl = { fg = "green", bold = true },
      on_click = {
        name = "heirline_LSP",
        callback = function()
          vim.schedule(function()
            vim.cmd("LspInfo")
          end)
        end,
      },
    }

    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,
      on_click = {
        callback = function(self, minwid, nclicks, button)
          vim.defer_fn(function()
            vim.cmd("Lazygit %:p:h")
          end, 100)
        end,
        name = "heirline_git",
        update = false,
      },
      hl = { fg = "orange" },
      {
        provider = function(self)
          return " " .. self.status_dict.head
        end,
        hl = { bold = true },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = "(",
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ("+" .. count)
        end,
        hl = "diffAdded",
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ("-" .. count)
        end,
        hl = "diffDeleted",
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ("~" .. count)
        end,
        hl = "diffChanged",
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ")",
      },
    }

    local WorkDir = {
      init = function(self)
        self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. icons.dir
        local cwd = vim.fn.getcwd(0)
        self.cwd = vim.fn.fnamemodify(cwd, ":~")
        if not conditions.width_percent_below(#self.cwd, 0.27) then
          self.cwd = vim.fn.pathshorten(self.cwd)
        end
      end,
      hl = { fg = "blue", bold = true },
      on_click = {
        callback = function()
          vim.cmd("Neotree toggle")
        end,
        name = "heirline_workdir",
      },
      flexible = 1,
      {
        provider = function(self)
          local trail = self.cwd:sub(-1) == "/" and "" or "/"
          return self.icon .. self.cwd .. trail .. " "
        end,
      },
      {
        provider = function(self)
          local cwd = vim.fn.pathshorten(self.cwd)
          local trail = self.cwd:sub(-1) == "/" and "" or "/"
          return self.icon .. cwd .. trail .. " "
        end,
      },
      {
        provider = "",
      },
    }

    local HelpFilename = {
      condition = function()
        return vim.bo.filetype == "help"
      end,
      provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
      end,
      hl = "Directory",
    }

    local TerminalName = {
      -- icon = ' ', -- 
      {
        provider = function()
          local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
          return " " .. tname
        end,
        hl = { fg = "blue", bold = true },
      },
      { provider = " - " },
      {
        provider = function()
          return vim.b.term_title
        end,
      },
    }

    local Spell = {
      condition = function()
        return vim.wo.spell
      end,
      provider = function()
        return "󰓆 " .. vim.o.spelllang .. " "
      end,
      hl = { bold = true, fg = "green" },
    }

    local SearchCount = {
      condition = function()
        return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
      end,
      init = function(self)
        local ok, search = pcall(vim.fn.searchcount)
        if ok and search.total then
          self.search = search
        end
      end,
      provider = function(self)
        local search = self.search
        return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
      end,
      hl = { fg = "purple", bold = true },
    }

    local MacroRec = {
      condition = function()
        return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
      end,
      provider = " ",
      hl = { fg = "orange", bold = true },
      utils.surround({ "[", "]" }, nil, {
        provider = function()
          return vim.fn.reg_recording()
        end,
        hl = { fg = "green", bold = true },
      }),
      update = {
        "RecordingEnter",
        "RecordingLeave",
      },
      { provider = " " },
    }

    -- WIP
    local VisualRange = {
      condition = function()
        return vim.tbl_containsvim({ "V", "v" }, vim.fn.mode())
      end,
      provider = function()
        local start = vim.fn.getpos("'<")
        local stop = vim.fn.getpos("'>")
      end,
    }

    local ShowCmd = {
      condition = function()
        return vim.o.cmdheight == 0
      end,
      provider = ":%3.5(%S%)",
      hl = function(self)
        return { bold = true, fg = self:mode_color() }
      end,
    }

    local Align = { provider = "%=" }
    local Space = { provider = " " }

    local DefaultStatusline = {
      Space,
      Spell,
      WorkDir,
      FileNameBlock,
      { provider = "%<" },
      Space,
      Git,
      Space,
      Align,
      Align,
      LSPActive,
      Space,
      FileType,
      { flexible = 3, { FileEncoding, Space }, { provider = "" } },
      Space,
      Ruler,
      SearchCount,
      Space,
      ScrollBar,
    }

    local InactiveStatusline = {
      condition = conditions.is_not_active,
      { hl = { fg = "gray", force = true }, WorkDir },
      FileNameBlock,
      { provider = "%<" },
      Align,
    }

    local SpecialStatusline = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "^git.*", "fugitive" },
        })
      end,
      FileType,
      { provider = "%q" },
      Space,
      HelpFilename,
      Align,
    }

    local TerminalStatusline = {
      condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
      end,
      hl = { bg = "dark_red" },
      { condition = conditions.is_active, ViMode, Space },
      FileType,
      Space,
      TerminalName,
      Align,
    }

    local StatusLines = {
      hl = function()
        if conditions.is_active() then
          return "StatusLine"
        else
          return "StatusLineNC"
        end
      end,
      static = {
        mode_colors = {
          n = "red",
          i = "green",
          v = "cyan",
          V = "cyan",
          ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
          c = "orange",
          s = "purple",
          S = "purple",
          ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
          R = "orange",
          r = "orange",
          ["!"] = "red",
          t = "green",
        },
        mode_color = function(self)
          local mode = conditions.is_active() and vim.fn.mode() or "n"
          return self.mode_colors[mode]
        end,
      },
      fallthrough = false,
      -- GitStatusline,
      SpecialStatusline,
      TerminalStatusline,
      InactiveStatusline,
      DefaultStatusline,
    }

    local CloseButton = {
      condition = function(self)
        return not vim.bo.modified
      end,
      update = { "WinNew", "WinClosed", "BufEnter" },
      { provider = " " },
      {
        provider = icons.close,
        hl = { fg = "gray" },
        on_click = {
          callback = function(_, minwid)
            vim.api.nvim_win_close(minwid, true)
          end,
          minwid = function()
            return vim.api.nvim_get_current_win()
          end,
          name = "heirline_winbar_close_button",
        },
      },
    }

    local Stc = {
      static = {
        ---@return {name:string, text:string, texthl:string}[]
        get_signs = function()
          -- local buf = vim.api.nvim_get_current_buf()
          local buf = vim.fn.expand("%")
          return vim.tbl_map(function(sign)
            return vim.fn.sign_getdefined(sign.name)[1]
          end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
        end,
        resolve = function(self, name)
          for pat, cb in pairs(self.handlers) do
            if name:match(pat) then
              return cb
            end
          end
        end,

        handlers = {
          ["GitSigns.*"] = function(args)
            require("gitsigns").preview_hunk_inline()
          end,
          ["Dap.*"] = function(args)
            require("dap").toggle_breakpoint()
          end,
          ["Diagnostic.*"] = function(args)
            vim.diagnostic.open_float() -- { pos = args.mousepos.line - 1, relative = "mouse" })
          end,
        },
      },
      -- init = function(self)
      --     local signs = {}
      --     for _, s in ipairs(self.get_signs()) do
      --         if s.name:find("GitSign") then
      --             self.git_sign = s
      --         else
      --             table.insert(signs, s)
      --         end
      --     end
      --     self.signs = signs
      -- end,
      {
        provider = "%s",
        -- provider = function(self)
        --     -- return vim.inspect({ self.signs, self.git_sign })
        --     local children = {}
        --     for _, sign in ipairs(self.signs) do
        --         table.insert(children, {
        --             provider = sign.text,
        --             hl = sign.texthl,
        --         })
        --     end
        --     self[1] = self:new(children, 1)
        -- end,

        on_click = {
          callback = function(self, ...)
            local mousepos = vim.fn.getmousepos()
            vim.api.nvim_win_set_cursor(0, { mousepos.line, mousepos.column })
            local sign_at_cursor = vim.fn.screenstring(mousepos.screenrow, mousepos.screencol)
            if sign_at_cursor ~= "" then
              local args = {
                mousepos = mousepos,
              }
              local signs = vim.fn.sign_getdefined()
              for _, sign in ipairs(signs) do
                local glyph = sign.text:gsub(" ", "")
                if sign_at_cursor == glyph then
                  vim.defer_fn(function()
                    self:resolve(sign.name)(args)
                  end, 10)
                  return
                end
              end
            end
          end,
          name = "heirline_signcol_callback",
          update = true,
        },
      },
      {
        provider = "%=%4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}",
      },
      {
        provider = "%{% &fdc ? '%C ' : '' %}",
      },
      -- {
      --     provider = function(self)
      --         return self.git_sign and self.git_sign.text
      --     end,
      --     hl = function(self)
      --         return self.git_sign and self.git_sign.texthl
      --     end,
      -- },
    }

    vim.o.showcmdloc = "statusline"
    -- vim.o.showtabline = 2

    local config = {

      statusline = StatusLines,
      -- statuscolumn = Stc,
      opts = {
        disable_winbar_cb = function(args)
          if vim.bo[args.buf].filetype == "neo-tree" then
            return
          end
          return conditions.buffer_matches({

            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
          }, args.buf)
        end,
        colors = setup_colors,
      },
    }

    require("heirline").setup(config)

    -- vim.o.statuscolumn = require("heirline").eval_statuscolumn()
    vim.api.nvim_create_augroup("Heirline", { clear = true })

    vim.cmd([[au Heirline FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

    -- vim.cmd("au BufWinEnter * if &bt != '' | setl stc= | endif")

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(setup_colors)
      end,
      group = "Heirline",
    })
  end,
}
