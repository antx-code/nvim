return {
	"tomtom/tcomment_vim",
	event = "BufRead",
	config = function()
		vim.g.tcomment_maps = true
		vim.g.tcomment_textobject_inlinecomment = ""

		vim.cmd([[
            nmap <LEADER>cn g>c
            vmap <LEADER>cn g>
            nmap <LEADER>cu g<c
            vmap <LEADER>cu g<
        ]])

		if pcall(vim.api.nvim_get_keymap("n"), "ic") then
			vim.api.nvim_del_keymap("n", "ic")
		end
	end,
}
