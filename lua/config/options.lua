-- theniceboy defaults.lua config

vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.ttyfast = true
vim.o.autochdir = true
vim.o.exrc = true
vim.o.secure = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.list = true
vim.o.listchars = "tab:|\\ ,trail:▫"
vim.o.scrolloff = 4
vim.o.ttimeoutlen = 0
vim.o.timeout = false
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ""
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.formatoptions = vim.o.formatoptions:gsub("tc", "")
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.inccommand = "split"
vim.o.completeopt = "longest,noinsert,menuone,noselect,preview"
vim.o.completeopt = "menuone,noinsert,noselect,preview"
-- vim.o.lazyredraw = true
vim.o.visualbell = true
vim.o.colorcolumn = "100"
vim.o.updatetime = 100
vim.o.virtualedit = "block"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h" })

vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

vim.g.terminal_color_0 = "#000000"
vim.g.terminal_color_1 = "#FF5555"
vim.g.terminal_color_2 = "#50FA7B"
vim.g.terminal_color_3 = "#F1FA8C"
vim.g.terminal_color_4 = "#BD93F9"
vim.g.terminal_color_5 = "#FF79C6"
vim.g.terminal_color_6 = "#8BE9FD"
vim.g.terminal_color_7 = "#BFBFBF"
vim.g.terminal_color_8 = "#4D4D4D"
vim.g.terminal_color_9 = "#FF6E67"
vim.g.terminal_color_10 = "#5AF78E"
vim.g.terminal_color_11 = "#F4F99D"
vim.g.terminal_color_12 = "#CAA9FA"
vim.g.terminal_color_13 = "#FF92D0"
vim.g.terminal_color_14 = "#9AEDFE"
vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
]])

vim.cmd([[hi NonText ctermfg=gray guifg=grey10]])

-- Innei options.lua config

local opt = vim.opt

vim.api.nvim_set_hl(0, "ICursorColor", {
	bg = "#7dd3fc",
	fg = "#000000",
})

if vim.g.neovide ~= nil then
	opt.clipboard = "unnamedplus"
end

opt.signcolumn = "yes:1"
opt.wrap = true
opt.clipboard = ""
-- opt.laststatus = 0
opt.spelllang = "en,cjk"
-- vim.opt.spell = true
opt.spelloptions = "camel"
opt.scrolloff = 10
opt.indentexpr = ""
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99
opt.guicursor =
	"n:block,i-ci-ve-v-c:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-ICursorColor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

if vim.g.neovide then
	vim.g.neovide_padding_right = 5
	vim.g.neovide_padding_left = 5
	vim.o.guifont = "ComicShannsMono Nerd Font Mono:h14"
	-- vim.g.neovide_transparency = 0.0
	-- vim.g.transparency = 0.8
	-- vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_input_use_logo = 1
	vim.g.neovide_floating_blur_amount_x = 12.0
	vim.g.neovide_floating_blur_amount_y = 12.0
end
