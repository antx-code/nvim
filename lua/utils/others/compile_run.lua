local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end

local compileRun = function()
	vim.cmd("w")
	-- check file type
	local ft = vim.bo.filetype
	if ft == "markdown" then
		vim.cmd(":InstantMarkdownPreview")
	elseif ft == "c" then
		split()
		vim.cmd("term gcc % -o %< && ./%< && rm %<")
	elseif ft == "javascript" then
		split()
		vim.cmd("term node %")
	elseif ft == "lua" then
		split()
		vim.cmd("term luajit %")
	elseif ft == "python" then
		split()
		vim.cmd("term poetry run python3 %")
	elseif ft == "go" then
		split()
		vim.cmd("term go run %")
	elseif ft == "rust" then
		split()
		vim.cmd("term cargo run")
	end
end

vim.keymap.set("n", "r", compileRun, { silent = true })
